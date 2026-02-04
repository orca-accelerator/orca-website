---
title: "Python"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Using Python on Orca

Python is a programming language that is easy to learn, easy to use, and easy to integrate with other software.  It is widely used by researchers because of the rich libraries available for math and science.  Python trades performance for ease of development.

This page is concerned with how Python is used on the Orca cluster.
For a great Python tutorial on how to use the Python language itself, visit [learnpython.org](https://www.learnpython.org/).

## Getting Started

### Loading the Python Module

As part of the base Rocky Linux installation, Orca includes Python 3.9.23 by default.
Orca also includes other versions of Python, available through the [module system]({{< ref modules >}}).
To see the available versions of Python, run `module avail python` in the terminal.
```
$ module avail python

--------- /software/spack/v1.0/modules/linux-rocky9-x86_64/gcc/13.4.0 ----------
   python/3.12.9-gcc-13.4.0-5rbfaiu    python/3.13.5-gcc-13.4.0-3crd7yj (D)

---------------------------- /software/modulefiles -----------------------------
   intel-python/24.0.0
```
One of these versions of Python can be loaded by running, for example, `module load python/3.13.5`.
The Intel Python Distribution is also available through the `intel-python` module; this Python distribution includes many commonly used scientific Python packages.

> [!IDEA] Python 3 and Python 2
> Python 2 is an older version of Python.
> In general, it is highly recommended to use Python 3 since it has major changes and improvements and has the best support for packages and libraries.
> Using Python 2 is highly discouraged.

## Installing Python Packages

Individual users can install and use Python packages using **virtual environments**.
Virtual environments are an easy-to-use way to organize different sets of packages into a small, clean, and self-contained environments.
The standard way to create virtual environments and install packages is through `venv`.

### Virtual Environments Using `venv`

To install packages that are needed for a specific project, first create a virtual environment (a "venv").
In this example, the environment is named `my-python-env`; you can pick a relevant name for your project.

```bash
$ python3 -m venv my-python-env
```

After creating the environment, it needs to be **activated**.
To activate an environment, run

```bash
$ source my-python-env/bin/activate
```

To use an environment, it must be activated in every session (for example, in interactive or batch jobs).
After activation, the name of the active environment will appear to the left of your shell prompt.

Once an environment has been activated, you can install packages using `pip`.
For example

```bash
(my-python-env) $ pip install numpy pandas matplotlib
```

will install the `numpy`, `pandas`, and `matplotlib` packages.
These packages will be available from within the `my-python-env` environment, but not from within any other environment.

Once you are done working in the environment, you can run the `deactivate` command to deactivate the current environment.

## Using Python with `uv`

`uv` is a very fast Python package manager and replacement for 'pip', `pipx`, `conda`, and other tools.
It provides a choice of python versions and automatically creates and uses a virtual environment.  Do the following to start using UV.
```bash
$ source /software/builds/uv/env
$ mkdir project
$ cd project
$ uv init .
$ uv python install 3.12 # if this is the version needed
$ uv python pin 3.12
$ uv venv  # create the virtual environment
$ uv pip install pandas scipy dask matplotlib # for example
$ uv run myscript.py
```

## Using Python with Conda

Conda is not recommended, however it may be necessary if using packages from
specific Conda channels such as bioconda.
Conda is available on Orca through the Intel Python distribution.

The following example will generally work for both, we will use Intel Python.
```bash
$ module load intel-python
$ conda create -p $HOME/myConda -c conda-forge
$ conda init bash
$ source $HOME/.bashrc
$ conda install pyperformance pandas dask ray scipy scikit-learn
# 'conda -c bioconda' if you need those libraries.
```
Be sure you do not mix conda and pip install commands which can lead to a confused environment.  There is one exception, if a package is only available with pip.

### Mamba as a Conda Replacement

Mamba is also made available after doing the module load intel-python step.
Mamba is a faster alternative to using Conda, you can safely replace the conda commands
above with mamba.

## Using Python with Slurm

There are two ways of using Python on a cluster: either having several copies of the same Python script running (like with a job array), or having a Python script use MPI (message passing interface) to communicate between several children.

### Python with a Slurm Job Array

A job array is basically having a number of copies of the same program. This is good for running the same tests several times for an average, or for running the same script several times but specifying the argument based off which copy the script is.

For more on job arrays, refer [here](https://sites.google.com/pdx.edu/research-computing/faqs/coeus-hpc-faqs/job-arrays).

Here is an example Python script:
``` python
import sys
value = int(sys.argv[1])
print(sys.argv[1],"squared =", value\*value)
```

This is the corresponding sbatch script (called submit.sh):
```bash
#!/bin/bash
#SBATCH --job-name job\_array\_python  # Specify that the sbatch job's name is job\_array\_python.
#SBATCH --partition short    # Use a short partition since this is not a long running job.
#SBATCH --ntasks 1           # Allocate one task per subtask.
#SBATCH --output out-%a.txt  # Specify that standard output should go.
#SBATCH --error err-%a.txt  # Specify where error output should go.
#SBATCH --array=0-3          # Refer to the link for the job arrays page just above the Python script.

module purge  # Loaded modules can get carried into sbatch script, so clean them out.

module load python

PARAMS=(1 2 3 4)

python mySquarePrinter.py ${PARAMS[$SLURM\_ARRAY\_TASK\_ID]}
```

```bash
$ chmod +x submit.sh
```
Submit the job to slurm.
```bash
$ sbatch submit.sh
```
The Python script mySquarePrinter.py will take the first input argument (that is not the file name) and convert it to an int (from a string). It will then print out the value being squared, then " squared = ", and then the result of the value times itself.

The sbatch script submit.sh then uses a job array to create 4 copies (subtasks) of this script, where each copy requests a single task. Each subtask then runs mySquarePrinter.py with the corresponding data value from $PARAMS.

For more on job arrays, refer [here](https://sites.google.com/pdx.edu/research-computing/faqs/coeus-hpc-faqs/job-arrays).

## Python and MPI with `mpi4py`

mpi4py is a Python package that allows for MPI Python programs.

The site for mpi4py is [here](https://mpi4py.readthedocs.io/en/stable/), which contains more usage documentation.

### Getting Started - Create a Virtual Environment and Install mpi4py

```bash
$ module load mvapich2-2.2-psm/gcc-6.3.0
$ # Refer to the section of this document about creating a virtual environment.
(myPythonEnv) $ pip3 install mpi4py
```

Note that mpich/gcc-6.3.0 can work instead of mvapich2-2.2-psm/gcc-6.3.0. The OpenMpi environment modules will not work with mpi4py.

### Using a Virtual Environment in Python and sbatch Scripts

Here is an example of using a Python virtual environment (venv) with mpi4py installed to make an MPI Python program on SLURM. This assumes the previous subsection has been completed.

Here is the Python script:

```python
#!/usr/bin/env/ python3

from mpi4py import MPI

comm = MPI.COMM\_WORLD

rank = comm.Get\_rank()  # Rank is the process number, starting at 0.

size = comm.Get\_size()  # Size is the number of processes.

print("Hello, World! from process", rank, "of", size)
```

Here is the sbatch submission script:

```bash
#!/bin/bash
#SBATCH --job-name mpi4py\_hello\_world  # Specify that the sbatch job's name is mpi4py\_hellow\_world.
#SBATCH --partition short      # Use a short partition since this is not a long running job.
#SBATCH --ntasks 4             # Allocate four tasks.
#SBATCH --nodes 2              # Specify that all four of the tasks must run on two nodes between themselves.
#SBATCH --output out.txt       # Specify that standard output should go to ./out.txt (and create the file if needed).
#SBATCH --error  err.txt       # Specify that error output should go to ./err.txt (and create the file if needed).

module purge                   # Loaded modules can get carried into sbatch script, so clean them out.
module load mvapich2-2.2-psm/gcc-6.3.0
module load python

source ./myPythonEnv/bin/activate   # Activate the virtual environment.

mpiexec -n 4 python3 hello\_mpi\_python.py  # Create four tasks, each of which runs its own hello\_mpi\_python.py
```
Submit the sbatch script:
```bash
sbatch submit.sh
```
