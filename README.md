### What is it?

This a fork of the original [hprofile][1].

hprofile is a bash shell script that can help you manage various profiles.

Examples could be:

  1. Manage multiple hardware configurations, for example if you boot your system
     both within VMWare and in a normal dualboot configuration, or if you have a
	 hardwares e.g. laptop/desktop with similar configuration files.

  2. Manage multiple network connections, for example if you connect to different
     networks at home and at work, or if you access multiple wireless networks.
     This is handy for a complex setting because modern network manager are full
	 of features for that.

  3. Manage multiple power profiles, automatically scaling down your CPU speed,
     reducing the brightness of your display and turning off certain resource
	 hungry services when your laptop is running on batteries, and turn it all
	 back on again as soon as you plug in the power.

The possibilities really are endless. hprofile makes it very easy to define a
"profile" consisting of a group of configuration (or other) files, anywhere in
the file system, switching them around with a single command. You can also run
arbitrary scripts when profiles are applied or "stopped", to start or stop rc 
services or configure your hardware. Individual users can even define their own
files (in their home directory) to be switched and scripts to be run, to react
when profiles are changed.

Best of all, hprofile is deceptively simple to use. Each type of profile has a
directory where you define which files are to be switched around simply by naming
them with a suffix of ".profile-name" in a directory hierarchy which mirrors
the rest of the file system. Scripts to be run when profiles are applied or
"stopped" are kept in a separate directory, and all you need to do to make sure
the script is run at the appropriate time is to name it "profile-name.start"
or "profile-name.stop". The tarball comes with a few pratical examples and a
README file to get going.

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

