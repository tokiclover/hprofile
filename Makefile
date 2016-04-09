PACKAGE     = hprofile
VERSION     = $(shell sed -nre '1s/(.*):/\1/p' ChangeLog)

prefix      = /usr/local
exec_prefix = $(prefix)
bindir      = $(exec_prefix)/bin
sysconfdir	= /etc
svcconfdir	= $(sysconfdir)/conf.d
svcinitdir	= $(sysconfdir)/init.d
datadir     = $(prefix)/share
docdir      = $(datadir)/doc
mandir      = $(datadir)/man

INSTALL     = install
install_SCRIPT = $(INSTALL) -m 755
install_DATA   = $(INSTALL) -m 644
MKDIR_P     = mkdir -p

dist_EXTRA  = \
	AUTHORS \
	COPYING \
	README.md \
	ChangeLog
dist_ACPI   = \
	actions/power-profile.sh \
	events/power-profile
dist_PROFILES = \
	disk-functions \
	power-functions \
	rfkill-functions \
	vga/functions \
	vga/etc/X11/xorg.conf.d/40-monitor.conf.fglrx \
	vga/etc/X11/xorg.conf.d/40-monitor.conf.intel \
	vga/etc/X11/xorg.conf.d/40-monitor.conf.nouveau \
	vga/etc/X11/xorg.conf.d/40-monitor.conf.nv \
	vga/etc/X11/xorg.conf.d/40-monitor.conf.nvidia \
	vga/etc/X11/xorg.conf.d/40-monitor.conf.radeon
DISTDIRS    = \
	$(bindir) \
	$(docdir)/$(PACKAGE)-$(VERSION) $(mandir)/man1 \
	$(svcconfdir) $(svcinitdir) $(sysconfdir)/$(PACKAGE) \
	$(sysconfdir)/acpi/actions $(sysconfdir)/acpi/events
DISTFILES   = $(dist_PROFILES)
.SECONDEXPANSION:

.FORCE:
.PHONY: all install install-doc install-profile

all:

install-doc : $(dist_EXTRA)
install: install-dir $(DISTFILES)
	$(install_SCRIPT) $(PACKAGE)       $(DESTDIR)$(bindir)
	$(install_SCRIPT) $(PACKAGE).initd $(DESTDIR)$(svcinitdir)/$(PACKAGE)
	$(install_DATA)   $(PACKAGE).confd $(DESTDIR)$(svcconfdir)/$(PACKAGE)
	$(install_DATA)   $(PACKAGE).1     $(DESTDIR)$(mandir)/man1
	$(install_SCRIPT) acpi/actions/power-profile.sh $(DESTDIR)$(sysconfdir)/acpi/actions
	$(install_DATA)   acpi/events/power-profile  $(DESTDIR)$(sysconfdir)/acpi/events
	$(install_DATA) -D hp.vim $(DESTDIR)$(datadir)/vim/vimfiles/syntax/hp.vim
$(dist_EXTRA): .FORCE
	$(install_DATA) $@ $(DESTDIR)$(docdir)/$(PACKAGE)-$(VERSION)/$@
install-dir: .FORCE
	$(MKDIR_P) $(DISTDIRS:%=$(DESTDIR)%)
$(dist_PROFILES): .FORCE
	$(install_DATA) -D $@ $(DESTDIR)/$(sysconfdir)/$(PACKAGE)/$@

.PHONY: uninstall uninstall-doc

uninstall: uninstall-doc
	rm -f $(dist_ACPI:%=$(DESTDIR)$(sysconfdir)/acpi/%)
	rm -f $(dist_EXTRA:%=$(DESTDIR)$(docdir)/$(PACKAGE)-$(VERSION)/%)
	rm -f $(dist_PROFILES:%=$(DESTDIR)$(sysconfdir)/$(PACKAGE)/%)
	rm -f $(DESTDIR)$(bindir)/$(PACKAGE)
	rm -f $(DESTDIR)$(mandir)/man1/$(PACKAGE).1
	rm -f $(DESTDIR)$(svcinitdir)/$(PACKAGE)
	rm -f $(DESTDIR)$(svcconfdir)/$(PACKAGE)
	-rmdir $(DESTDIR)$(sysconfdir)/$(PACKAGE)/*
	-rmdir $(DISTDIRS:%=$(DESTDIR)%)

