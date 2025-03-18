ORCA HPC cluster

* Software
  + [Modules](/software/modules)
  + [Python](/software/python)
  + [Spack](/software/spack)
  + [SLURM Scheduler](/software/slurm-scheduler)


ORCA HPC Cluster
=================

Gaining Access and Connecting
=============================

Request an account
------------------

The ORCA cluster is a grant-funded resource provided through the National Science Foundation and hosted at Portland State University.
<!--- FIX THIS --->
[Use this form](https://portlandstate.atlassian.net/servicedesk/customer/portal/1014/create/1365) to request cluster access.

Connecting and Logging in
-------------------------

### Secure Shell (SSH) client

To connect to these servers you will need to use Secure Shell (ssh) run through a terminal emulation client application.  If you use Linux or MacOS, a terminal application is included with the operating system.  
> ssh userid@login.orca.pdx.edu
For Windows you might use MobaXterm.

Operating Environment
=====================

The ORCA cluster is running Rocky Linux 9.5 (as of this date).

ORCA Home Directory 
---------------------------------------------

Your ORCA home directory is separate from the general research home directory used for other systems in the PSU research computing infrastructure.  Separate home directories are used because different computational systems often require different local system settings.  Your ORCA home directory will have standard Bash  configuration files, as well as any cluster-specific, custom settings you add.

Login nodes
-----------

These are the servers where the users interface with the file system, scheduler, and other tools. The ORCA login node is named:

* login.orca.pdx.edu

**Important!** Do not run long computational jobs on the login servers.  These are for logging in, accessing your home directory, accessing file systems, writing and editing files, compressing and uncompressing data sets, compiling software, scheduling computational jobs, testing software, etc. Computational jobs will be run on computational nodes, through the SLURM job scheduler.   Long computational process running on login nodes, and any unscheduled jobs, are liable to be terminated without notification.

Modules
-------

This cluster uses Linux environment modules (lmod) to allow users to quickly update their environment paths,  for specific software packages.  This will allow users to enable and disable software as needed.  For example, the ORCA cluster has module environments created for each MPI available implementation (openmpi, mpich, mvapich).  

### Basic module usage

To obtain a complete list of all modules currently available on the system

> module avail

To load a module, e.g. GCC 13.2.0 compilers

> module load gcc/13.2.0

To load a module, e.g. OpenMPI 4.1.4 compiled with GCC 13.2.0.  (this will automatically load the gcc-13.2.0 module) 

> module load openmpi/4.1.4-gcc-13.2.0

To obtain a complete list of currently loaded modules

> module list

Currently Loaded Modulefiles:

 1) gcc/13.2.0                2) openmpi/4.1.4-gcc-13.2.0

To unload a module, e.g. OpenMPI 4.1.4 compiled with GCC 13.2.0.  (this will automatically unload the gcc-13.2.0 module, too) 

> module unload openmpi/4.1.4-gcc-13.2.0

