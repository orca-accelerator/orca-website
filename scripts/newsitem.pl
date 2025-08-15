#!/usr/bin/env perl
use strict;
use warnings;
use POSIX qw(strftime);
use File::Spec;

# Read from file or stdin if no file provided
my $fh;
if (@ARGV) {
    my $input_file = shift;
    open $fh, '<', $input_file or die "Can't open $input_file: $!\n";
} else {
    $fh = *STDIN;
}

# Format:
#
# TITLE
#
# BODY (multiple lines)

chomp(my $title = <$fh> // '');
my @body = <$fh>;
chomp @body;
close $fh unless $fh == \*STDIN;

# strip any leading empty lines
shift @body while @body && $body[0] =~ /^\s*$/;

# get current date (two formats - one Hugo-readable, one for display)
my $date = strftime("%m/%d/%Y", localtime);
my $hugo_date = strftime("%Y-%m-%d", localtime);

# write the output file to website/content/news/<timestamp>.md
my $timestamp = strftime("%Y-%m-%d-%H-%M-%S", localtime);
# determine script directory
my $script_dir = (File::Spec->splitpath(File::Spec->rel2abs($0)))[1];
my $outfile = File::Spec->catfile($script_dir, "..", "website", "content", "news", "$timestamp.md");

# open file
open my $out, '>', $outfile or die "Can't open $outfile: $!\n";

# output
print $out "---\n";
print $out qq{title: "$date - $title"\n};
print $out "bookHidden: true\n";
print $out qq{date: "$hugo_date"\n};
print $out "---\n\n";

print $out "> [!INFO] $date - $title\n";
print $out ">\n";
for my $line (@body) {
    $line =~ s/\s+$//; # remove trailing whitespace
    print $out ">";
    print $out " $line" if $line ne ''; # avoid leading space for empty lines
    print $out "\n";
}

close $out;

print "Wrote output to $outfile\n\n";

# stage the file
system('git', 'add', $outfile) == 0
    or warn "Failed to git-add $outfile\n";

# commit
my $commit_msg = "Added news item: $date - $title";
system('git', 'commit', '-m', $commit_msg) == 0
    or warn "Failed to git-commit $outfile\n";

# prompt user to push
print "\nDo you want to push to remote? [y/N] ";
chomp(my $answer = <STDIN>);
if ($answer =~ /^y(es)?$/i) {
    system('git', 'push') == 0
        or warn "Failed to git-push\n";
} else {
    print "Skipping push.\n";
}
