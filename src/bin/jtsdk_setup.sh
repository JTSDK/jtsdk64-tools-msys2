jtsdk-setup () {

    # exit on errors
    set -e

    # script version
    VER="3.1.0"

    # foreground colors
    C_R='\033[01;31m'	# red
    C_G='\033[01;32m'	# green
    C_Y='\033[01;33m'	# yellow
    C_C='\033[01;36m'	# cyan
    C_NC='\033[01;37m'	# no color

    # make directories
    mkdir -p $HOME/src > /dev/null 2>&1

    # start installation
    clear
    echo ''
    echo '---------------------------------------------------------------'
    echo -e ${C_Y}"INSTALL JTSDK v$VER PACKAGE LIST"${C_NC}
    echo '---------------------------------------------------------------'
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
}