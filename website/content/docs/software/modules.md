---
title: "Modules"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Software Modules

Orca provides commonly used software through **environment modules** (using [Lmod](https://lmod.readthedocs.io/en/latest/)).

### Basic module usage

To obtain a complete list of all modules currently available on the system, run

```
module avail
```

To load a module, e.g. the GCC 13.2.0 compilers

```
module load gcc/13.2.0
```

To load a module, e.g. OpenMPI 4.1.4 compiled with GCC 13.2.0.  (this will automatically load the gcc-13.2.0 module) 

```
module load openmpi/4.1.4-gcc-13.2.0
```

To obtain a complete list of currently loaded modules

```
module list
```

which results in output like:

```
Currently Loaded Modulefiles:

 1) gcc/13.2.0                2) openmpi/4.1.4-gcc-13.2.0
```

To unload a module, e.g. OpenMPI 4.1.4 compiled with GCC 13.2.0.  (this will automatically unload the gcc-13.2.0 module, too) 

```
module unload openmpi/4.1.4-gcc-13.2.0
```

## Software

Modules load the selected software on each of these systems, mounted in the /software volume, where there is broad range of available software.  Some software in this volume include:

  + GCC 13.2.0 with earlier versions available
  + Python 3.9 with typical libraries such as numpy, scipy.
  + Blast
  + Matlab, R
  + Latest versions of HDF5, NetCDF4, zlib, cmake, etc
