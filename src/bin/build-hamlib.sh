#!/usr/bin/bash
#
# Title ........: build-hamlib.sh
# Version ......: 3.1.0 Alpha
# Description ..: Build Hamlib from G4WJS Hamlib Integration Branch
# Project URL ..: git://git.code.sf.net/u/bsomervi/hamlib
#
# Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
# Copyright ....: Copyright (C) 2018 Greg Beam, KI7MT
# License ......: GPLv3
#
# build-hamlib.sh is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation either version 3 of the
# License, or (at your option) any later version. 
#
# build-hamlib.sh is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

# Exit on errors
set -e

# Script Info
VER="$JTSDK_VERSION"
SCRIPT_NAME="JTSDK64 Tools MSYS2 Hamlib Build Script"

# Foreground colors
C_R='\033[01;31m'		# red
C_G='\033[01;32m'		# green
C_Y='\033[01;33m'		# yellow
C_C='\033[01;36m'		# cyan
C_NC='\033[01;37m'		# no color

# Process Variables
PKG_NAME=Hamlib
TODAY=$(date +"%d-%m-%Y")
TIMESTAMP=$(date +"%d-%m-%Y at %R")
BUILDER=$(whoami)
CPUS=`nproc --all`
DRIVE=`cygpath -w ~ | head -c 1 | tr '[:upper:]' '[:lower:]'`
SRCD="$HOME/src/hamlib"
BUILDD="$SRCD/build"
PREFIX="/$DRIVE/JTSDK64-Tools/tools/hamlib/qt/$QTV"
LIBUSBINC="/$DRIVE/JTSDK64-Tools/tools/libusb/1.0.22/include"
LIBUSBD="/$DRIVE/JTSDK64-Tools/tools/libusb/1.0.22/MinGW64/dll"
mkdir -p $HOME/src/hamlib/{build,src} >/dev/null 2>&1

# QT Tool Chain Paths
QTV="$QTV"
case $QTV in
	5.12.2)       
		TC="/$DRIVE/JTSDK64-Tools/tools/Qt/Tools/mingw730_64/bin"
		QTDIR="/$DRIVE/JTSDK64-Tools/tools/Qt/$QTV/mingw73_64/bin"
		QTPLATFORM="/$DRIVE/JTSDK64-Tools/tools/Qt/$QTV/plugins/platforms"
		;;
	5.12.3)
		TC="/$DRIVE/JTSDK64-Tools/tools/Qt/Tools/mingw730_64/bin"
		QTDIR="/$DRIVE/JTSDK64-Tools/tools/Qt/$QTV/mingw73_64/bin"
		QTPLATFORM="/$DRIVE/JTSDK64-Tools/tools/Qt/$QTV/plugins/platforms"
		;;            
	*)
	echo "QT Version $QTV is unsupported at this time."
	exit 1              
esac

# Export the final QT abd Lib USB paths
export PATH="$TC:$QTDIR:$QTPLATFORM:$LIBUSBINC:$LIBUSBD:$PATH"

# Function: main script header -------------------------------------------------
script-header () {
	echo ''
	echo '---------------------------------------------------------------'
	echo -e ${C_C}" $SCRIPT_NAME v$VER"${C_NC}
	echo '---------------------------------------------------------------'
	echo ''
}

# Function: package data -------------------------------------------------------
package-data () {
	echo " Date ............ $TODAY"
	echo " Package ......... $PKG_NAME"
	echo " User ............ $BUILDER"
	echo " CPU Count ....... $CPUS"
	echo " QT Version ...... $QTV"
	echo " QT Tools ........ $TC"
	echo " QT Directory .... $QTDIR"
	echo " QT Platform ..... $QTPLATFORM"
	echo " SRC Dir ......... $SRCD"
	echo " Build Dir ....... $BUILDD"
	echo " Install Prefix .. $PREFIX"
	echo " Libusb Include .. $LIBUSBINC"
	echo " Libusb DLL ...... $LIBUSBD"
	echo " Package Config... $PREFIX/lib/pkgconfig/hamlib.pc"
	echo " Tool Chain ...... $TC"
}

