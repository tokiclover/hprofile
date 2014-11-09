PACKAGE     = hprofile
VERSION     = $(shell sed -nre '16,/\t\[/s/\tversion ([0-9].*)/\1/p' $(PACKAGE))

prefix      = /usr/local
bindir      = $(prefix)/bin
sysconfdir	= /etc
svcconfdir	= $(sysconfdir)/conf.d
svcinitdir	= $(sysconfdir)/init.d
datadir     = $(prefix)/share/$(PACKAGE)
docdir      = $(prefix)/share/doc/$(PACKAGE)-${VERSION}

INSTALL     = install
install_SCRIPT = $(INSTALL) -m 755
install_DATA   = $(INSTALL) -m 644
MKDIR_P     = mkdir -p

dist_EXTRA  = \
	AUTHORS \
	COPYING \
	README \
	ChangeLog
dist_ACPI   = \
	actions/power \
	events/power
dist_PROFILE_disk   = \
	 ata.zsh \
	 default \
	 post-start \
	 profiles \
	 ptest \
	 scripts/adp.start \
	 scripts/bat.start \
	 scripts/dyn.start \
	 scripts/quiet.start \
	 usb.zsh
dist_PROFILE_power  = \
	 default \
	 profiles \
	 ptest \
	 scripts/adp.start \
	 scripts/bat.start \
	 scripts/dyn.start \
	 scripts/med.start \
	 scripts/quiet.start \
	 start
dist_PROFILE_rfkill = \
	 default \
	 profiles \
	 scripts/bsw.start \
	 scripts/bsw.stop \
	 scripts/ksw.start \
	 scripts/ksw.stop \
	 scripts/wsw.start \
	 scripts/wsw.stop
dist_PROFILE_vga    = \
	 default \
	 files/etc/X11/xorg.conf.d/40-monitor.conf.fglrx \
	 files/etc/X11/xorg.conf.d/40-monitor.conf.intel \
	 files/etc/X11/xorg.conf.d/40-monitor.conf.nouveau \
	 files/etc/X11/xorg.conf.d/40-monitor.conf.nv \
	 files/etc/X11/xorg.conf.d/40-monitor.conf.nvidia \
	 files/etc/X11/xorg.conf.d/40-monitor.conf.radeon \
	 post-start \
	 post-stop \
	 profiles \
	 ptest \
	 scripts/fglrx.start \
	 scripts/fglrx.stop \
	 scripts/intel.start \
	 scripts/nouveau.start \
	 scripts/nouveau.stop \
	 scripts/nvidia.start \
	 scripts/nvidia.stop \
	 scripts/radeon.start \
	 scripts/radeon.stop
DISTDIRS    = \
	$(bindir) \
	$(datadir) $(docdir) \
	$(svcconfdir) $(svcinitdir) $(sysconfdir) \
	$(sysconfdir)/acpi/actions $(sysconfdir)/acpi/events
DISTFILES   =
.SECONDEXPANSION:
PROFILES    = \
	disk \
	power \
	rfkill \
	vga

.FORCE:
.PHONY: all install install-doc install-profile

all:

install-doc : $(dist_EXTRA)
install: $(DISTDIRS) $(PROFILES)
	$(install_DATA)   $(PACKAGE).conf  $(DESTDIR)$(sysconfdir)/$(PACKAGE)
	$(install_SCRIPT) $(PACKAGE)       $(DESTDIR)$(bindir)
	$(install_SCRIPT) $(PACKAGE).initd $(DESTDIR)$(svcinitdir)/$(PACKAGE)
	$(install_DATA)   $(PACKAGE).confd $(DESTDIR)$(svcconfdir)/$(PACKAGE)
	$(install_SCRIPT) acpi/actions/power $(DESTDIR)$(sysconfdir)/acpi/actions/power
	$(install_DATA)   acpi/events/power  $(DESTDIR)$(sysconfdir)/acpi/events/power

$(dist_EXTRA): .FORCE
	$(install_DATA) $@ $(DESTDIR)$(docdir)/$@
$(DISTDIRS): .FORCE
	$(MKDIR_P) $(DESTDIR)$@
$(PROFILES): .FORCE
	for file in $(dist_PROFILE_$@); do \
		$(install_DATA) -D profiles/$@/$${file} \
		$(DESTDIR)/$(sysconfdir)/$(PACKAGE)/profiles/$@/$${file}; \
	done

.PHONY: uninstall uninstall-doc

uninstall: $(foreach dir,$(PROFILES),uninstall-profile-$(dir))
	rm -f $(DESTDIR)$(sysconfdir)/$(PACKAGE)/$(PACKAGE).conf
	rm -f $(DESTDIR)$(bindir)/$(PACKAGE)
	rm -f $(DESTDIR)$(svcinitdir)/$(PACKAGE)
	rm -f $(DESTDIR)$(svcconfdir)/$(PACKAGE)
	rm -f $(DESTDIR)$(sysconfdir)/acpi/actions/power
	rm -f $(DESTDIR)$(sysconfdir)/acpi/events/power
	for dir in $(DISTDIRS); do \
		rmdir $(DESTDIR)$${dir}; \
	done
	-rmdir -p $(DESTDIR)$(sysconfdir)/$(PACKAGE)/profiles
uninstall-profile-%:
	for file in $(dist_PROFILE_$*); do \
		rm -f $(DESTDIR)$(sysconfdir)/$(PACKAGE)/profiles/$*/$${file}; \
	done
	-rmdir -p $(DESTDIR)$(sysconfdir)/$(PACKAGE)/profiles/$*/files/etc/X11/xorg.conf.d
	-rmdir $(DESTDIR)$(sysconfdir)/$(PACKAGE)/profiles/$*/scripts
	-rmdir $(DESTDIR)$(sysconfdir)/$(PACKAGE)/profiles/$*
uninstall-doc:
	for doc in $(dist_EXTRA); do \
		rm -f $(DESTDIR)$(docdir)/$${doc}; \
	done
	rmdir $(DESTDIR)$(docdir)

