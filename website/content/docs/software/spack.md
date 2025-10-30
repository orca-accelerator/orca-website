---
title: "Spack"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Using Spack on Orca

## About Spack

[Spack](https://spack.io) is a tool from Lawrence Livermore National Laboratory for managing scientific research applications, packages and libraries.
From its [about page](https://spack.io/about/):

> Spack is a package manager for [supercomputers](https://en.wikipedia.org/wiki/Supercomputer) [...]
> It makes installing scientific software easy.
> With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine.

Spack has been used to build many of the modules available on the Orca cluster.
This document describes how to use Spack to build a custom user environment for a specific purpose or project goal.

Refer to the [Spack tutorial](https://spack-tutorial.readthedocs.io/en/latest/tutorial_basics.html#), for more
detail.

## Using Spack on Orca

Spack is provided as a [module]({{< ref "modules" >}}) on Orca. To use Spack, first load the module by running
```bash
module load spack
```

As an example, we can install [NetCDF](https://www.unidata.ucar.edu/software/netcdf/), which is commonly used in climate research.
To list the available NetCDF packages in Spack, run:

```bash
$ spack list netcdf
netcdf-c    netcdf-cxx4     netcdf95         pdiplugin-decl-netcdf  py-netcdf4
netcdf-cxx  netcdf-fortran  parallel-netcdf  py-h5netcdf
==> 9 packages
```

It is best to use an environment within your Spack install, which will group project-specific packages together.
This way, you can use the same Spack installation for multiple projects.

To create and activate an environment, run:
```bash
spack env create myproject
spack env activate myproject
```

Now, we can add the NetCDF packages to the environment and install them by running:

```bash
$ spack add netcdf-c netcdf-cxx netcdf-fortran
$ spack install
```

Run `spack find` and you should see the NetCDF packages and their dependencies, installed into `~/.spack/opt`.

## Orca's Spack Configuration

When using Spack on Orca through the provided module, Orca's Spack configuration is automatically loaded.
This configuration can be found in the directory `/software/spack/defaults/config/`.

This will configure Spack to see the "upstream" Spack packages, which are installed at the cluster level, and available to all users as modules.
This way, dependencies that are already installed on the cluster do not need to be re-installed in your Spack environment.

Spack packages that you install will be installed in your home directory, under `~/.spack/`.
