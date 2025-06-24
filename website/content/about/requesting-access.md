---
title: "Requesting Access"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Requesting Access to Orca

Access to Orca is free, and available to all students, educators, and researchers in the Oregon region.
Just follow the steps listed below.

## Step 1. Create an Account

Fill out the [account creation form](https://orca.pdx.edu/registry/co_petitions/start/coef:13).
You will be prompted to log in using your institutional login.

> [!INFO] Choosing a Username
>
> When choosing a username, we recommend the format `user_institution` (where your email is typically `user@institution.edu`).

> [!Question] If your institution is not listed
>
> Your institution may not listed as an available option in the login page; this is likely because they are not part of the [InCommon Federation](https://incommon.org).
> In this case, we recommend that you first create an [ACCESS CI](https://access-ci.org) account.
> After creating your ACCESS account, select ACCESS CI as your institution when logging into the Orca account creation webpage.

## Step 2. Account Approval

After creating the account, it will be submitted to Orca administrators for approval.
Once administrators approve the account creation you will be notified by email.

## Step 3. Upload SSH Public Key

Access to the Orca cluster requires SSH authentication.
Once your account is created, you can upload your SSH public key using Orca's web interface as described below.
For information on creating SSH key pairs and using SSH authentication, [see the documentation on connecting to Orca]({{< ref "connecting/#authentication-with-ssh-keys" >}}).
To upload your SSH public key to the Orca cluster using the web interface, follow these steps:

1. Log in to the Orca Registry: https://orca.pdx.edu/registry
2. Click on your name in the top right of the page
3. Select "My Profile (Orca)"
4. Select "Authenticators" from the menu on the right side
5. Select "Manage"
6. Select "Add SSH Key"
7. Choose your SSH public key, and select "Upload"
