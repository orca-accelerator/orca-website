---
title: "Compute Resources"
weight: 3
# bookFlatSection: false
bookToc: false
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Compute Resources

The Orca cluster features 25 GPU-enabled compute nodes, each with 4 GPUs.
Six nodes have Nvidia L40S GPUs, and 19 nodes have Nvidia A30 GPUs.

All nodes have 64 core AMD EPYC Genoa 9534 2.45 GHz CPUs with 576 GB RAM and 480 GB SSD for local scratch storage.


| Nodes          | Quantity | GPUs               | CPU cores | CPU                          | RAM    |
|----------------|----------|--------------------|-----------|------------------------------|--------|
| orca01-orca06  | 6        | 4x L40S (24 total) | 64        | AMD EPYC Genoa 9534 2.45 GHz | 576 GB |
| orca07-orca25  | 19       | 4x A30 (76 total)  | 64        | AMD EPYC Genoa 9534 2.45 GHz | 576 GB |

## GPU Specifications

Orca has **24 L40S GPUs** and **76 A30 GPUs**.
The specifications are summarized below.
The L40S GPUs have **more memory** per GPU, and **much higher FP32 performance**.
However, L40S does not support FP64 in hardware, meaning that applications that depend on double precision may be slower.

More information can be found on the Nvidia datasheets:

* [L40S datasheet](https://resources.nvidia.com/en-us-l40s/l40s-datasheet-28413)
* [A30 datasheet](https://www.nvidia.com/content/dam/en-zz/Solutions/data-center/products/a30-gpu/pdf/a30-datasheet.pdf)

|                  | L40S          | A30           |
|------------------|---------------|---------------|
| Architecture     | Ada Lovelace  | Ampere        |
| GPU Memory       | 48 GB         | 24 GB         |
| Memory Bandwidth | 864 GB/s      | 933 GB/s      |
| FP64 FLOPS       | ---           | 5.2 TFLOPS    |
| FP32 FLOPS       | 91.6 TFLOPS   | 10.3 TFLOPS   |
| MIG              | Not supported | 4 MIGs @ 6 GB |
