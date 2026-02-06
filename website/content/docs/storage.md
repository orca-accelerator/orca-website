---
title: "Storage"
weight: 10
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# File Systems and Data Storage

There are several locations on Orca where you can store your files and data.
The different file systems have different limits (quotas) and performance characteristics, summarized in the following table.

| Location | Path | Performance | Quota | Note |
| -------- | ---- | ----------- | ----- | ---- |
| [Home Directory](#home-directory) | `/home/<username>` | Slow | 100 GB | Backed up nightly |
| [Parallel Scratch Storage](#parallel-scratch-storage) | `/scratch/<workspace>` | Faster | ---                                                    | Not backed up |
| [Local Scratch Storage](#local-scratch) | `/tmp` | Fastest | 480 GB | Deleted when job ends |

## Home Directory

Your home directory (`/home/<username>`, where `<username>` is your Orca username) is on a shared filesystem that is mounted on all cluster nodes.
This should be used to store your batch scripts, configuration files, local compiled software, etc.
Home directories are backed up to tape on a nightly basis.

{{< notice info >}}
   Running calculations on data stored in your home directory will be slow.
   For higher-performance storage, use [scratch storage](#parallel-scratch-storage).
{{< /notice >}}

## Parallel Scratch Storage

Parallel scratch storage is allocated using [HPC Workspaces](https://github.com/holgerBerger/hpc-workspace).

In order to use parallel scratch storage, you must first create a **workspace**.
A workspace is scratch space that expires after a set time (this is because scratch storage is for temporary rather than long-term storage).

### Creating (allocating) a workspace

To create a workspace, run the command `ws_allocate <ws-name> <days>`, where `<ws-name>` is the workspace name, and `<days>` is the number of days before the workspace will expire.
You can give the workspace any name you like (workspace directories are automatically prefixed with your username, so the workspace name does not have to be globally unique).
Running `ws_allocate --help` will show available options for workspace creation.
The maximum number of days before a workspace expires is 30.

Once the workspace is created, it can be accessed at `/scratch/<username>-<workspace-name>`.

### Listing workspaces

You can list all your active workspaces by running `ws_list`.

### Extending a workspace

If your workspace is about to expire, and you want to keep it around for longer, you can **extend** the workspace, by running `ws_extend <ws-name> <days>`.
A workspace may be extended a maximum of five times.

### Sharing a workspace

You can give access to your workspace to other users on Orca using the `ws_share` command.
To give access to a user with username `<user>`, run `ws_share share <ws-name> <user>`.
You can later revoke access with `ws_share unshare <ws-name> <user>`.

## Local Scratch

Each compute node comes equipped with a 480 GB SSD.
This is high-performance storage that can be used as a local scratch space to store or access temporary files needed while a job is running.
It is only accessible from within a Slurm job, where it is mounted at `/tmp`.
Each node can only access data on its own SSD; there is no networked access.

{{< notice warning >}}
   Local scratch storage is only available while a job is running.
   **Once the job finishes, any data in local scratch will be immediately deleted.**
{{< /notice >}}

If you need to repeatedly access files in one job, you may want to copy them to local scratch at the beginning of a job, from which subsequent access will be fast.
If you need to keep any files from local scratch, they must be copied to another location (your [home directory](#home-directory) or [parallel scratch storage](#parallel-scratch-storage)) before the job finishes.
