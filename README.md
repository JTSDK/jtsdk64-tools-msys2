# JTSDK64 MSYS2 Script Installation

Installation of of the JTSDK64 MSYS2 Scripts should be performed after you
have launched the MSYS2 Console at least once prior to attempting the installation.

## Provides

1. Bash function for installing Hamlib build dependencies.
1. Bash script for building Hamlib from source code.

## Required Dependencies

In order to checkout the the script, you must have `Git` available from the
MSYS2 Console. If do not, use the following command to install `Git`

```bash
# Open MSYS2 Console, then at the prompt, type:
pacman -S --needed --noconfirm --disable-download-timeout git

```

If you get `warning: git-2.21.0-1 is up to date -- skipping`, you
know `Git` is already installed.

## Checkout Code and Install

Check out the code from `Github`, and install the scripts.

```bash
# Checkout the code
git clone https://github.com/KI7MT/jtsdk64-tools-msys2.git

# Change directories and install
cd jtsdk64-tools-msys2
make install

```

## Install Hamlib Dependencies

In order to use the automated installation script, you must first source it to make it available in the shell. Instructions to make this an automated process is
outlined in [Automated Script Sourcing](#automated-script-sourcing) section
below.

```bash
# Source the Install Script with the following command, type: 
source /home/$USER/bin/jtsdk_setup.sh

# To install build dependencies, type
jtsdk-setup
```

If the script finishes sucessfully, you should ahve all the MSYS2 required
dependencies installed.

## Building Hamlib

At the time of the writing, the build script is hard coded to use **Qt version 5.12.2, and Mingw64 Tools GCC version 7.3.0**. As additional
versions of Qt are validated, they will be added as available options.

```bash
# To build Hamlib, use the following command, type:
build-hamlib
```

## Hamlib Install Locations

If the build finished successfully, the Hamlib libraries and associated binaries will be installed to the following Locations:

NOTE: (C|D) denotes the diver letter of your `JTSDK64-Tools` installation. The following exampled shows a `D-Drive Installation`.

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

If you installed `JTSDK64-Tools` using `InnoSetup` installer, this step may not be required as the modifications were made to the skeleton
shell scripts before packaging. If however, you've re-installed MSYS2, or somehow replaced your `/home/$USER/.bashrc_profile` file, perform the following steps to source the `jtsdk_setup.sh` each time you open MSYS2.

1. With a good text editor: `VSCODE, Notepad++, Sublime, etc` browse to and open the following file, note: $USER is your PC user name:

```bash
# Edit the following file
(C|D):/JTSDK64-Tools/tools/msys64/home/$USER/.bashrc_profile

# Add the following lines to the bottom of .bashrc_profile

if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

if [ -f "${HOME}/bin/jtsdk_setup.sh" ] ; then
  source "${HOME}/bin/jtsdk_setup.sh"
fi

# Save, then exit the file.

```

2. Once you have finished editing, save the file. Exit and reopen the MSYS2 console. If successful, you should be able to run the `jtsdk-setup` and `build-hamlib`alias commands. Test to ensure both are functional.

```bash
# Test package installation alias, type
jtsdk-setup

# Test building Hamlib using the alias, type:
build-hamlib

```