---
title: "Storage"
weight: 10
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# File Systems and Data Storage

## Orca Home Directory `/home/username`

Your home directory is on a shared filesystem that is mounted on all cluster nodes.
This should be used to store your batch scripts, system configurations, local compiled software, libraries, and config/settings files.
Home directories are backed-up to tape on a nightly basis.
Be advised that running calculations on data living in your home directory will be much slower, just use it to store backups of your data and do the computation on scratch storage.

## Scratch Storage  `/scratch`

Data for your computational work should be put in scratch.
You can create your own personal and group project folders here.
This shared filesystem is mounted on all cluster nodes.
This is a large volume intended for temporary storage of data used in computational processes.
This volume is not backed up and all files stored here are considered to be temporary.  

Scratch is managed with on a modified First In, First Out policy.
The largest consumers of storage are prioritized for deletion and the oldest files are removed first.
Once this volume reaches a certain threshold, you may be asked to remove directories/files.
If this passes a critical threshold, system administrators reserve the right to remove all files.

## Other Volumes

### Research shares ` /vol/share/sharename`

Research storage shares are common to all OIT-RC systems.
These are only mounted on this cluster login nodes, in order to facilitate copying of data to the /scratch volumes.
/vol/share is a good place to move data that should be backed up, for example resultant data from computational runs. Do not run computational jobs against data stored on /vol/share. This volume is backed up.
(PSU access only)
