---
title: "Connecting"
weight: 2
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Connecting and Logging into Orca

You can connect to Orca in two ways:

1. Via `ssh` (secure shell) using a terminal application.
2. Using [Open OnDemand]({{< ref "docs/open-ondemand.md" >}}), a web-based interface.

## Secure Shell (`ssh`)

You can connect to Orca using `ssh` (secure shell) run through a terminal application.
If you use Linux, Mac OS, or recent versions of Windows, a terminal application is included with the operating system.
Windows users may also consider using [MobaXterm](https://mobaxterm.mobatek.net) or [PuTTY](https://www.putty.org).

You can connect to Orca by running `ssh username@login.orca.pdx.edu`, replacing `username` with your Orca username.

{{< notice info >}}
**Authentication requires SSH keys.**
Password-based authentication **is not supported on Orca**.
For information on how to set up SSH key authentication, see [the following guide](#authentication-with-ssh-keys).
{{< /notice >}}

## Authentication with SSH Keys

Authentication to Orca uses SSH keys, which are a more secure and convenient way of logging in than with a password.
You can either create a new key pair, or you can use an existing key pair if you have one.

1. **Create a new key pair.**
   (If you have an existing key pair, you can skip to the next step).
   * **Linux or Mac OS.** In the terminal application on your computer, run the command `ssh-keygen` and follow the prompts.
   * **Windows.** Recent versions of Windows support generating SSH keys.
     Open Windows PowerShell or Command Prompt and run `ssh-keygen` and follow the prompts.
     On older versions of Windows, you may need to use third-party tools such as PuTTYgen.
     See [this tutorial](https://www.ssh.com/academy/ssh/putty/windows/puttygen) for more information.
   * After completion, two files will have been created: a **public key** and **private key**.
     The public key will be uploaded to Orca in the next step.
     The private key is secret, and should not be shared.
   * For more information, further documentation and tutorials can be found online ([AWS](https://docs.aws.amazon.com/transfer/latest/userguide/sshkeygen.html), [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server)).
2. **Upload the public key to Orca.** Using the web-based [Orca Registry](https://orca.pdx.edu/registry), upload the public key file to your account.
   You can have multiple public keys associated with your account.
   To upload your SSH public key to the Orca cluster:
    1. Log in to the Orca Registry: https://orca.pdx.edu/registry
    2. Click on your name in the top right of the page
    3. Select "My Profile (Orca)"
    4. Select "Authenticators" from the menu on the right side
    5. Select "Manage"
    6. Select "Add SSH Key"
    7. Choose your SSH public key, and select "Upload"
3. **Connect via ssh.** After completing the steps above, you should be able to connect via `ssh` by following the steps [described above](#secure-shell-ssh); you should be logged in automatically without being prompted to enter a password.
  If you have trouble logging in after following these steps, [contact us to get help]({{< ref getting-help >}}).

## Login Node

The Orca login node is the where the users interface with the file system, scheduler, and other tools.
The Orca login node can be accessed at `login.orca.pdx.edu`.
The login node does not have a high-performance CPU or any GPUs.
For compute-intensive work, a job should be run on one or more of the compute nodes (see the pages on {{< autolink "submitting-jobs.md" >}}).

{{< notice warning >}}
**Do not run computational jobs on the login node.**
These are for logging in, accessing your home directory, accessing file systems, writing and editing files, compressing and uncompressing data sets, scheduling computational jobs, etc.
Computational jobs should be run on compute nodes, through the [Slurm job scheduler]({{< ref "docs/submitting-jobs" >}}).
Long computational process running on login nodes are liable to be terminated without notification.
{{< /notice >}}

## Open OnDemand

Open OnDemand provides a graphical web-based interface for some of Orca's features (including Python Jupyter Notebooks).
See the [documentation on Open OnDemand]({{< ref "docs/open-ondemand.md" >}}).
