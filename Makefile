# Makefile for Linux
#
# Prerequsists : Microsoft Net Core SDK

PROGRAM	:=	JTSDK64-msys2
VERSION	:=	3.1.0
AUTHOR	:=	Greg Beam, KI7MT
LICENSE	:=	GPLv3
BUGS	:=	https://github.com/KI7MT/jtsdk64-msys2/issues
WEB		:=	https://github.com/KI7MT/jtsdk-msys2

# Script Applications
RM		:=	/usr/bin/rm -f
MKDIR	:=	/usr/bin/mkdir -p
CP		:=	/usr/bin/cp -u
HOME	:=	$HOME
BINDIR	:=	${HOME}/bin
INSTALL	:=	install

install:
	@echo ''
	@echo '---------------------------------------------'
	@echo "Installing $(PROGRAM) v$(VERSION)"
	@echo '---------------------------------------------'
	@echo ''
	${MKDIR}/{bin,src}
	@${INSTALL} -m 755 ./src/bin/*.sh ${BINDIR}
	@echo

uninstall:
	@echo ''
	@echo '---------------------------------------------'
	@echo "Uninstalling $(PROGRAM) v$(VERSION)"
	@echo '---------------------------------------------'
	@echo ''
	${RM} ${BINDIR}/*.sh
	@echo ''