NERSC has an excellent [Modules usage reference](https://www.nersc.gov/users/software/user-environment/modules/)

Software
--------

Modules load the selected software on each of these systems, mounted in the /software volume, where there is broad range of available software.  Some software in this volume include:

  + GCC 13.2.0 with earlier versions available
  + Python 3.9 with typical libraries such as numpy, scipy.
  + Blast
  + Matlab, R
  + Latest versions of HDF5, NetCDF4, zlib, cmake, etc

File Systems and Data Storage
=============================

ORCA Home Directory.  /home/userid
-----------------------------------

Your home directory is on a shared filesystem that is mounted on all cluster nodes.  This should be used to store your batch scripts, system configurations, local compiled software, libraries, and config/settings files.  Home directories are backed-up to tape on a nightly basis.  Be advised that running calculations on data living in your home directory will be much slower, just use it to store backups of your data and do the computation on scratch storage.

Scratch storage.  /scratch
--------------------------

Data for your computational work should be put in scratch.  You can create your own personal and group project folders here.  This shared filesystem is mounted on all cluster nodes.  This is a large volume intended for temporary storage of data used in computational processes.  This volume is not backed up and all files stored here are considered to be temporary.  

Scratch is managed with on a modified First In, First Out policy.  The largest consumers of storage are prioritized for deletion and the oldest files are removed first.  Once this volume reaches a certain threshold, you may be asked to remove directories/files.  If this passes a critical threshold, system administrators reserve the right to remove all files.

Other Volumes
-------------

### Research shares.  /vol/share/sharename

Research storage shares are common to all OIT-RC systems.  These are only mounted on this cluster login nodes, in order to facilitate copying of data to the /scratch volumes.  /vol/share is a good place to move data that should be backed up, for example resultant data from computational runs. Do not run computational jobs against data stored on /vol/share. This volume is backed up.  (PSU access only)

Running Parallel Programs
=========================

SLURM Workload Manager
----------------------

We use the [SLURM Workload Manager](https://slurm.schedmd.com/) for job control and management.  There are a number of  user commands for the scheduler.  For getting started, the most salient commands are  sbatch, squeue, scancel, sinfo, and srun.  A sample submit script and use of some of these commands is included in the section below “Compiling A Simple MPI Program.”  For more information visit the [SLURM Quick Start User Guide](https://slurm.schedmd.com/quickstart.html).  This is a good, more detailed introduction to SLURM.

- sbatch - Command to submit a job script to the scheduler for execution.  This script typically contains one or more srun commands to launch parallel tasks.
- squeue - This reports the state of jobs or job steps. This is useful view check what’s in the current job queue, especially if you’re going to submit a larger job using many nodes.
- scancel - Allows you to cancel a pending or running job.
- sinfo - This reports the state of partitions and nodes managed by Slurm.  There are a number of filtering, sorting, and formatting options.
- srun - This command is used to submit a job for execution or initiate job steps in real time.  Typically this will be included in an sbatch script.

For more on SLURM parallelism, visit [here](/pdx.edu/research-computing/faqs/ORCA-hpc-faqs/slurm-parallelism).

For more on the SLURM Scheduler, refer to [this](https://sites.google.com/pdx.edu/research-computing/getting-started/slurm-scheduler) page.

Partitions
----------

There are many ways of dividing up and managing a cluster.  Partitions are a means of dividing hardware and nodes into useful groupings.  These hardware groups can have very different parameters assigned to them. Currently ORCA is divided into three general CPU node partitions, one aggregate CPU partition, a Intel Phi processor partition, a large memory partition (with GPUs), and a GPU partition.  Note that these partitions and parameters may change in the future as demand requires.

- short - jobs are limited to 4 hours.
- medium - this is the default partition.  If you don’t specify a partition, your job will run here.  Jobs are limited to 7 days.
- long - allows long running jobs up to 20 days.
- interactive - allows interactive jobs.  This can be useful for remote visualization tasks and interactive applications. Jobs can be up to 2 days.

The sinfo command will display an overview of partitions. 
```
sinfo --long --Node
```

Compiling A Simple MPI Program
------------------------------

This is an example session where a simple MPI  “Hello World” program is compiled and run.  This assumes this program file named mpi\_hello.c, uses the mpich MPI library, the submission script is mpi\_hello\_submit.sh, the job is submitted to the “short” partition, and the output goes to a file named mpi\_hello.txt.

The program file -  mpi\_hello.c.
``` 
#include <stdio.h>
#include <mpi.h>

int main(int argc, char \*\* argv) {

   int rank, size;
   char name[80];
   int length;
   MPI\_Init(&argc, &argv); // note that argc and argv are passed
                            // by address
                            //

   MPI\_Comm\_rank(MPI\_COMM\_WORLD,&rank);
   MPI\_Comm\_size(MPI\_COMM\_WORLD,&size);
   MPI\_Get\_processor\_name(name,&length);
   printf("Hello MPI: processor %d of %d on %s\n", rank,size,name);
   MPI\_Finalize();
}
```


To compile the program mpi\_hello (assuming you have created the sample program)
```
$ module load openmpi/4.1.4-gcc-13.2.0
$ mpicc -o mpi\_hello mpi\_hello.c  
```

Scheduler submission script  - submit\_mpi\_hello.sh." 
``` shell
#!/bin/bash

#SBATCH --job-name mpi\_hello
#SBATCH --nodes 2
#SBATCH --ntasks-per-node 2
#SBATCH --partition short
#SBATCH --output mpi\_hello.txt
module load openmpi/4.1.4-gcc-13.2.0
mpiexec ./mpi\_hello
```
Run sleep for 20 sec. so we can test the 'squeue' command
```
srun sleep 20
```
Submit the program mpi\_hello to the SLURM scheduler (assuming you have created the sample program and submit script)
```
$ sbatch submit\_mpi\_hello.sh 
```
The “squeue” command should now show a running job.
```
$ squeue

   JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)

     348    short mpi\_hell     will  R       0:14     2 compute[127-128]
```

After this runs, listing the directory contents should now has a the C code file, program, submission script, and  output file.
```
$ ls 

mpi\_hello  mpi\_hello.c  mpi\_hello\_submit.sh  mpi\_hello.txt 
```
The output file will show the nodes and cores that it ran on. 
```
$ cat mpi\_hello.txt

Hello MPI: processor 0 of 4 on compute127.cluster
Hello MPI: processor 1 of 4 on compute127.cluster
Hello MPI: processor 2 of 4 on compute128.cluster
Hello MPI: processor 3 of 4 on compute128.cluster
```
If a job does a lot of the same thing, like run the same calculations on different inputs, it is highly recommended to use a [job array](/pdx.edu/research-computing/faqs/ORCA-hpc-faqs/job-arrays).

For more examples of SBATCH scripts, please refer to [the SLURM Scheduler page](https://sites.google.com/pdx.edu/research-computing/getting-started/slurm-scheduler).

<!--- 
ORCA Priority Access
=====================

In addition to the Free access tier, there is now a Priority access tier making it possible for researchers to reserve dedicated computer time for their funded research needs. Details are available in OIT’s [description of the High Performance Computing](https://t.e2ma.net/click/aedikk/2vd4gde/6mth8t) (HPC) Clusters service, including a [link to the HPC Priority Access request form](https://t.e2ma.net/click/aedikk/2vd4gde/mfuh8t) where researchers can engage with OIT to assess their HPC requirements in order to include funding for Priority access in future research grant proposals.

High Priority Partitions
------------------------

After your request has been processed, you will be able to submit the job to the higher priority partitions. Jobs submitted to these partitions will preempt the jobs in regular tier. More details on the node specification can be found [here](https://sites.google.com/pdx.edu/research-computing/systems/linux-hpc?authuser=0#h.p_2zBGngc8NzAv). Maximum job runtime on these partition is 20 days. Send a request to [help-rc@pdx.edu](mailto:help-rc@pdx.edu) if you need to extended the runtime of your job beyond the maximum time limit.

* + - priority\_access - 130 compute nodes
    - priority\_access\_himem - 2 himem nodes
    - priority\_acces\_gpu - 10 GPU nodes

Submit a High Priority Job
--------------------------

To submit a job to a high priority partition following SLURM parameter has to be passed, for regular compute nodes:

--partition priority\_access

for himem nodes:

--partition priority\_access\_himem

or for gpu jobs:

--partition priority\_access\_gpu

[Research Computing Service Request](https://www.google.com/url?q=https%3A%2F%2Fportlandstate.atlassian.net%2Fservicedesk%2Fcustomer%2Fportal%2F2%2Fgroup%2F19%2Fcreate%2F148&sa=D&sntz=1&usg=AOvVaw3u3UJa-CsGX4P_uCMMKWy2)

Office of Information Technology- Research Computing Team -[help-rc@pdx.edu](mailto:help-rc@pdx.edu)

[General Service Help Desk](http://www.google.com/url?q=http%3A%2F%2Fgo.pdx.edu%2Fhelp&sa=D&sntz=1&usg=AOvVaw0X7b1HkgulmycUO4RP2dS3)

>