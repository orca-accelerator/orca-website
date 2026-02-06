---
title: "CUDA"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# CUDA

[CUDA](https://developer.nvidia.com/cuda-zone) is the parallel computing platform and programming model used by Nvidia GPUs, such as the [L40S and A30 GPUs]({{< ref "about/compute-resources.md" >}}) found in Orca's compute nodes.

CUDA is available on Orca as a [module]({{< ref "modules.md" >}}).
To load CUDA, run `module load cuda`.
This will make available CUDA tools such as the CUDA compiler `nvcc` and the Nsight profilers `nsys` and `ncu`.

## Using GPUs

In order to use Orca's GPUs, they must be [requested as part of a Slurm job]({{< ref submitting-jobs >}}).
The number and type of GPUs can be specified using Slurm's generic resource (`gres`) scheduling.

### Seeing Allocated GPUs

On a compute node, to see the available GPUs in the allocation, run the command `nvidia-smi`.
If `nvidia-smi` does not report any GPUs, it may be because GPUs were not requested as part of your job.
See the page on [submitting jobs]({{< ref "submitting-jobs#specifying-job-resources" >}}) for more details.

## Compiler Options and GPU Architectures

When using `nvcc` to compile your code for Nvidia GPUs, you must specify the architecture you want to target.
If you don't specify anything, `sm_52` will be used, which will work on all GPUs on Orca, but may not give optimal performance.
**For best performance, compile for the specific GPU architecture you are targeting.**
Since Orca has two types of GPUs, you may compile your code to **target both types of GPUs in one binary**.

Each Nvidia GPU has "_virtual compute architecture_" and a "_real GPU architecture_" (also sometimes called its "gencode").
The architectures for Orca's GPUs are listed in the table below.

| GPU   | Family | Virtual Compute Architecture | Real GPU Architecture |
|-------|--------|------------------------------|-----------------------|
| A30   | Ampere | `compute_80`                 | `sm_80`               |
| L40S  | Ada    | `compute_89`                 | `sm_89`               |

{{< notice note >}}
Code compiled for both `compute_80` and `compute_89` will give optimal performance on both types of GPUs.

**To compile your code for both architectures in one binary, pass the following flags to `nvcc`**

```
-gencode=arch=compute_80,code=sm_80 -gencode=arch=compute_89,code=sm_89
```
{{< /notice >}}

The L40S GPUs belong to a newer "Ada" family of GPUs.
These GPUs can support the older `compute_80` virtual architecture, whereas the A30 GPUs (belonging to the "Ampere" family) do not support the newer `compute_89` architecture.
This means that applications targeting `compute_80` will work for both types of GPUs, but applications targeting `compute_89` will work only on L40S and not on A30.

The following table summarizes the GPU architecture options for `nvcc`.
On Orca, it is recommended to use either `-gencode=arch=compute_80,code=sm_80 -gencode=arch=compute_89,code=sm_89` or `-arch=sm_80`.

| Flag   | Description |
|-----------------------------------------------|-----------------------|
| `-gencode=arch=compute_80,code=sm_80 -gencode=arch=compute_89,code=sm_89` | Compiles code for **both** L40S and A30 GPU architectures, **optimal performance for both** |
| `-arch=sm_80` | Optimal performance on A30, potentially slightly suboptimal performance on L40S |
| `-arch=sm_89` | Optimal performance on L40S, **will not work on A30** |
| Default (equivalent to `-arch=sm_52` ) | **Suboptimal performance, not recommended** |
