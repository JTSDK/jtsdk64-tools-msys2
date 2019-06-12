# script version
AUTHOR="Greg Beam, KI7MT"
JTSDK64_VER="3.1.0 Alpha"
JTSDK64_NAME="JTSDK64 Tools MSYS2"

# foreground colors ------------------------------------------------------------
C_R='\033[01;31m'	# red
C_G='\033[01;32m'	# green
C_Y='\033[01;33m'	# yellow
C_C='\033[01;36m'	# cyan
C_NC='\033[01;37m'	# no color

# Bash Custom Alias Commands ---------------------------------------------------
alias df='df -h'
alias du='du -h'
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias l='ls -CF'                              #
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias build-hamlib="bash /home/$USER/bin/build-hamlib.sh"

# Function: version information ------------------------------------------------
jtsdk-version () {

    clear ||:
    echo ''
    echo -e ${C_C}"$JTSDK64_NAME "${C_NC}
    echo ''
    echo " JTSDK64 Version .. v$JTSDK64_VER"
    echo " Qt Environment ... $QTV"
    echo ''
    echo " Copyright (C) 2013-2019, GPLv3, $AUTHOR"
    echo ' This is free software; There is NO warranty; not even'
    echo ' for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.'
    echo ''

}

# Function: install hamlib build dependencies ----------------------------------
jtsdk-setup () {

    # make directories
    mkdir -p $HOME/src > /dev/null 2>&1

    # start installation
    clear ||:
    echo ''
    echo '---------------------------------------------------------------------'
    echo -e ${C_Y}"INSTALL $JTSDK64_NAME PACKAGE LIST"${C_NC}
    echo '---------------------------------------------------------------------'
    echo ''

    # declare the package array
    declare -a pkg_list=("apr" "apr-util" "autoconf" "automake-wrapper" \
    "doxygen" "gettext-devel" "git" "subversion" "libtool" "swig" "libxml2-devel" \
    "make" "libgdbm-devel" "pkg-config" "texinfo" "base-devel" )

    # loop through the pkg_list array and install as needed
    for i in "${pkg_list[@]}"
    do
        pacman -S --needed --noconfirm --disable-download-timeout "$i"
    done

    echo ''
    echo -e ${C_Y}"Finished Package Installation"${C_NC}
    echo ''

}

# Function: Help Menu ---------------------------------------------------------
jtsdk-help () {

    clear ||:
    echo ''
    echo -e ${C_C}"$JTSDK64_NAME Help Menu"${C_NC}
    echo ''
    echo 'The following alias commands are available for direct entry'
    echo 'via the MSYS2 Console:'
    echo ''
    echo 'Command              Description'
    echo '-----------------------------------------------------------'
    echo -e ${C_C}"jtsdk-help${C_NC}           Show this help Menu"
    echo -e ${C_C}"jtsdk-setup${C_NC}          Install Hamlib Build Dependencies"
    echo -e ${C_C}"jtsdk-update${C_NC}         Upgrade JTSDK64 Tools MSYS2 Scripts"
    echo -e ${C_C}"jtsdk-version${C_NC}        Show JTSDK64 MSYS2 Version Information"
    echo -e ${C_C}"build-hamlib${C_NC}         Build Hamlib Libraries and Binaries"
    echo -e ${C_C}"msys-update${C_NC}          Upgrade all MSYS2 packages including runtimes"
    echo ''

}

# Function: Update all MSYS2 Packages including runtimes -----------------------
msys-update () {

    clear ||:
    echo ''
    echo '---------------------------------------------------------------------'
    echo -e ${C_Y}"UPGRADE ALL MSYS2 PACKAGES"${C_NC}
    echo '---------------------------------------------------------------------'
    echo ''
    pacman -Syuu --needed --noconfirm --disable-download-timeout

}

# Function: Update JTSDK64 Tools MSYS2 Scripts ---------------------------------
jtsdk-update () {

    clear ||:
    echo ''
    echo '---------------------------------------------------------------------'
    echo -e ${C_Y}"UPGRADE $JTSDK64_NAME Scripts"${C_NC}
    echo '---------------------------------------------------------------------'
    echo ''
    
    # If the source folder exists, pull and make install
    echo 'Checking repository'
    if [ -f ~/src/jtsdk64-tools-msys2/Makefile ]
    then
        cd ~/src/jtsdk64-tools-msys2
        git pull
        make install
        source ~/bin/jtsdk_setup.sh
        cd ~
    else
        echo 'Cloning new repository'
        rm -rf ~/src/jtsdk64-tools-msys2 > /dev/null 2>&1
        mkdir -p ~/src >/dev/null 2>&1 
        cd ~/src >/dev/null 2>&1
        git clone https://github.com/KI7MT/jtsdk64-tools-msys2.git
        cd ~/src/jtsdk64-tools-msys2
        make install
        source ~/bin/jtsdk_setup.sh
        cd ~
    fi

    echo ''
    echo 'To See Command List, type jtsdk-help'
    echo ''
}

# Display Main Menu
printf '\033[8;40;100t'
clear ||:
echo ''
echo -e ${C_C}"$JTSDK64_NAME using QT v$QTV"${C_NC}
echo ''
echo 'For Help Menu, type: jtsdk-help'
echo ''
echo "Copyright (C) 2013-2019, GPLv3, $AUTHOR"
echo 'This is free software; There is NO warranty; not even'
echo 'for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.'
echo ''
