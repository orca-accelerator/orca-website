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
| [Parallel Scratch Storage](#parallel-scratch-storage) | `/scratch/` | Faster | | Not backed up |
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

## Local Scratch

Each compute node comes equipped with a 480 GB SSD.
This is high-performance storage that can be used as a local scratch space to store or access temporary files needed while a job in running.
It is only accessible from within a Slurm job, where it is mounted at `/tmp`.
Each node can only access data on its own SSD; there is no networked access.

{{< notice warning >}}
   Local scratch storage is only available while a job is running.
   **Once the job finishes, any data in local scratch will be immediately deleted.**
{{< /notice >}}

If you need to repeatedly access files in one job, you may want to copy them to local scratch at the beginning of job, from which subsequent access will be fast.
If you need to keep any files from local scratch, they must be copied to another location (your [home directory](#home-directory) or [parallel scratch storage](#parallel-scratch-storage)) before the job finishes.
