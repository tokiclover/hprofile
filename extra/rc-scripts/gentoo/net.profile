#!/sbin/runscript
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

# This startup script uses hprofile to select the last known good network profile.

depend() {
	use hotplug pcmcia
}

start() {
	# Use the previous profile; when the "stop" function below is run, the
	# "current" profile is stopped and becomes the "previous" profile.
	# Before we start it all again, run hprofile -p to find out what that
	# was. That way, if we were using profile "home" last time, assume we
	# want to keep using it.
	
	# Also note - if profile is empty, which will happen if there is no
	# "previous" profile, hprofile will fall back on the default profile
	
	profile=$(/usr/local/sbin/hprofile -p net)
	ebegin "Selecting network profile ${profile}"
	/usr/local/sbin/hprofile "net.${profile}"
	eend $?
}

# Do not stop the network profile - we want it to remain so that the next time we
# boot, the previous network profile is still reported as the "current" one.

stop() {
	ebegin "Stopping network profile"
	/usr/local/sbin/hprofile -s net
	eend $?
}


# vim:ts=4
