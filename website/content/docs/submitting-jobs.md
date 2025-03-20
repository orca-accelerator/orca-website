---
title: "Submitting Jobs"
weight: 10
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Submitting Jobs

## Slurm Workload Manager

Orca uses the [Slurm Workload Manager](https://slurm.schedmd.com/) for job control and management.
Slurm allows you to submit jobs that run on the compute nodes.
Using Slurm, you can run an [**interactive session**](#interactive-sessions) or submit [**batch jobs**](#batch-jobs).

{{< notice note >}}
For a detailed introduction to Slurm, visit the [Slurm Quick Start User Guide](https://slurm.schedmd.com/quickstart.html).
{{< /notice >}}

## Interactive Sessions

Starting an interactive session allows you to interact with the compute node the same way that you interact with the login node.
For example, you can request a single-core interactive session for 20 minutes by running the command
```
salloc --ntasks=1 --time=20
```
You may have to wait until the requested resources are available.
Once they are available, you will see the message "Granted job allocation", and will be presented with a shell on the compute node.
At this point, you can run commands interactively, making use of the CPUs and GPUs on Orca's compute nodes.
When you are done, running `exit` from the shell will return you to the login node, and free up the resources on the compute node for others to use.

## Batch Jobs

## Checking the Queue and Other Slurm Commands

* `squeue` - Report the state of jobs or job steps. This is useful view check what’s in the current job queue, especially if you’re going to submit a larger job using many nodes.
* `sinfo` - Report the state of partitions and nodes managed by Slurm. There are a number of filtering, sorting, and formatting options.
* `scancel` - Cancel a submitted job (pending or running).


## Partitions

The Orca cluster has four partitions to which jobs can be submitted.

- `short` - jobs are limited to 4 hours.
- `medium` - this is the default partition. If you don’t specify a partition, your job will run here. Jobs are limited to 7 days.
- `long` - allows long running jobs up to 20 days.
- `interactive` - allows interactive jobs. This can be useful for remote visualization tasks and interactive applications. Jobs can be up to 2 days.

The sinfo command will display an overview of partitions:
```
sinfo --long --Node
```

{{< notice note >}}
For more information, see the PSU Research Computing documentation on the [Slurm Scheduler](https://sites.google.com/pdx.edu/research-computing/getting-started/slurm-scheduler) and [Slurm parallelism](https://sites.google.com/pdx.edu/research-computing/faqs/coeus-hpc-faqs/slurm-parallelism).
{{< /notice >}}
