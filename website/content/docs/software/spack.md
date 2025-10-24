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
This is the description from its [about page](https://spack.io/about/):

> Spack is a package manager for [supercomputers](https://en.wikipedia.org/wiki/Supercomputer) [...]
> It makes installing scientific software easy.
> With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine.

Spack has been used to build many of the modules available on the Orca cluster.  This document describes how to
use Spack to build a custom user environment for a specific purpose or project goal.

Refer to the [Spack tutorial](https://spack-tutorial.readthedocs.io/en/latest/tutorial_basics.html#), for more
detail.

## Setting up Spack on Orca

On Orca, we have provided a mirror cache of many packages such as gcc, cmake, R, and others. This mirror will be used automatically for your package builds.

To download and activate Spack, run the following commands:

```bash
git clone --branch=releases/v1.0 https://github.com/spack/spack.git ~/spack
source ~/spack/share/spack/setup-env.sh
```

Then, copy Orca's default spack configuration to your home directory:

```bash
mkdir -p ~/.spack
cp /software/spack/defaults/.spack/packages.yaml ~/.spack/
cp /software/spack/defaults/.spack/upstreams.yaml ~/.spack/
```

## Spack Environment Tutorial

It is best to use an environment within your Spack install.
This way, you can use the same Spack installation for multiple projects.

To create and activate an environment:
```bash
spack env create myproject
spack env activate myproject
```

Now you can use Spack to install packages.
Before installing a package, make sure it does not exist as a module already by checking the results of `module available`.

As an example, we can install [NetCDF](https://www.unidata.ucar.edu/software/netcdf/), which is commonly used in climate research.
```bash
$ spack list netcdf %gcc@13.4.0
netcdf-c    netcdf-cxx4     netcdf95         py-h5netcdf
netcdf-cxx  netcdf-fortran  parallel-netcdf  py-netcdf4
==> 8 packages
$ spack add netcdf-c netcdf-cxx netcdf-fortran
$ spack install netcdf-c netcdf-cxx netcdf-fortran
```

Run `spack find` and you should see the various NetCDF versions and dependencies installed into `~/spack/opt`.
