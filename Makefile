PACKAGE     = hprofile
VERSION     = $(shell sed -nre '16,/\t\[/s/\t\[version\]=([0-9].*)/\1/p' $(PACKAGE))

prefix      = /usr/local
bindir      = ${DESTDIR}${prefix}/bin
sys_confdir	= ${DESTDIR}/etc
svc_confdir	= ${sys_confdir}/conf.d
svc_initdir	= ${sys_confdir}/init.d
datadir	    = ${DESTDIR}${prefix}/share/$(PACKAGE)
docdir      = ${DESTDIR}${prefix}/share/doc/$(PACKAGE)-${VERSION}

DOCS        = AUTHORS COPYING README ChangeLog
PROFILES    = disk power rfkill sample vga

all:

install:
	install -pd $(bindir)
	install -pd $(svc_confdir)
	install -pd $(svc_initdir)
	install -pd $(sys_confdir)/$(PACKAGE)
	install -pm 644 $(PACKAGE).conf $(sys_confdir)/$(PACKAGE)
	install -pm 755 $(PACKAGE) $(bindir)
	install -pm 755 $(PACKAGE).initd $(svc_initdir)/$(PACKAGE)
	install -pm 644 $(PACKAGE).confd $(svc_confdir)/$(PACKAGE)
	$(shell) for profile in $(PROFILES); do \
		find profiles/$${profile} -type f -exec \
		install -D -pm 644 '{}' $(sys_confdir)/$(PACKAGE)/'{}' \;; \
	done

install_doc:
	install -pd $(docdir)
	$(shell) for doc in $(DOCS); do \
		install -pm 644 $${doc} $(docdir); \
	done

uninstall:
	rm -f $(sys_confdir)/$(PACKAGE)/$(PACKAGE).conf
	rm -f $(bindir)/$(PACKAGE)
	rm -f $(svc_initdir)/$(PACKAGE)
	rm -f $(svc_confdir)/$(PACKAGE)
	$(shell) for profile in $(PROFILES); do \
		rm -fr $(sys_confdir)/$(PACKAGE)/profiles/$${profile}; \
	done
	rmdir $(sys_confdir)/$(PACKAGE)/profiles
	rmdir $(sys_confdir)/$(PACKAGE)

uninstall_doc:
	$(shell) for doc in $(DOCS); do \
		rm -f $(docdir)/$${doc}; \
	done
	rmdir $(docdir)

