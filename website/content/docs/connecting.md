---
title: "Connecting"
weight: 2
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Connecting and Logging in

You can connect to Orca in two ways:

1. Via `ssh` (secure shell) using a terminal application.
2. Using [Open OnDemand]({{< ref "docs/open-ondemand.md" >}}), a web-based interface.

## Secure Shell (`ssh`)

You can connect to Orca using `ssh` (secure shell) run through a terminal application.
If you use Linux, Mac OS, or recent versions of Windows, a terminal application is included with the operating system.
Windows users may also consider using [MobaXterm](https://mobaxterm.mobatek.net) or [PuTTY](https://www.putty.org).

You can connect to Orca by running `ssh username@login.orca.pdx.edu`, replacing `username` with your Orca username.

## Login Node

The Orca login node is the where the users interface with the file system, scheduler, and other tools.
The Orca login node can be accessed at `login.orca.pdx.edu`.

{{< notice warning >}}
Do not run long computational jobs on the login node.
These are for logging in, accessing your home directory, accessing file systems, writing and editing files, compressing and uncompressing data sets, scheduling computational jobs, etc.
Computational jobs should be run on compute nodes, through the [Slurm job scheduler]({{< ref "docs/submitting-jobs" >}}).
Long computational process running on login nodes are liable to be terminated without notification.
{{< /notice >}}

### Authentication with SSH Keys

## Open OnDemand

See the [documentation on OpenOnDemand]({{< ref "docs/open-ondemand.md" >}}).
