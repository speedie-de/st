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
	$(CC) -o $@ $(OBJ) $(STLDFLAGS) && rm config.h boxdraw.o hb.o st.o x.o ; cp copyout emojilist ${PREFIX}/bin ; chmod +x ${PREFIX}/bin/copyout ${PREFOX}/bin/emojilist

clean:
	rm -f st $(OBJ) st-$(VERSION).tar.gz

dist: clean
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st-$(VERSION).tar.gz
	rm -rf st-$(VERSION) && rm config.h

install: st
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st
	cp -f st-autocomplete $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st-autocomplete
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < st.1 > $(DESTDIR)$(MANPREFIX)/man1/st.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/st.1
	tic -sx st.info
	@echo Please see the README file regarding the terminfo entry of st.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(PREFIX)/bin/st-autocomplete
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1

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
	makepkg -si

help:
	@echo install: Installs st. You may need to run this as root.
	@echo uninstall: Uninstalls st. You may need to run this as root.
	@echo libxftfix: This option compiles and installs libXft-bgra which is necessary to prevent st from crashing.
	@echo gentoo-libxftfix: This option installs libXft-bgra by patching it for Gentoo only.
	@echo arch-libxftfix: This option installs libXft-bgra using the AUR on Arch Linux only.
	@echo help: Displays this help sheet.

.PHONY: all options clean dist install uninstall libxftfix arch-libxftfix gentoo-libxftfix help
