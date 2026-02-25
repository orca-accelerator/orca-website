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

## Set Up Python Virtual Environment
Connect to an Open OnDemand desktop from https://orca.pdx.edu/docs/open-ondemand/.
Then start a terminal and run the following command:
``` shell
$ module load python
$ python --version
Python 3.14.0
```
### Create a Virtual Environment
First, have a name for your environment. Then, run the following command:
``` shell
$ python -m venv myproj
$ source myproj/bin/activate
```
**Where 'myproj' is, replace it with your environment's name.**
### Install Project-Specific Packages
To install project-specific packages, run the following command:
``` shell
$ pip install --upgrade pip
$ pip install pandas  # for example
$ pip install torch torchvision # if needed
$ pip install ipykernel
```
### Create the Ipykernel Mapping
To create the ipykernel mapping, run the following command:
``` shell
$ python -m ipykernel install --user --name myproj --display-name "Python (myproj)"
```
From there, you can log out of the OnDemand Desktop if you want to.

## Start Jupyter Notebook or Lab

From the Open OnDemand screen at https://openondemand.orca.pdx.edu/, select 'Jupyter Lab' or 'Jupyter Notebook' from the Interactive Apps pull down menu.
![Links for 'Jupyter Lab and 'Jupyter Notebook' are listed under the 'Interactive Apps' tab on the Open OnDemand start page.](images/orca-jupyter-notebook-small-01.png)

Enter the number of cores GPUs you think you will need for your project and click 'launch'.
![Jupyter Notebook launch page including the number of hours and GPUs needed for your project.](orca-jupyter-notebook-small-02.png)

The next screen will show the status of the job, when it is ready click the connect button.
![Jupyter Notebook status page with the button 'Connect to Jupyter' on the lower left-hand corner below 'Session ID'.](orca-jupyter-notebook-small-03.png)

## Connect to an Existing Python Virtual Environment

Use the 'New' pulldown in the upper right corner of the notebook screen to select the Python kernel you created above.  
![Kernels are found under the 'New' button on the Jupyter Notebook homepage.](orca-jupyter-notebook-small-04.png)
![In the pop-up message titled 'Select Kernel', click on the desired kernel from the drop down menu. Then, click 'Select' in the lower right-hand corner of the pop-up message.](website/content/docs/images/orca-jupyter-notebook-small-05.png)

In Jupyter Lab, the available kernels will be displayed in the 'Notebook' section of the 'Launcher' tab on the screen.
![Kernels are found under the 'Notebook' header at the top of the 'Launcher' tab.](images/orca-jupyter-lab-small-01.png)