# Function: tool chain check ---------------------------------------------------
tool-check () {
	echo ''
	echo '---------------------------------------------------------------'
	echo -e ${C_Y}" CHECKING TOOL-CHAIN [ QT $QTV ]"${C_NC}
	echo '---------------------------------------------------------------'

	# setup array and perform simple version checks
	echo ''
	array=( 'ar' 'nm' 'ld' 'gcc' 'g++' 'ranlib' )

	for i in "${array[@]}"
	do
		"$i" --version >/dev/null 2>&1
		
		if [ "$?" = "1" ];
		then 
			echo -en " $i check" && echo -e ${C_R}' FAILED'${C_NC}
			echo ''
			echo ' If you have not sourced one of the two options, try'
			echo ' that first, otherwise set you path correctly:'
			echo ''
			echo ' [ 1 ] For the QT5 Tool Chain type, ..: source-qt5'
			echo ' [ 2 ] For MinGW Tool-Chain, type ....: source-mingw32'
			echo ''
			exit 1
		else
			echo -en " $i .." && echo -e ${C_G}' OK'${C_NC}
		fi
	done

	# List tools versions
	echo -e ' Compiler ...... '${C_G}"$(gcc --version |awk 'FNR==1')"${C_NC}
	echo -e ' Bin Utils ..... '${C_G}"$(ranlib --version |awk 'FNR==1')"${C_NC}
	echo -e ' Libtool ....... '${C_G}"$(libtool --version |awk 'FNR==1')"${C_NC}
	echo -e ' Pkg-Config  ... '${C_G}"$(pkg-config --version)"${C_NC}
}

#------------------------------------------------------------------------------#
# START MAIN SCRIPT                                                            #
#------------------------------------------------------------------------------#

# run tool check
cd
clear
script-header
package-data
tool-check

if [ "$?" = "0" ];
then
echo -en " TC Status ....."&& echo -e ${C_G}' OK'${C_NC}
	echo ''
else
	echo ''
	echo -e ${C_R}"TOOL CHAIN WARNING"${C_NC}
	echo 'There was a problem with the Tool-Chain.'
	echo "$0 Will now exit .."
	exit ''
	exit 1
fi

# Start Git clone
echo '---------------------------------------------------------------'
echo -e ${C_Y} " CLONING G4WJS [ $PKG_NAME ]"${C_NC}
echo '---------------------------------------------------------------'
echo ''
mkdir -p "$BUILDD"
if [[ -f $SRCD/src/bootstrap ]];
then
	cd "$SRCD/src"
	git pull
else
	cd "$SRCD"
		
	# ensure the directory is removed first
    if [[ -d $SRCD/src ]]
    then
        rm -rf "$SRCD/src"
    fi

	# clone the repository
    git clone git://git.code.sf.net/u/bsomervi/hamlib src
	cd "$SRCD/src"

	# checkout the integration branch
	git checkout integration
fi

# run hamlib bootstrap
cd "$SRCD/src"
echo ''
echo '---------------------------------------------------------------'
echo -e ${C_Y} " RUN BOOTSTRAP [ $PKG_NAME ]"${C_NC}
echo '---------------------------------------------------------------'
echo ''
echo 'Running bootstrap'
./bootstrap

# run configure
cd "$BUILDD"
echo ''
echo '---------------------------------------------------------------'
echo -e ${C_Y} " CONFIGURING [ $PKG_NAME ]"${C_NC}
echo '---------------------------------------------------------------'
echo ''
echo '.. This may take a several minutes to complete'

# configure for static only with Libusb, without readline
echo -en ".. Build Type: " && echo -e ${C_G}'Static'${C_NC}
echo ''
../src/configure --prefix="$PREFIX" \
--disable-shared \
--enable-static \
--disable-winradio \
--without-cxx-binding \
--without-readline \
CC="$TC/gcc.exe" \
CXX="$TC/g++.exe" \
CFLAGS="-g -O2 -fdata-sections -ffunction-sections -I$LIBUSBINC" \
LDFLAGS="-Wl,--gc-sections" \
LIBUSB_LIBS="-L$LIBUSBD -lusb-1.0"

