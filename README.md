### What is it?

This a fork of the original [hprofile][1].

hprofile is a bash shell script that can help you manage various profiles.

Examples could be:

  1. Manage multiple hardware configurations:
     e.g. laptop/desktop with similar configuration files.

  2. Manage multiple network connections stack:
     This is handy for a complex setting because modern network manager are full
	 of features for that.

  3. Manage multiple power profiles, automatically setting your CPU power profile,
     adjusting display brightness and turning off certain sub-systems depending
	 on hardware of software state.

hprofile make it easy to define *profiles* which is just a directory whith shell
scripts and a mirror of files to be swapped--sym-linked to be precise.

Take a look at profiles/{disk,power,rfkill,vga} for practical examples. vga is a
profile which swap XOrg configuration file depending on the kernel module in use.
power is a profile which manage power profile for different sub-systems: cpu, usb,
pci, pci aspm, nmi watchdog, vm write back time out and intel hda sound card.

### README

See the REAME file

### Installation

You must and should already have make, so just run:

    make DESTDIR=/ prefix=/usr/local install

to install everything in the usual/standard GNU/Linux File System Hierchy.

### License

GNU General Plublic License version 2
as pugblished by the Free Software Fondation, Inc.

[1]: http://hprofile.sourceforge.net

