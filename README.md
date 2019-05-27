# JTSDK64 MSYS2 Script Installation

Installation of the `JTSDK64 MSYS2 Scripts` should be performed after you
have launched the MSYS2 Console at least once prior to attempting this
installation. For a list of all available commands provided by the
`JTSDK64 Tools MSYS2 Scripts` see the [Command Summary Table](#command-summary)
below.

The `JTSDK64 MSYS2 Tools` Environment provides a number of enhanced
command-line helpers to improve usability within the MSYS2 shell. Most were taken
from the skeleton `bashrc` file the MSYS2 team provided, but were left commented out.
For a full listing of improvements, see the [Command Helpers](#command-helpers)
list below.

NOTE: When working in the MSYS2 Console, you can `Copy & Paste` any of
the commands listed below to ease the burden of type each line explicitly.

## Provides

1. Bash function for installing Hamlib build dependencies.
1. Bash script for building Hamlib from source code.

## Required Dependencies

In order to checkout the the script, you must have `Git` available from the
MSYS2 Console. If not, use the following command to install `Git`

```bash
# Open MSYS2 Console, then at the prompt, type:
pacman -S --needed --noconfirm --disable-download-timeout git

```

If you get `warning: git-2.21.0-1 is up to date -- skipping`, `Git` is already
installed.

## Checkout Code and Install

Install `GNU make`, checkout out the code from `Github`, and install the scripts.

```bash
# Install GNU make
pacman -S --needed --noconfirm --disable-download-timeout make

# Make directories, checkout code, and install
mkdir -p $HOME/src
cd $HOME/src
git clone https://github.com/KI7MT/jtsdk64-tools-msys2.git

# Change directories and install
cd ./jtsdk64-tools-msys2
make install

```

## Install Hamlib Dependencies

In order to use the automated installation script, you must first source making
it available in the shell. Instructions to automate this process is
outlined in [Automated Script Sourcing](#automated-script-sourcing) section
below.

```bash
# Source the install script with the following command, type:
source /home/$USER/bin/jtsdk_setup.sh

# To install build dependencies, type
jtsdk-setup
```

If the script finishes successfully, you should now have all the required MSYS2
dependencies installed.

## Building Hamlib

At the time of the writing, the build script is hard coded to use **Qt version
5.12.2 and Mingw64 Tools GCC version 7.3.0**. As additional versions of Qt are
validated, they will be added as options.

```bash
# To build Hamlib, use the following command, type:
build-hamlib
```

## Hamlib Install Locations

If the build finished successfully, the Hamlib libraries and associated binaries
will be installed to the following Locations:

NOTE: (C|D) denotes the diver letter of your `JTSDK64-Tools` installation. The
following example shows a `D-Drive Installation`.

```bash
# Final report from build script
-----------------------------------------------------
  TESTING RIGCTL
-----------------------------------------------------

rigctl(d), Hamlib 4.0~git

Copyright (C) 2000-2012 Stephane Fillod
Copyright (C) 2000-2003 Frank Singleton
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.

-----------------------------------------------------
  FINISHED INSTALLING [ Hamlib ]
-----------------------------------------------------

  Tool-Chain........: QT 5.12.2
  Source Location...: /home/ki7mt/src/hamlib/src
  Build Location....: /home/ki7mt/src/hamlib/build
  Install Location..: /d/JTSDK64-Tools/tools/hamlib/qt/5.12.2
  Package Config....: /d/JTSDK64-Tools/tools/hamlib/qt/5.12.2/lib/pkgconfig/hamlib.pc
```

This concludes initial build of Hamlib.

## Automated Script Sourcing

If you installed `JTSDK64-Tools` using the `InnoSetup` installer, this step may not
be required as the modifications were made to the skeleton shell scripts before
packaging. If however, you've re-installed MSYS2, or somehow replaced your
`/home/$USER/.bash_profile` file, perform the following steps to source the
`jtsdk_setup.sh` script each time you open MSYS2.

1. With a good text editor: `VSCODE, Notepad++, Sublime, etc` browse to and open
the following file. Note: $USER denotes your PC user name:

```bash
# Edit the following file
(C|D):/JTSDK64-Tools/tools/msys64/home/$USER/.bash_profile

# Add the following lines to the bottom of .bash_profile

if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

if [ -f "${HOME}/bin/jtsdk_setup.sh" ] ; then
  source "${HOME}/bin/jtsdk_setup.sh"
fi

# Save, then exit the file.

```

2. Once you have finished editing, save the file. Exit and reopen the MSYS2
console. If successful, you should be able to run the `jtsdk-setup` and
`build-hamlib`alias commands without sourcing first. Test to ensure both
are functional.

```bash
# Test package installation alias, type
jtsdk-setup

# Test building Hamlib using the alias, type:
build-hamlib

```

## Command Summary

The following alias commands are available to users after installation.

| Command       | Description                            |
| :------------ |:-------------------------------------- |
| jtsdk-help    | Show this help menu      |
| jtsdk-version | Show JTSDK64 MSYS2 Version Information |
| jtsdk-setup   | Install Hamlib Build Dependencies      |
| build-hamlib  | Build Hamlib Libraries and Binaries    |

## Command Helpers

There many ways to improve the usability of virtually any Bash shell. The following
commands have been enabled when using the `JTSDK64 MSYS2 Scripts`.

| Command  | Switch             | Description                            |
| :------- | :----------------- |:-------------------------------------- |
| df       | df -h              | Human readable system information      |
| du       | du -h              | Human readable disk usage              |
| less     | less -r            | Raw control characters                 |
| whence   | type -a            | Where, of a sort                       |
| grep     | grep --color       | Show differences in color              |
| egrep    | egrep --color=auto | Show differences in color              |
| fgrep    | fgrep --color=auto | Show differences in color              |
| ls       | ls -hF --color=tty | Fancy show files in color              |
| dir      | ls --color=auto --format=vertical | Show files vertical in color |
| vdir     | ls --color=auto --format=long | Long format file listing |
| l        | ls -CF | Shortcut to using ls |
| ll       | ls -l  | Shortcut to using vidr, or long list |
| la       | ls -A  | All files long version |
