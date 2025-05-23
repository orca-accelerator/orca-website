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
Currently, to access `login.orca.pdx.edu`, you must be connected to the PSU internal network (either through the campus network or via VPN).

## Login Node

The Orca login node is the where the users interface with the file system, scheduler, and other tools.
The Orca login node can be accessed at `login.orca.pdx.edu`.
The login node does not have a high-performance CPU or any GPUs.
For compute-intensive work, a job should be run on one or more of the compute nodes (see the pages on {{< autolink "submitting-jobs.md" >}}).

{{< notice warning >}}
**Do not run computational jobs on the login node.**
These are for logging in, accessing your home directory, accessing file systems, writing and editing files, compressing and uncompressing data sets, scheduling computational jobs, etc.
Computational jobs should be run on compute nodes, through the [Slurm job scheduler]({{< ref "docs/submitting-jobs" >}}).
Long computational process running on login nodes are liable to be terminated without notification.
{{< /notice >}}

## Authentication with SSH keys

To enable passwordless login, you can use SSH keys, which are a more secure and convenient way of logging in than with a password.
On Linux or mac OS, you can create a new **key pair** with the command `ssh-keygen`.
The key can then be copied to the Orca login node by running
```
ssh-copy-id username@login.orca.pdx.edu
```
where `username` is replaced with your Orca username.
After completing this process, you should be able to login to Orca via ssh without providing your password.

For more information, please see this [detailed tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server) on SSH key authentication.

## Open OnDemand

See the [documentation on Open OnDemand]({{< ref "docs/open-ondemand.md" >}}).
Open OnDemand is currently planned, but is not yet available.
