#!/bin/sh
#
# Project    : ipv6calc
# File       : autogen.sh
# Version    : $Id: autogen.sh,v 1.24 2013/10/02 06:41:24 ds6peter Exp $
# Copyright  : 2003-2011 by Peter Bieringer <pb (at) bieringer.de>
#
# Information: autogeneration of projects with optional features

OPTIONS_CONFIGURE=""

LAST=""
while [ "$1" != "$LAST" ]; do
	LAST="$1"
	case $1 in
	    '--no-make'|'-n')
		shift
		flag_no_make=1
		;;
	    '--all'|'-a')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --enable-geoip --enable-ip2location"
		;;
	    '--geoip'|'-g')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --enable-geoip"
		;;
	    '--geoip-dyn')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --enable-geoip --with-geoip-dynamic"
		;;
	    '--ip2location'|'-i')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --enable-ip2location"
		;;
	    '--ip2location-dyn')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --enable-ip2location --with-ip2location-dynamic"
		;;
	    '--disable-db-ieee')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --disable-db-ieee"
		;;
	    '--disable-db-ipv4')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --disable-db-ipv4"
		;;
	    '--disable-db-ipv6')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --disable-db-ipv6"
		;;
	    '--geoip-ipv6-compat')
		shift
		OPTIONS_CONFIGURE="$OPTIONS_CONFIGURE --with-geoip-ipv6-compat"
		;;
	    '-W')
		shift
		EXTRA_CFLAGS="-Werror"
		;;
	    '-?'|'-h'|'--help')
		echo "Supported options:"
		echo "   -?|-h|--help       : this help"
		echo "   -W                 : use extra CFLAGS=-Werror"
		echo "   -n|--no-make       : stop before running 'make'"
		echo "   -a|--all           : enable GeoIP and IP2Location support"
		echo "   -g|--geoip         : enable GeoIP support"
		echo "   --geoip-dyn        : switch to dynamic library loading of GeoIP"
		echo "   -i|--ip2location   : enable IP2Location support"
		echo "   --ip2location-dyn  : switch to dynamic library loading of IP2Location"
		echo "   --disable-db-ieee  : disable builtin IEEE database"
		echo "   --disable-db-ipv4  : disable builtin IPv4 database"
		echo "   --disable-db-ipv6  : disable builtin IPv6 database"
		echo "   --geoip-ipv6-compat: enable GeoIP IPv6 compatibility mode"
		exit 1
	esac
done

if [ -f Makefile ]; then
	echo "*** cleanup"
	make autoclean
fi

echo "*** run: autoheader"
autoheader || exit 1

echo "*** run: autoconf"
autoconf || exit 1

echo "*** run: configure, options: $OPTIONS_CONFIGURE $*"
./configure --bindir=/usr/bin --mandir=/usr/share/man $OPTIONS_CONFIGURE $* || exit 1

if [ "$flag_no_make" = "1" ]; then
	echo
	echo "Stop before running 'make'"
	exit
fi

echo "*** run: make clean"
make clean || exit 1

export EXTRA_CFLAGS
echo "*** run: make"
make || exit 1

echo "*** run: make test"
make test || exit 1

echo
echo "For installing the binaries, type: make install"
