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
See the page on {{< autolink "about/requesting-access" >}}.
After your account has been created and activated, continue on to [Step 2](#step-2-set-up-ssh-authentication).

## Step 2. Set up SSH Authentication

After account creation, you need to set up an SSH key pair to use with Orca.
If you have an SSH key pair already, [upload the public key to the Orca Registry]({{< ref "about/requesting-access#step-3-upload-ssh-public-key" >}}).
If not, then generate a new key pair by running `ssh-keygen` in the terminal, and then upload the newly generated public key.
See [the documentation on connecting via SSH]({{< ref "connecting/#authentication-with-ssh-keys" >}}) for more information.

## Step 3. Connecting to Orca

After your Orca account has been provisioned and SSH authentication has been set up, you can connect to Orca via ssh by running
```
ssh username@login.orca.pdx.edu
```
where `username` is replaced with your Orca username.
See the documentation  on [Connecting to Orca]({{< ref connecting >}}) for more information.

## Step 4. Requesting an Interactive Session

Once you have logged into Orca, you can request an interactive session on a compute node.
For example, the following will request an interactive session for 10 minutes with one CPU core
```
salloc -n 1 -t 10
```
Note that this will only give you access to a single core and no GPUs.
For more information about requesting more resources (including GPUs) and submitting batch jobs, see the documentation on {{< autolink submitting-jobs >}}.

## Step 5. Next Steps

See the other documentation pages on this site:

* [Setting up Python on Orca]({{< ref "software/python.md" >}})
* [Compiling CUDA applications]({{< ref "software/cuda.md" >}})
* [Installing your own packages with Spack]({{< ref "software/spack.md" >}})
* [Using Open OnDemand]({{< ref "open-ondemand.md" >}}) for JupyterLab and other graphical applications
