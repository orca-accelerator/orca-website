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

# JupyterLab and Jupyter Notebook
**JupyterLab** is a modern interface that allows users to work with multiple documents (including Jupyter notebooks, text editors, terminals, and more) in a flexible, integrated environment tailored to their project.
**Jupyter Notebook** offers an interactive environment for combining code, visualizations, and narrative text.
This page explains how users can manage their own environments and use them within Jupyter.

For more information about the differences between JupyterLab and Jupyter Notebook (and which is best for your project), [see this Jupyter community forum thread](https://discourse.jupyter.org/t/jupyter-notebook-vs-jupyter-lab-vdf-jupyterhub-whats-the-diff/475).

## Set Up Python Virtual Environment
Connect to an Open OnDemand desktop at https://orca.pdx.edu/docs/open-ondemand/.
Then start a terminal and run the following command:
```bash {title="Orca Shell"}
$ module load python
$ python --version
Python 3.14.0
```
### Create a Virtual Environment
First, you will need a name for your environment.
In this example, we will use the name 'myproj'.
Then, run the following commands:
```bash {title="Orca Shell"}
$ python -m venv myproj
$ source myproj/bin/activate
```
**Where 'myproj' is, replace it with your environment's name.**
### Install Project-Specific Packages
To install project-specific packages, run the following command:
```bash {title="Orca Shell"}
$ pip install --upgrade pip
$ pip install pandas  # for example
$ pip install torch torchvision # if needed
```
### Create the IPython Kernel
To use your environment from within Jupyter, you need to create and register an IPython Kernel (ipykernel).
```bash {title="Orca Shell"}
$ pip install ipykernel
$ python -m ipykernel install --user --name myproj --display-name "Python (myproj)"
```
From there, you can log out of the OnDemand Desktop if you want to.

## Start Jupyter Notebook or Lab

From the Open OnDemand screen at https://openondemand.orca.pdx.edu/, select 'Jupyter Lab' or 'Jupyter Notebook' from the Interactive Apps pull down menu.
[![Links for 'Jupyter Lab and 'Jupyter Notebook' are listed under the 'Interactive Apps' tab on the Open OnDemand start page.](orca-jupyter-notebook-01.png)](orca-jupyter-notebook-01.png)

Enter the number of cores GPUs you think you will need for your project and click 'launch'.
[![Jupyter Notebook launch page including the number of hours and GPUs needed for your project.](orca-jupyter-notebook-02.png)](orca-jupyter-notebook-02.png)

The next screen will show the status of the job, when it is ready click the connect button.
[![Jupyter Notebook status page with the button 'Connect to Jupyter' on the lower left-hand corner below 'Session ID'.](orca-jupyter-notebook-03.png)](orca-jupyter-notebook-03.png)

## Connect to an Existing Python Virtual Environment

Use the 'New' pulldown in the upper right corner of the notebook screen to select the Python kernel you created above.
[![Kernels are found under the 'New' button on the Jupyter Notebook homepage.](orca-jupyter-notebook-04.png)](orca-jupyter-notebook-04.png)

If you open an existing notebook, Jupyter will prompt for the kernel to use.
[![In the pop-up message titled 'Select Kernel', click on the desired kernel from the drop down menu. Then, click 'Select' in the lower right-hand corner of the pop-up message.](orca-jupyter-notebook-05.png)](orca-jupyter-notebook-05.png)

In Jupyter Lab, the available kernels will be displayed in the 'Notebook' section of the 'Launcher' tab on the screen.
[![Kernels are found under the 'Notebook' header at the top of the 'Launcher' tab.](orca-jupyter-lab-01.png)](orca-jupyter-lab-01.png)
