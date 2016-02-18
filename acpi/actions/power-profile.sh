#!/bin/sh
#
# $Header: /etc/acpi/actions/power-profile.sh            Exp $
#

set $*
group=${1%/*}
action=${1#*/}
device=$2
id=$3
value=$4

case $group in
	(ac_adapter)
		case $value in
			*0) hprofile power.bat;;
			*1) hprofile power.adp;;
		esac
		;;
	(battery)
		case $value in
			*0|*1) hprofile power.adp;;
		esac
		;;
esac

#
# vim:fenc=utf-8:ft=sh:ci:pi:sts=0:sw=4:ts=4:
#
