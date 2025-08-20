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

[Spack](https://spack.io) is a tool from Lawrence Livermore National Laboratory for managing scientific research applications, packages and libraries.
This is the description from its [about page](https://spack.io/about/):

> Spack is a package manager for [supercomputers](https://en.wikipedia.org/wiki/Supercomputer) [...]
> It makes installing scientific software easy.
> With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine.

Spack has been used to build many of the modules available on the Orca cluster.  This document describes how to 
use Spack to build a custom user environment for a specific purpose or project goal.

Refer to the [Spack tutorial](https://spack-tutorial.readthedocs.io/en/latest/tutorial_basics.html#), for more
detail.

However, we have already provided a mirror cache of many packages such as gcc, cmake, R, and others.  This mirror will be used automatically for your package builds.

To setup your local Spack environment.

```bash
$ git clone --branch=releases/v1.0 https://github.com/spack/spack.git ~/spack
$ source ~/spack/share/spack/setup-env.sh
```
It is best to use an environment within you Spack install, this way you can use the same Spack installation for multiple projects.  

To create and activate an environment.
```
spack env create myproject
spack activate myproject
```

We have standardized on gcc 13.4.0 for use on ORCA cluster nodes, which can be
built as part of your project, after you create and activate your environment as above, by doing
```
spack add gcc@13.4.0
spack buildcache install -fu gcc@13.4.0
```
<!--
Running the command
```
spack compilers add
```
will find available compilers via the path.  For example if you prefer the Intel
OneAPI icc compiler, make sure you load the module so the compiler is in the path
and the compilers add above will find it.
Make sure the file `~/.spack/linux/compilers.yaml` contains the following.
```yaml
compilers:
- compiler:
    spec: gcc@=13.2.0
    paths:
      cc: /software/builds/compilers/gcc/13.2.0/bin/gcc
      cxx: /software/builds/compilers/gcc/13.2.0/bin/g++
      f77: /software/builds/compilers/gcc/13.2.0/bin/gfortran
      fc: /software/builds/compilers/gcc/13.2.0/bin/gfortran
    flags: {}
    operating_system: rocky9
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
```
-->

Now you can use Spack to install packages.
Before installing a package, make sure it does not exist as a module already
by checking the results of `module available`.

As an example, we can install [NetCDF](https://www.unidata.ucar.edu/software/netcdf/), which is commonly used in climate research.
```bash
$ spack list netcdf %gcc@13.4.0
netcdf-c    netcdf-cxx4     netcdf95         py-h5netcdf
netcdf-cxx  netcdf-fortran  parallel-netcdf  py-netcdf4
==> 8 packages
$ spack add netcdf-c netcdf-cxx netcdf-fortran
$ spack buildcache install -fu netcdf-c netcdf-cxx netcdf-fortran
```

Run 
```
spack find
```
And you should see the various NetCDF versions and dependencies installed into `~/spack/opt`.
