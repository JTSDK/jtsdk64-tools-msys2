# JTSDK64 MSYS2 Installation

The JTSDK MSYS2 Scripts are pre-installed in the MSYS2 environment when using
the published InnoSetup Windows Installer from Sourceforge. 

## Provides

1. Bash function for installing Hamlib build dependencies.
1. Bash script for building Hamlib from source code and other useful functions.
1. Pacman function for upgrading all MSYS2 packages.

## Installation and Setup

The following steps should be performed in order assuming a new installaiton
of `JTSDK64 Tools`.

1. [Update MSYS2 Packages](#update-msys2-packages)
1. [Install hamlib Dependencies](#install-hamlib-dependencies)
1. [Build Hamlib](#build-hamlib)

## Command List and Help Screens

The `JTSDK64-Tools-MSYS2` package provides a number of useful commands and help
screens.

1. [Command Summary](#command-summary)
1. [Command Helpers](#command-helpers)

These lists will be updates as the `JTSDK64-ToolsMSYS2` package is updated.

## Update MSYS2 Packages

After initial installation, often there are several packages that need to be
upgraded. This is particularly true for the main MSYS2 runtime binaries. This
function can be run any time you wish to upgrade your MSYS2 

>NOTE: This function can be run anytime you wish to upgrade all system packages,
including the msys2-runtime dll's.

```bash
# Open MSYS2 Console, and type the following
msys2-update
```

If any of the msys2 runtime dlls are updated (you will see a message at
the bottom of the screen) close the terminal using the "**X**" in the top-right
corner of the window, then re-open the MSYS2 Console and run the update again.
Repeat this step until there are no further updates installed.

## Install Hamlib Dependencies

To install the required Hamlib build dependencies, run the following command.

>Note: this command can be run at any time you whish to update just the Hamlib
dependencies.

```bash
# Open MSYS2 Console, then run the following, type:
jtsdk-setup
```

## Building Hamlib

At the time of the writing, the build script is hard coded to use **Qt version
5.12.2 and Mingw64 Tools GCC version 7.3.0**. As additional versions of Qt are
validated, they will be added as options.

```bash
# To build Hamlib, use the following command, type:
build-hamlib
```
If the build finished successfully, the Hamlib libraries and associated binaries
will be installed to the following Locations:

>NOTE: (C|D) denotes the diver letter of your `JTSDK64-Tools` installation. The
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

## Command Summary

The following alias commands are available to users after installation.

| Command       | Description                                      |
| :------------ |:------------------------------------------------ |
| jtsdk-help    | Show this help menu                              |
| jtsdk-version | Show JTSDK64 MSYS2 Version Information           |
| jtsdk-setup   | Install Hamlib Build Dependencies                |
| build-hamlib  | Build Hamlib Libraries and Binaries              |
| update-msys   | Upgrade all MSYS2 packages including runtimes    |

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
