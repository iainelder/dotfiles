# Ubuntu 20 Setup

## First boot

Do essential configuration and updates.

* Skip on-line account setup
* Do not configure LivePatch
* Send system information to Canonical
* Don't allow applications to determine my geographic location
* Skip installing extra software

If Software Updtes pops up to say that updated have been published since the launch of Ubuntu 20.04, first click Configuration to get to

Software and Updates > Updates

* Set it the following way:

* For other packages, subscribe to all updates
* Check updates daily
* Download and install automatically
* Show other updates weekly
* Notify me of new long-term-support version of Ubuntu

Then install the updates.

Restart if prompted.

## Setup automatic backup and restore

Before going any further, take a system snapshot.

(You may have actually gone a bit further before getting scared of running the automation scripts without having a way to reset if something goes wrong!)

Set up an on-line account for Google (Would prefer to use Onedrive for Déjà Dup, but it's not supported yet.) https://gitlab.gnome.org/World/deja-dup/-/issues/158

Open Déjà Dup. Check that storage location is Google Drive. In General view click backup now. Install python3-pydrive package when prompted. Make the first backup. After the first backup set it to daily backups with six months of retention.

## Repo setup

Get access to repos and synchronize this guide.

### Firefox

Open Firefox.

Install 1Password X browser extension.

https://addons.mozilla.org/en-US/firefox/addon/1password-x-password-manager/?src=search

Log into 1Password account.

Log into Bitbucket.

Generate new SSH key for machine.

```bash
ssh-keygen
cat ~/.ssh/ida_rsa.pub
```

Upload new public key to Bitbucket account.

Install git using apt then configure with global default commit identity.

```bash
git config --global user.email "iain@isme.es"
git config --global user.name "Iain Samuel McLean Elder"
```

Create Repos folder and download any required repos (life-notes, for example):

```bash
mkdir ~/Repos
cd ~/Repos
git clone git@bitbucket.org:isme/life-notes.git
```

Add this guide.

## Dotfiles

FIXME: this takes a lot of work to get right. Skip this step for now.

Fork Victoria Drake's Dotfiles for Ubuntu.

https://github.com/victoriadrake/dotfiles

Clone my own Dotfiles.

https://github.com/iainelder/dotfiles


## Visual Studio Code

Install using .deb file.

https://code.visualstudio.com/docs/setup/linux#_installation

## AWS CLI


