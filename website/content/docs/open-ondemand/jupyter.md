---
title: "Jupyter"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# JupyterLab and Jupyter Notebooks

## Set up Python virtual environment
Connect to an Open OnDemand desktop from https://orca.pdx.edu/docs/open-ondemand/.
Then start a terminal and do the following.
``` shell
$ module load python
$ python --version
Python 3.14.0
```
### Create a virtual environment
``` shell
$ python -m venv myproj
$ source pyproj/bin/activate
```
### Install project specific packages
``` shell
$ pip install --upgrade pip
$ pip install pandas  # for example
$ pip install torch torchvision # if needed
$ pip install ipykernel
```
### Create the ipykernel mapping
``` shell
$ python -m ipykernel install --user --name myproj --display-name "Python (myproj)"
```
You can logout of the desktop now if you want to.

## Start Jupyter notebook or lab

## Connect to an existing Python virtual environment