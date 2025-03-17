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

# ORCA Spack

=====

Spack is a tool from Lawrence Livermore National Labs for managing scientific research applications, packages and libraries.  This is the description from the [Spack page](https://spack.io/about/),

"Spack is a package manager for [supercomputers](https://en.wikipedia.org/wiki/Supercomputer), Linux.  It makes installing scientific software easy. With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine."

Make sure to review the documentation and tutorials at the [Spack web site](https://spack.readthedocs.io/en/latest/index.html).

Here at Research Computing we have installed Spack at /software/spack/spack.  Many of the software modules provided on the ORCA cluster were built using Spack.

Run the commands below to initialize Spack for your personal use, i.e. build software in your home directory for your specific needs.  These are the first few steps in the [Spack tutorial](https://spack-tutorial.readthedocs.io/en/latest/tutorial_basics.html#).

``` script
$ git clone --depth=2 --branch=releases/v0.23 https://github.com/spack/spack.git ~/spack
$ source ~/spack/share/spack/setup-env.sh
```

We have standardized on gcc 13.2.0 for use on ORCA cluster nodes.

Now you will need to enable gcc@13.2.0 for your Spack environment.  Make sure the file $HOME/.spack/linux/compilers.yaml contains the following.
``` yaml
compilers:
- compiler:
    spec: gcc@=13.2.0
    paths:
      cc: /software/builds/compilers/gcc/13.2.0/bin/gcc
      cxx: /software/builds/compilers/gcc/13.2.0/bin/g++
      f77: /software/builds/compilers/gcc/13.2.0/bin/gfortran
      fc: /software/builds/compilers/gcc/13.2.0/bin/gfortran
    flags: {}
    operating\_system: rocky9
    target: x86\_64
    modules: []
    environment: {}
    extra\_rpaths: []
```

Now install a package, but before installing a package in your instance of spack make sure it does not exist as a module already, i.e. run 'module available'.

You will install netcdf here as an example, since it is used in a lot of geo and climate research data.
``` script
$ spack list netcdf %gcc@13.2.0
netcdf-c    netcdf-cxx4     netcdf95         py-h5netcdf
netcdf-cxx  netcdf-fortran  parallel-netcdf  py-netcdf4
==> 8 packages
$ spack install netcdf-c netcdf-cxx netcdf-fortran
```

You will see the various netcdf versions and dependencies installed into your $HOME/spack/opt path.