# clean build
echo ''
echo '---------------------------------------------------------------'
echo -e ${C_Y} " RUNNING MAKE CLEAN [ $PKG_NAME ]"${C_NC}
echo '---------------------------------------------------------------'
echo ''
make clean

# run make
echo ''
echo '----------------------------------------------------------------'
echo -e ${C_Y} " RUNNING MAKE ALL [ $PKG_NAME ]"${C_NC}
echo '----------------------------------------------------------------'
echo ''
make -j$CPUS

# make install-strip
echo ''
echo '----------------------------------------------------------------'
echo -e ${C_Y} " INSTALLING [ $PKG_NAME ]"${C_NC}
echo '----------------------------------------------------------------'
echo ''
make install-strip

# generate Build Info file
if [[ $? = "0" ]];
then
	if [[ -f $PREFIX/$PKG_NAME.build.info ]]
    then
        rm -f "$PREFIX/$PKG_NAME.build.info"
    fi

	echo ''
	echo '---------------------------------------------------------------'
	echo -e ${C_Y} " ADDING BUILD INFO [ $PKG_NAME.build.info ] "${C_NC}
	echo '---------------------------------------------------------------'
	echo ''
	echo '  Creating Hamlib3 Build Info File'

(
cat <<EOF

# Package Information
Build Date...: $TIMESTAMP
BUILDER......: $BUILDER
Prefix.......: $PREFIX
Pkg Name.....: $PKG_NAME
Pkg Version..: development
Tool Chain...: $QTV

# Source Location and Integration
Git URL......: git://git.code.sf.net/u/bsomervi/hamlib
Git Extra....: git checkout integration'

# Configure Options <for Static>
--prefix="$PREFIX" \
--disable-shared \
--enable-static \
--disable-winradio \
--without-cxx-binding \
--without-readline \
CC="$TC/gcc.exe" \
CXX="$TC/g++.exe" \
CFLAGS="-g -O2 -fdata-sections -ffunction-sections -I$LIBUSBINC" \
LDFLAGS="-Wl,--gc-sections" \
LIBUSB_LIBS="-L$LIBUSBD -lusb-1.0"

# Build Commands
make -j$CPUS
make install-strip

EOF
) > "$PREFIX/$PKG_NAME.build.info"
	echo '  Finished'
fi

# copy dll
echo ''
echo '---------------------------------------------------------------'
echo -e ${C_Y} " COPY DLL's TO [ $PREFIX/BIN ]"${C_NC}
echo '---------------------------------------------------------------'
echo ''
echo "* $LIBUSBD/libusb-1.0.dll"
cp -u "$LIBUSBD/libusb-1.0.dll" "$PREFIX/bin"
echo "* $TC/libwinpthread-1.dll"
cp -u "$TC/libwinpthread-1.dll" "$PREFIX/bin" 
echo ''

# update pokgconfig
echo ''
echo '---------------------------------------------------------------'
echo -e ${C_Y} " FIXUP PKGCONFIG "${C_NC}
echo '---------------------------------------------------------------'
echo ''
echo '  Updating hamlib.pc'
sed -i 's/Requires.private\: libusb-1.0/Requires.private\:/g' "$PREFIX/lib/pkgconfig/hamlib.pc" >/dev/null 2>&1

# test rigctl.exe binary
echo ''
echo '---------------------------------------------------------------'
echo -e ${C_Y} " TESTING RIGCTL"${C_NC}
echo '---------------------------------------------------------------'
echo ''
$PREFIX/bin/rigctl.exe --version

# finished
echo ''
echo '----------------------------------------------------------------'
echo -e ${C_G} " FINISHED COMPILING [ $PKG_NAME ]"${C_NC}
echo '----------------------------------------------------------------'
echo ''
package-data
echo ''

# exit script
exit 0
