# st
speedie's simple terminal configuration

![image](https://user-images.githubusercontent.com/71722170/163290759-e171e5f0-3e9b-4c23-85bf-b45f19a37b34.png)

This is my personal always-changing build of [suckless.org](https://suckless.org)'s simple terminal or [st](https://st.suckless.org).
It features many different patches and tweaks to enhance the experience.

### Important
- This build REQUIRES libXft-bgra. If you don't know what that is, it's a patched build of libXft which fixes a bug which causes st to crash when displaying certain characters.
- This build does not keep object files or config.h. Those are automatically deleted after a successful compile. If a compile is not successful, they will not be deleted. If that's the case, do NOT edit config.h because if you do and it compiles successfully then your changes will be lost.

### Installation
- Install dev-vcs/git using your favorite package manager
- git clone <this-url>
- cd st
- sudo make install

### Installing libXft-bgra
Thankfully, I made this process a bit easier by building it into the Makefile.
- cd st
- make libxftfix # For all distros except Gentoo
- make gentoo-libxftfix # For Gentoo

If you're on Arch Linux you can also install libXft-bgra from the AUR yourself.

### Features
This build of dwm has been patched pretty heavily with the following patches
- st-alpha
- st-anysize
- st-autocomplete
- st-blinking_cursor
- st-bold-is-not-bright
- st-boxdraw
- st-clipboard
- st-delkey
- st-externalpipe
- st-font2
- st-fontfix
- st-ligatures
- st-newterm
- st-scrollback
- st-scrollback-mouse
