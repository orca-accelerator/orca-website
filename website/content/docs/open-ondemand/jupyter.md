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
$ source myproj/bin/activate
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

From the Open OnDemand screen at https://openondemand.orca.pdx.edu/, select Jupyter Lab or Jupyter Notebook from the Interactive Apps pull down menu.

Enter the number cores and number of GPU you think you will need for your project and click launch.

The next screen will show the status of the job, when it is ready click the connect button.

## Connect to an existing Python virtual environment

Use the "New" pulldown in the upper right corner of the notebook screen to select the Python kernel you created above.  

In Jupyter Lab the available kernels will be displayed in the Notebook section of the Launcher tab on the screen.