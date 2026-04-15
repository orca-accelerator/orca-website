
# Data Transfer with Globus

## What is Globus

Globus is a research cyberinfrastructure, developed and operated as a not-for-profit service by the University of Chicago.  [About Globus](https://www.globus.org/what-we-do) 

"With Globus, you can easily, reliably and securely move, share, & discover data no matter where it lives – from a supercomputer, lab cluster, tape archive, public cloud or laptop. Access and manage all your data, even protected data, from anywhere, using your existing identities, with just a web browser.​"  

Globus allows you to copy files for your research from an existing resource at a remote site, or conversly copy your research data to a remote repository.  Assuming you have set up the end point(s), which will be described in the next section.

## Set up Globus to use the web interface to copy files to/from Orca

First you need scratch space on Orca, login to the cluster and create scratch space with the ws\_allocate command.

Login to Globus (or set up an account) at the [login page](https://app.globus.org) (https://app.globus.org), select your university and use your university SSO credentials.

Once logged in, go to the file manager page.  Here you can transfer files to/from Orca and any other registered end point.  For example, in the first collection search bar enter 'weather', and look for NC State Research Storage (this is a free to use weather data collection).  Pick the specific data set in the menus.  On the other collection search for Orca.  Find the scratch space you created in the folder menus and navigate to it or enter the name in the destination bar.  Then hit the Start (>) button.  Globus will copy the data set and send you an email when it is done.  You can close the browser tab.

## Setup Globus to use the personal connection point

This option would be used to copy files from a personal computer to Orca.  This requires only a connection where you can reach <https://globus.org>.  This method can also be used to copy to or get data from an external collaborator at another university.

You will need a Globus login as described in the last section.

First, install the globus connect personal by following the instructions at <https://docs.globus.org/globus-connect-personal/install/>.  The instructions below are for Linux, if you are using Windows or Mac then follow the gui instructions at the link above.

Once you start ./globusconnectpersonal --setup --no-gui you will get a very long URL that needs to be pasted into your browser in order to get an auth key.  Copy the auth key to the terminal window where you ran globus.

Now you will be prompted for your local setup, here is where you need a unique endpoint name, something you can search for in the file manager described above.

By default files are copied to/from ~/ (i.e. $HOME).  Edit the file ~/.globusonline/lta/config-paths to change the default or to add other paths.  The format is path,share,rw where 0 is off and 1 is on.  Share means that anyone can see your files, rw means the path is writable.  It is a very good idea to move this path out of your home directory.

Start the connection with ./globusconnetpersonal -start &, then use the file manager described above to copy files.
