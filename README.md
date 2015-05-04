This a fork of the original [hprofile][1].

INTRODUCTION
------------

hprofile is a shell script utility to manage profiles (hardware/software.)
(3.x is a bash script while	4.x is a zsh counterpart on {ba,z}sh branches,
while 5.x is POSIX shell.)

The sources tarball comes with the following profiles.

PROFILES (TYPES)
----------------

## vga

Set up X server configuration files on the fly depending on driver driver
or hardware state.

## power

Manage power profile for different sub-systems on the fly.

## disk

Manage hard disk power management using hdparm (software.)

## rfkill

Manage software RFKill capable devices.
(Beware that some hardware require a cold reboo to function properly afterwards.)

DOCUMENTATION
-------------

See hprofile(1) man page

INSTALLATION
------------

    make DESTDIR=/ prefix=/usr/local install

LICENSE
-------

Distributed under the GNU General Plublic License version 2
as pugblished by the Free Software Fondation, Inc.

**BIG FAT WARNING:**

     **USE AT YOUR OUWN RISK, EVERYTHING IS GIVEN 'AS IS'**

[1]: http://hprofile.sourceforge.net
