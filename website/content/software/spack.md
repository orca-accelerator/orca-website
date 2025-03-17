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

> Spack is a package manager for [supercomputers](https://en.wikipedia.org/wiki/Supercomputer), Linux.
> It makes installing scientific software easy.
> With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine.


Spack has been used to build many of the modules available on the Orca cluster.

You can also use Spack to build, install and manage your own software.
Following the [Spack tutorial](https://spack-tutorial.readthedocs.io/en/latest/tutorial_basics.html#), you can run the following commands to setup your local Spack environment.

```bash
$ git clone --depth=2 --branch=releases/v0.23 https://github.com/spack/spack.git ~/spack
$ source ~/spack/share/spack/setup-env.sh
```

We have standardized on gcc 13.2.0 for use on ORCA cluster nodes.

Now you will need to enable `gcc@13.2.0` for your Spack environment.
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

Now you can use Spack to install packages.
Before installing a package, make sure it does not exist as a module already by checking the results of `module available`.

As an example, we can install [NetCDF](https://www.unidata.ucar.edu/software/netcdf/), which is commonly used in climate research.
```bash
$ spack list netcdf %gcc@13.2.0
netcdf-c    netcdf-cxx4     netcdf95         py-h5netcdf
netcdf-cxx  netcdf-fortran  parallel-netcdf  py-netcdf4
==> 8 packages
$ spack install netcdf-c netcdf-cxx netcdf-fortran
```

You will see the various NetCDF versions and dependencies installed into `~/spack/opt`.
