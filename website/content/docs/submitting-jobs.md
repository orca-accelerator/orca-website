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
In both cases, you can [specify which resources](#specifying-job-resources) (CPUs, GPUs, memory) you need to run your job.

{{< notice note >}}
For a detailed introduction to Slurm, visit the [Slurm Quick Start User Guide](https://slurm.schedmd.com/quickstart.html).
{{< /notice >}}

## Specifying Job Resources

Each job you submit (whether it is an interactive or batch job) should specify the resources needed by the job.
These resources include: number of CPU cores, number (and type) of GPUs, memory, and time limit.
These can be specified either via command-line arguments (to `salloc` for [interactive jobs](#interactive-sessions)) or via batch script options (for [submitting batch jobs](#batch-jobs)).

{{< notice info >}}
Unless explicitly requested, jobs on Orca will not have access to GPUs and will be allocated only one CPU core per node.
To request more resources, use the options as described below.
{{< /notice >}}

| Resource | Option | Notes |
| --- | --- | --- |
| CPU Cores | `--ntasks=<num>` | To request `<num>` CPU cores total for the job (or shorthand `-n <num>`). |
| GPUs | `--gres=gpu:<num>` | To request `<num>` GPUs per node. Specific GPUs can be specified via `--gres=gpu:l40s:<num>` or `--gres=gpu:a30:<num>`. |
| Memory (Per Node) | `--mem=<size>[unit]` | `unit` is one of `K`, `M`, `G`, `T` (for KB, MB, GB, and TB; defaults to MB if omitted). The special case `--mem=0` requests all the memory on each node. |
| Memory (Per CPU Core) | `--mem-per-cpu=<size>[unit]` | `unit` is as above. |
| Nodes | `--nodes=<num>` | To request `<num>` nodes (or shorthand `-N <num>`). **Note:** by default, each node will only be allocated 1 CPU core (out of 64 per node). To request more CPU cores, specify also `--ntasks`. |
| Time | `--time=<min>` | For a time limit of `<min>` minutes (or shorthand `-t <min>`). |
{.no-wrap-col-2}

### Examples

The following examples show how to request an interactive session with a variety of resources.

* To request a job with 10 CPU cores
   * `salloc --ntasks=10`
* To request a job with access to one GPU
   * `salloc --gres=gpu:1`
* To request all the cores and memory on a single node (`--mem=0` requests all the memory per node)
   * `salloc --nodes=1 --ntasks=64 --mem=0`
* To request a single L40S GPU
   * `salloc --gres=gpu:l40s:1`
* To request eight A30 GPUs across two compute nodes (with one CPU core per GPU)
   * `salloc --nodes=2 --gres=gpu:a30:4 --cpus-per-gpu=1`

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

{{< about >}}
For more information, see the PSU Research Computing documentation on the [Slurm Scheduler](https://sites.google.com/pdx.edu/research-computing/getting-started/slurm-scheduler) and [Slurm parallelism](https://sites.google.com/pdx.edu/research-computing/faqs/coeus-hpc-faqs/slurm-parallelism).
{{< /about >}}

## Running Parallel Jobs

Once you have an allocation, you can run parallel (MPI) jobs using the `srun` command to launch parallel jobs.
The number of MPI ranks is supplied through the `--ntasks` or `-n` flag.
Note that commands such as `mpirun` and `mpiexec` are **not available** on Orca, and `srun` should be used instead.

### Binding GPUs to Parallel Jobs

To use one GPU per MPI rank, `srun` should be supplied with the option `--gpu-bind=single:1`.
For example, on a single-node allocation with 4 GPUs and 4 CPU cores, `srun -n 4 --gpu-bind=single:1 <command>` will uniquely bind each of the GPUs to a different MPI rank.
As an illustration, `srun -n 4 --gpu-bind=single:1 nvidia-smi -L` will print out the unique IDs of the GPUs assigned to each MPI rank.
