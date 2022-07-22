# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c boxdraw.c hb.c
OBJ = $(SRC:.c=.o)

all: options st

options:
	@echo st build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h hb.h
hb.o: st.h
boxdraw.o: config.h st.h boxdraw_data.h

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ) st-spde-$(VERSION).tar.gz

dist: clean
	mkdir -p st-spde-$(VERSION)
	cp -R arg.h autocomplete.h boxdraw.c boxdraw_data.h config.def.h config.mk st.png st.desktop docs hb.c hb.h Makefile st.1 st-autocomplete st.c st.h st.info win.h x.c docs/st-keybinds st-spde-$(VERSION)
	tar -cf - st-spde-$(VERSION) | gzip > st-spde-$(VERSION).tar.gz
	rm -rf st-spde-$(VERSION)

install: st
	touch config.h boxdraw.o hb.o st.o x.o
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)$(PREFIX)/bin
	cp -f docs/bindlist $(DESTDIR)$(PREFIX)/bin/stbindlist
	cp -f docs/st-keybinds $(DESTDIR)$(PREFIX)/bin
	chmod +x $(DESTDIR)$(PREFIX)/bin/st-keybinds
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st
	cp -f st-autocomplete $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st-autocomplete
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < st.1 > $(DESTDIR)$(MANPREFIX)/man1/st.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/st.1
	rm -f config.h boxdraw.o hb.o st.o x.o
	tic -sx st.info
	@echo Please see the README file regarding the terminfo entry of st.
	mkdir -p $(DESTDIR)$(ICONPREFIX)
	mkdir -p $(DESTDIR)$(APPPREFIX)
	cp -f st.desktop $(DESTDIR)$(APPPREFIX)
	[ -f $(ICONNAME) ] && cp -f $(ICONNAME) $(DESTDIR)$(ICONPREFIX) || :

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(APPPREFIX)/st.desktop
	rm -f $(DESTDIR)$(PREFIX)/bin/st-autocomplete
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1
	rm -f $(DESTDIR)$(ICONPREFIX)/$(ICONNAME)

libxftfix:
	git clone https://github.com/uditkarode/libxft-bgra && cd libxft-bgra
	sh autogen.sh --sysconfdir=/etc --prefix=/usr --mandir=/usr/share/man
	make install
	cd .. && rm -r libxft-bgra

gentoo-libxftfix:
	mkdir -pv /etc/portage/patches/x11-libs/libXft
	curl -o /etc/portage/patches/x11-libs/libXft/bgra.diff https://gitlab.freedesktop.org/xorg/lib/libxft/-/merge_requests/1.patch
	emerge x11-libs/libXft

arch-libxftfix:
	git clone https://aur.archlinux.org/libxft-bgra
	cd libxft-bgra
	makepkg -i

help:
	@echo install: Installs st. You may need to run this as root.
	@echo uninstall: Uninstalls st. You may need to run this as root.
	@echo libxftfix: This option compiles and installs libXft-bgra which is necessary to prevent st from crashing.
	@echo gentoo-libxftfix: This option installs libXft-bgra by patching it for Gentoo only.
	@echo arch-libxftfix: This option installs libXft-bgra using the AUR on Arch Linux only.
	@echo help: Displays this help sheet.

.PHONY: all options clean dist install uninstall libxftfix arch-libxftfix gentoo-libxftfix help
