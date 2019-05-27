# Makefile for MSYS2
#
# Prerequsists : MSYS2 Shell Initialization

PROGRAM	:=	JTSDK64 MSYS2 Scripts
VERSION	:=	3.1.0
AUTHOR	:=	Greg Beam, KI7MT
LICENSE	:=	GPLv3
BUGS	:=	https://github.com/KI7MT/jtsdk64-msys2/issues
WEB		:=	https://github.com/KI7MT/jtsdk-msys2

# foreground colors
C_R='\033[01;31m'	# red
C_G='\033[01;32m'	# green
C_Y='\033[01;33m'	# yellow
C_C='\033[01;36m'	# cyan
C_NC='\033[01;37m'	# no color

# Script Variables
RM		:=	/usr/bin/rm -f
MKDIR	:=	/usr/bin/mkdir -p
CP		:=	/usr/bin/cp -u
INSTALL	:=	install
USER	:=	$(shell whoami)
SCRIPTS	:=	$(wildcard ./src/bin/*.sh)
DOCS	:=	$(wildcard ./src/docs/*.html)

# Install Scripts
install:
	@clear ||:
	@echo ''
	@echo '---------------------------------------------'
	@echo -e ${C_Y}"Installing $(PROGRAM) v$(VERSION)"${C_NC}
	@echo '---------------------------------------------'
	@echo ''
	@${MKDIR} /home/$(USER)/{bin,src}
	@echo 'INSTALL SCRIPTS'
	@for f in $(SCRIPTS) ; do \
	echo " Installing $$f" ; \
	${INSTALL} -m 755 $$f /home/$(USER)/bin ; \
	done
	@echo ''
	@echo 'INSTALL DOCS'
	@for f in $(DOCS) ; do \
	echo " Installing Doc $$f" ; \
	${INSTALL} -m 755 $$f /home/$(USER)/docs ; \
	done
	@echo
	@echo -e ${C_C}"Finished"${C_NC}

# Uninstall Scripts
uninstall:
	@clear ||:
	@echo ''
	@echo '---------------------------------------------'
	@echo -e ${C_Y}"Uninstalling $(PROGRAM) v$(VERSION)"${C_NC}
	@echo '---------------------------------------------'
	@echo ''

	@echo 'REMOVE SCRIPTS'
	@for f in $(SCRIPTS) ; do \
	echo " Removing $$f" ; \
	${RM} /home/$(USER)/bin/$$f ; \
	done
	@echo ''
	@echo 'REMOVE DOCS'
	@for f in $(DOCSS) ; do \
	echo " Removing Doc $$f" ; \
	${RM} /home/$(USER)/docs/$$f ; \
	done
	@echo
	@echo -e ${C_C}"Finished"${C_NC}
