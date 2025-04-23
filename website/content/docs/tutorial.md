---
title: "Getting Started (Tutorial)"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Getting Started (Tutorial)

## Step 1. Requesting Access to Orca

The first step is to request access to Orca.
See the page on {{< autolink "about/requesting-access.md" >}}.
After your account has been created and actived, continue on to [Step 2](#step-2-connecting-to-orca).

## Step 2. Connecting to Orca

After your Orca account has been provisioned, you can connect to Orca via ssh by running
```
ssh username@login.orca.pdx.edu
```
where `username` is replaced with your Orca username.
See the documentation  on [Connecting to Orca]({{< ref connecting >}}) for more information.

## Step 3. Requesting an Interactive Session

Once you have logged into Orca, you can request an interactive session on a compute node.
For example, the following will request an interactive session for 10 minutes with one CPU core
```
salloc -n 1 -t 10
```
Note that this will only give you access to a single core and no GPUs.
For more information about requesting more resources (including GPUs) and submitting batch jobs, see the documentation on {{< autolink submitting-jobs >}}.

## Step 4. Next Steps

See the other documentation pages on this site:

* [Setting up Python on Orca]({{< ref "software/python.md" >}})
* [Compiling CUDA applications]({{< ref "software/cuda.md" >}})
* [Installing your own packages with Spack]({{< ref "software/spack.md" >}})
* [Using Open OnDemand]({{< ref "open-ondemand.md" >}}) for JupyterLab and other graphical applications
