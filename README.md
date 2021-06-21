# Dotfiles for Ubuntu 💜

Iain Samuel McLean Elder's dotfiles for Ubuntu 20.04.

Based on Victoria Drake's dotfiles, and slowly evolving into its own thing.

## Devopment environment for Github actions

The program installer scripts assume the existence of sudo and may invoke it to
do things that require root on the desktop, such as installing apt packages.

The scripts are tested in an Ubuntu container that lacks a non-root login and sudo.

We fix the missing sudo by installing it before running a script to prepare the
Docker environment.

This same technique is used in each Github Actions workflow.

To test a script locally in a prepared Docker environment, use the
test_local.bash script.

```bash
./test_local.bash scripts/install_programs.bash
```

Run test_local.bash without arguments to prepare the Docker environment and
start an interactive shell for experimenting.

```bash
./test_local.bash
```

## Continuous integration (CI) with Github Actions

Each installer script is tested with a CI workflow.

Each worflow prepares the Ubuntu container as in the development environment,
runs the installer, and then runs the installer again to test idempotency.

A worflow for each installer can be generated automatically from a template.

To generate the workflow for all installers, use the generate_ci.bash script.

```
./generate_ci.bash
```

You should regenerate the workflows after either changing the template or adding
a new installer script.

Push the result to Github to run the workflow using Github Actions.

```
git add .github/workflow
git commit
git push
```

## To upgrade after installing

```
pipx upgrade-all --skip taskcat

TODO: more things
```

## To be added to install.sh

AWS Session Manager Plugin

https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

```bash
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
```

aws-gate

https://github.com/xen0l/aws-gate/

```
pipx install aws-gate 
```

Docker non-root stuff with newgrp and all that

youtube-dl:

```
pipx install youtube-dl
apt install ffmpeg
```

sox and mplayer:

https://www.unixmen.com/record-voice-ubuntu/

Zoom (these steps might not work):

```
wget 'https://zoom.us/client/latest/zoom_amd64.deb'

sudo apt install ./zoom_amd64.deb
```

DBeaver:

```
sudo add-apt-repository ppa:serge-rider/dbeaver-ce
```

Git diff-so-fancy

https://github.com/so-fancy/diff-so-fancy/issues/383

Install:

```text
add-apt-repository -y ppa:aos1/diff-so-fancy
apt update
apt install -y diff-so-fancy
```

Config:

https://github.com/so-fancy/diff-so-fancy

```
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
```

AWS Amplify:

Depends on Node.js 10, which is in the Ubuntu repo.

https://github.com/aws-amplify/amplify-cli

```
sudo apt install nodejs
sudo apt install npm
```

Then to finish setting up npm, allowing packages to be installed as non-root:

https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md

```
mkdir "${HOME}/.npm-packages"
npm config set prefix "${HOME}/.npm-packages"
```

```
npm install -g @aws-amplify/cli
```


Microsoft Teams for Linux:

```
https://www.microsoft.com/en-us/microsoft-teams/download-app#allDevicesSection
```

Clustergit

```
cd ~/Repos
git clone git@github.com:mnagel/clustergit.git
ln ~/Repos/clustergit/clustergit ~/.local/bin/clustergit
```

## Virtualbox

Follow these instructions when prompted by the installer script.

Enter a passsword for secure boot. You don't need to save this in 1 Password.
You just need to remember it for the coming reboot.

Restart Ubuntu.

Choose "Enrol MOK".

Choose "Key 0".

Enter the password for secure boot again.

Restart again.

Wait for Ubuntu to boot.

Set up Virtualbox with a virtual machine and launch.

Confirm that Virtualbox can launch a virtual machine.

## VirtualBox Webcam Passthrough

For PSI exam software.

Download the Extension Pack linked here:

https://www.virtualbox.org/wiki/Downloads

Start VirtualBox.

Add the extension pack (File > Preferences > Extensions > Add new package).

Follow the instructions to install it.

Use VBoxManage to check available webcams.

```text
$ VBoxManage list webcams
Video Input Devices: 2
.1 "Integrated Camera: Integrated C"
/dev/video0
.2 "Integrated Camera: Integrated C"
/dev/video1
```

https://www.virtualbox.org/manual/ch01.html#intro-installing

https://www.virtualbox.org/manual/ch09.html#webcam-passthrough

https://scribles.net/using-webcam-in-virtualbox-guest-os-on-windows-host/

## Cronopete

Like macOS Time Machine.

https://rastersoft.com/programas/cronopete.html

## Chrome

Microsoft Teams Preview for Linux is sadly quite flaky.

Teams calls on the web version work only in Chrome.

https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-20-04/

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
cat /etc/apt/sources.list.d/google-chrome.list
```

## Unrar

To avoid
[Archive Manager’s Parsing Filters is Unsupported Message](https://delightlylinux.wordpress.com/2016/08/23/fixing-archive-managers-parsing-filters-is-unsupported-message/).

```bash
sudo apt install unrar
```

## Cobang QR Reader

```bash
sudo add-apt-repository ppa:ng-hong-quan/ppa
sudo apt update
sudo apt install cobang
```

## OpenRazer

https://openrazer.github.io/#download

```bash
sudo add-apt-repository ppa:openrazer/stable
sudo apt update
sudo apt install openrazer-meta
```

## Audio Recorder

https://launchpad.net/~audio-recorder/+archive/ubuntu/ppa

```
sudo add-apt-repository ppa:audio-recorder/ppa
sudo apt-get -y update
sudo apt-get install --reinstall audio-recorder
```

## RocketChat

https://github.com/RocketChat/Rocket.Chat.Electron/releases

Download and install the latest .deb package.
