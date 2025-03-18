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

## SLURM Workload Manager

Orca uses the [SLURM Workload Manager](https://slurm.schedmd.com/) for job control and management.
There are a number of  user commands for the scheduler.
For getting started, the most salient commands are  sbatch, squeue, scancel, sinfo, and srun.
<!-- A sample submit script and use of some of these commands is included in the section below “Compiling A Simple MPI Program.” -->
For a detailed introduction to Slurm, visit the [Slurm Quick Start User Guide](https://slurm.schedmd.com/quickstart.html).

- sbatch - Command to submit a job script to the scheduler for execution.  This script typically contains one or more srun commands to launch parallel tasks.
- squeue - This reports the state of jobs or job steps. This is useful view check what’s in the current job queue, especially if you’re going to submit a larger job using many nodes.
- scancel - Allows you to cancel a pending or running job.
- sinfo - This reports the state of partitions and nodes managed by Slurm.  There are a number of filtering, sorting, and formatting options.
- srun - This command is used to submit a job for execution or initiate job steps in real time.  Typically this will be included in an sbatch script.

## Partitions

The Orca cluster has four partitions to which jobs can be submitted.

- `short` - jobs are limited to 4 hours.
- `medium` - this is the default partition.  If you don’t specify a partition, your job will run here.  Jobs are limited to 7 days.
- `long` - allows long running jobs up to 20 days.
- `interactive` - allows interactive jobs.  This can be useful for remote visualization tasks and interactive applications. Jobs can be up to 2 days.

The sinfo command will display an overview of partitions:
```
sinfo --long --Node
```

For more information, see the PSU Research Computing documentation on
- [Slurm Scheduler](https://sites.google.com/pdx.edu/research-computing/getting-started/slurm-scheduler)
- [Slurm parallelism](https://sites.google.com/pdx.edu/research-computing/faqs/coeus-hpc-faqs/slurm-parallelism)

## Batch Jobs

## Interactive Jobs
