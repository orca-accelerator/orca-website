# Orca Website

This is the repository for the Orca (Oregon Regional Computing Accelerator) website.
This website will be published at https://orca.pdx.edu.

## Building

The website is a static site built using the [Hugo](https://gohugo.io) static site generator.
Building the site requires Hugo, which can be installed using your system's package manager (on Mac, run `brew install hugo`).

To build the website, first clone the repository, and then checkout the required submodules (e.g. the themes) by running

```
git submodule update --init --recursive
```

The website can then be built with the command

```
hugo -s website
```

Note that the flag `-s website` tells Hugo that the root of the website is in the `website` directory.
You can also `cd` to the `website` directory and run simply `hugo`.

The `hugo serve` command can be used to run a local web server which will perform a live refresh when the content changes.

## Creating a new page

You can create a new page using the `hugo new content` command, for example, from within the `website` directory,

```
hugo new content content/docs/docs/storage.md
```
