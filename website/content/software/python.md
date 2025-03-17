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

This page is concerned with how Python is used on OIT-RC's systems and not how to use Python itself.  For a great Python tutorial, visit [learnpython.org](https://www.learnpython.org/).

## Getting Started

### What's the different between Python 2 and Python 3? What is Conda?

Python 2 is an older version of Python. In general, it is highly recommended to use Python 3 since it has major changes and improvements and has the best support for packages and libraries.

Miniconda is deprecated, use Conda or Mamba from the provided Python distribution. Conda is a virtual environment and package manager for Python.  Conda is not a prefered environment, see Virtual Environments below.

### Loading the Python environment module

Python 3 is installed by default to all Linux machines, so it is available on all of OIT-RC's Linux systems as well.  Again, using Python 2 is highly discouraged, unless it is needed for older code. Upon logging in to a system you can check the python version.

```bash
$ /usr/bin/python --version
Python 3.9.18
```

It is recommended to load the module for python to get the most complete set of math and science libraries.

```bash
$ module load python
$ python --version
Python 3.9.19 :: Intel Corporation
```

The OS provided /usr/bin/python3 will still provide Python 3 but will not have conda or mamba nor all the science, data, and math libraries.

* The python module, which provides /software/python/intel/3.9.19/intelpython3/bin/python, is recommended as it has the best performance and solid support, plus most all math, science, and data packages have been added.

* If some software or package being used requires a certain version of Python 3, then a virtual environment is recommended, either venv or uv, see below.

Virtual Environments
====================

Virtual environments are how individual users can install and load different sets of packages as needed into a small, clean, and self-contained environment that is easy to use for you and others on your project.

Virtual Environment Using `venv` **(Recommended)**
------------------------------------------------

The preferred way of using virtual environments in Python is with the venv package. 

First, a virtual environment (venv) needs to be made (-m) and named anything; here, it is named myPythonEnv.
```bash
$ module load python
$ python -m venv myPythonEnv
```
Next, the venv needs to be activated.  If an sbatch script wants to use a virtual environment, it must have this line in the sbatch script.  An active venv in the shell will have the venv name in parenthesis before the shell prompt symbol ($).
```bash
$ source myPythonEnv/bin/activate
(myPythonEnv) $
```
Once a virtual environment is running, use pip to install needed libraries, generally you will want pandas (includes numpy), scipy, scikit-learn, dask, and ray.
```bash
(myPythonEnv) $ pip install --upgrade pip
(myPythonEnv) $ pip install pyperformance pandas dask ray scipy scikit-learn
```
Finally, when you are done with your session, deactivate the venv.  To deactivate a venv, deactivate is used. Alternatively, if the shell ends or the sbatch script ends, the virtual environment will be deactivated as well.  This has finished once the venv name before the shell prompt will be removed.
```bash
(myPythonEnv) $ deactivate
$
```
Virtual Environment using uv
----------------------------

UV is a Python package manager that provides a choice of python versions and automatically creates and uses a virtual environment.  Do the following to start using UV.
```bash
$ source /software/builds/uv/env
$ mkdir project
$ cd project
$ uv init .
$ uv python install 3.12 # if this is the version needed
$ uv python pin 3.12
$ uv install pandas scipy dask matplotlib # for example
$ uv run myscript.py
```
Virtual Environment using Conda
-------------------------------

An alternative method for creating a virtual environment is using Conda, both the Intel Python and the Miniconda modules provide this capability, however, using Conda to install packages is very slow.

The following example will generally work for both, we will use Intel Python.
```bash
$ module load python
$ conda create -p $HOME/myConda -c conda-forge
$ conda init bash
$ source $HOME/.bashrc
$ conda install pyperformance pandas dask ray scipy scikit-learn
```
Be sure you do not mix conda and pip install commands which can lead to a confused environment.  There is one exception, if a package is only available with pip.

Virtual Environment using Mamba (ADVANCED)
------------------------------------------

Mamba is also made available after doing the module load python step.  Mamba is a faster alternative to using Conda, you can replace the conda commands above with mamba.

Using Python on a Cluster with SLURM
====================================

There is two ways of using Python on a cluster: either having several copies of the same Python script running (like with a job array), or having a Python script use MPI (message passing interface) to communicate between several children.

Python with a SLURM Job Array
-----------------------------

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



Python with MPI: What is mpi4py?
--------------------------------

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
