# Dotfiles for Ubuntu 💜

## Devopment environment for Github actions

The program installer scripts assume the existence of sudo and may invoke it to do things that require root on the desktop, such as installing apt packages.

The scripts are tested in an Ubuntu container that lacks a non-root login and sudo.

We fix the missing sudo by installing it before running a script to prepare the
Docker environment.

This same technique is used in each Github Actions workflow.

To test a script locally in a prepared Docker environment, use the
test_local.bash script.

```bash
./test_local.bash scripts/install_programs.bash
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

## Forked stuff

My preferred starting configuration for Ubuntu Desktop. Current version 20.04 Focal Fossa.

The [installation script included](https://github.com/victoriadrake/dotfiles/blob/ubuntu-20.04/scripts/install.sh) will install a suggested serving of programs and applications, found within the `scripts/` directory. Please verify that you want these before running the script.

Add or delete files in `scripts/install.sh` and `scripts/programs/` to modify your installation.

## Usage

After installing your fresh OS, do:

```sh
sudo apt install git vim -y
```

Use Vim to create any SSH keys you need to access GitHub, and remember to run `ssh-add` as well as `chmod 600 <key_name>`. Then clone this repository:

```sh
git clone git@github.com:victoriadrake/dotfiles.git

# Or use HTTPS
git clone https://github.com/victoriadrake/dotfiles.git
```

You may optionally like to pass the `--depth` argument to clone only a few of the [most recent commits](https://github.com/victoriadrake/dotfiles/commits/master).

Close Firefox if it's open, then run the installation script.

```sh
cd dotfiles/scripts/
./install.sh
```

If you like, set up [powerline-shell](https://github.com/b-ryan/powerline-shell):

```sh
cd powerline-shell/
sudo python3 setup.py install
```

Uncomment the relevant lines in `.bashrc`, then restart your terminal to see changes, or run:

```sh
cd ~
source .bashrc
```

## Random Helpful Stuff (TM)

### Clone all your remote repositories

Given a list of repository URLs, `gh-repos.txt`, run:

```sh
xargs -n1 git clone < gh-repos.txt
```

Use the [`firewood` Bash alias](https://github.com/victoriadrake/dotfiles/blob/ubuntu-20.04/.bashrc#L27) to collect remote branches.

See [How to write Bash one-liners for cloning and managing GitHub and GitLab repositories](https://victoria.dev/blog/how-to-write-bash-one-liners-for-cloning-and-managing-github-and-gitlab-repositories/) for more.

### Terminal theme

There are plenty of themes for Gnome terminal at [Mayccoll/Gogh](https://github.com/Mayccoll/Gogh).

Print a 256-color test pattern in your terminal:

```sh
for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
        printf "\n";
    fi
done
```

### Saving and loading configuration settings

Optionally, load `settings.dconf` with:

```sh
dconf load /org/gnome/ < .config/dconf/settings.dconf
```

Back up new settings with:

```sh
dconf dump /org/gnome/ > .config/dconf/settings.dconf
```

Run `man dconf` on your machine for more.

## Your personal CLI tool Makefile

See the Makefile in this repository for some helpful command aliases. Read about [self-documenting Makefiles on my blog](https://victoria.dev/blog/how-to-create-a-self-documenting-makefile/).

## Recommended additions

- GNOME Tweaks
- [Emoji Selector](https://extensions.gnome.org/extension/1162/emoji-selector/) ❤️✨🦄
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
