### What is it?

This a fork of the original [hprofile][1].

hprofile is a bash shell script that can help you manage various profiles.

Examples could be:

  1. Manage multiple hardware configurations:
     e.g. laptop/desktop with similar configuration files.

  2. Manage multiple network connections stack:
     This is handy for a complex setting because modern network manager are full
	 of features for that.

  3. Manage multiple power profiles, automatically setting CPU power profile,
     adjusting display brightness and turning off certain sub-systems depending
	 on hardware or software state.

hprofile make it easy to define *profiles* which is just a directory whith shell
scripts and a mirror of files to be swapped--sym-linked to be precise.

Take a look at profiles/{disk,power,rfkill,vga} for practical examples.

## vga

# Description:

a profile which swap XOrg configuration file depending on the kernel module in use.

# Profiles:

fglrx, intel, radeon, nouveau, nv, nvidia
(that corresopn to xf86-video-profile, profile being a X.Org driver minus nvidia)

## power

# Description:

a profile which manage power profile for different sub-systems: cpu, usb, pci,
pci aspm, nmi watchdog, vm write back time out and intel hda sound card.

# Profiles:

adp (AC adapter), bat (battery), dyn (dynamic, stand for performance), quiet

## disk

# Description:

a profile to manage hard disk power management using hdparm software.

# Profiles:

named as power profile names.

## rfkill

# Description:

a simple profile to manage software RFKill capable devices, beware that, some
hardware require a cold reboot (that is, shutdown and removing the battery for
a few secondes) to function properly afterwards.

# Profiles:

bsw (bluetooth switch), wsw (wireless/wifi switch), ksw (kill switch, bsw+wsw)

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

