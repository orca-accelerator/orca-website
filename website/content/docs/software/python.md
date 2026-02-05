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

```bash {title="Orca Shell"}
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
In this example, the environment is named `my-python-env`; you can pick any name for your project.

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
For example, running

```bash
(my-python-env) $ pip install numpy pandas matplotlib
```

will install the `numpy`, `pandas`, and `matplotlib` packages.
These packages will be available from within the `my-python-env` environment, but not from within any other environment.

Once you are done working in the environment, you can run the `deactivate` command to deactivate the current environment.

## Using Python with `uv`

`uv` is a very fast and modern Python environment and package manager.
It can be used to manage different versions of Python, create virtual environments, and install packages.
`uv` is available through a module, and can be loaded by running `module load uv`.
Different versions of Python can be installed using `uv`.
For example, `uv python install 3.11` will install version 3.11 of Python, which will then be available from `~/.local/bin/python3.11`.
See the [`uv` documentation](https://docs.astral.sh/uv/reference/) for more information.

## Using Python with Slurm

Python can benefit from the parallelism on the Orca cluster in two ways:

1. Several copies of the same Python script (with different options or operating on different data) an be run in parallel, as a job array.
2. The Python script itself can be parallelized using MPI and `mpi4py`.

### 1. Python with a Slurm Job Array

Setting up a job array is a way to run a number of copies of the same program.
Each copy of the program can have different options, or operate on different data.
For more information on job arrays can be [found here](https://sites.google.com/pdx.edu/research-computing/faqs/coeus-hpc-faqs/job-arrays).

As an example, consider a Python script that takes a number on the command line, and prints its square.

```python {filename="print_square.py"}
import sys
value = int(sys.argv[1])
print(sys.argv[1], "squared =", value*value)
```

We can set up a job array to run multiple copies of this script, each with a different number.
This can be achieved through a [Slurm batch script]({{< ref "submitting-jobs" >}}#batch-jobs).

```bash {filename="submit.sh"}
#!/bin/bash
#SBATCH --job-name job_array_python  # Job name.
#SBATCH --partition short    # Use a short partition since this is not a long running job.
#SBATCH --ntasks 1           # Allocate one CPU core per subtask.
#SBATCH --output out-%a.txt  # Specify that standard output should go.
#SBATCH --error err-%a.txt   # Specify where error output should go.
#SBATCH --array=0-3          # Run multiple copies of the script, indexed from 0 to 3.

module load python
python print_square.py $SLURM_ARRAY_TASK_ID
```

The batch job can then be submitted to Slurm:

```bash {title="Orca Shell"}
$ sbatch submit.sh
```
The sbatch script `submit.sh` uses a job array to run 4 copies (subtasks) of the script `print_square.py`.
Each copy of the script will have a different command line argument, corresponding to the job array task ID, which is a numeric value in the range specified in the batch script header.
After completion, the output of these jobs will be four files, `0.txt`, `1.txt`, `2.txt`, and `3.txt`.
The contents of each file wil be the output of the Python script, i.e. the square of the task ID.

### 2. Python and MPI with `mpi4py`

Applications can use parallelism on HPC clusters such as Orca to speed up computations and obtain results faster.
One primary way to parallelism Python programs is with `mpi4py`, which is the Python interface to MPI (Message Passing Interface).
For comprehensive information on `mpi4py`, see [the documentation](https://mpi4py.readthedocs.io/en/stable/).

To use `mpi4py`, we need to install the `mpi4py` Python package.
We will do this in a [virtual environment using `venv`](#virtual-environments-using-venv).
Create the venv (called `mpi4py-example` in this case) and install the package by running

```bash {title="Orca Shell"}
$ python3 -m venv mpi4py-example
$ source mpi4py-example/bin/activate
(mpi4py-example) $ pip install mpi4py
```

We will now create a simple Python script to illustrate MPI parallelism.

```python {filename="mpi_example.py"}
from mpi4py import MPI
comm = MPI.COMM_WORLD
rank = comm.Get_rank()  # Rank is the process number, starting at 0.
size = comm.Get_size()  # Size is the total number of processes.
print("I am process", rank, "out of", size)
```

This job can be submitted using the following batch script.
**Important:** the virtual environment also needs to be activated from within the batch script.

```bash {filename="submit.sh"}
#!/bin/bash
#SBATCH --job-name mpi4py_example # Job name.
#SBATCH --partition short         # Use a short partition since this is not a long running job.
#SBATCH --ntasks 4                # Allocate four CPU cores to run in parallel.
#SBATCH --output out.txt          # Write output to out.txt.
#SBATCH --error  err.txt          # Write errors to err.txt.

# Load the Python module
module load python
# Activate the virtual environment where mpi4py has been installed
source mpi4py-example/bin/activate

# Run mpi_example.py in parallel using four CPU cores (and four ranks/processes).
mpirun -np 4 python3 mpi_example.py
```

Submit the sbatch script:

```bash {title="Orca Shell"}
$ sbatch submit.sh
```

The output in `out.txt` will be something like the following (but the lines may be ordered differently):

```txt {filename="out.txt"}
I am process 0 out of 4
I am process 1 out of 4
I am process 2 out of 4
I am process 3 out of 4
```

## Using Python with Conda or Mamba

Conda is not generally recommended, however it may be necessary if using packages from specific Conda channels such as `bioconda`.
If Conda-specific packages are not required, users are recommended to use [Python with `venv`](#virtual-environments-using-venv) or [Python with `uv`](#using-python-with-uv) instead.
Conda is available on Orca through the Intel Python distribution.
Loading Intel Python by running `module load intel-python` will make both `conda` and `mamba` available.
See the [documentation on using Conda](https://docs.conda.io/en/latest/), and the [documentation on using Mamba](https://mamba.readthedocs.io/en/latest/) for more information.
