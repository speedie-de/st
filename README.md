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
- Follow "Installing libXft-bgra"

### Installing libXft-bgra
Thankfully, I made this process a bit easier by building it into the Makefile.
- cd st
- make libxftfix # For all distros except Gentoo
- make gentoo-libxftfix # For Gentoo
- make arch-libxftfix # For Arch

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
- st-nobadweight
- st-charoffsets
  
This build of st has full compatibility with .Xresources and allows defining these options:
- st.foreground
- st.background
- st.cursorColor
- st.color0
- st.color8
- st.color1
- st.color9
- st.color2
- st.color10
- st.color3
- st.color11
- st.color4
- st.color12
- st.color5
- st.color13
- st.color6
- st.color14
- st.color7
- st.color15
- st.alpha
- st.font

Pywal support is also a thing and will automatically be used. No special scripts like my builds of dwm and dmenu require.

It also supports color emojis as long as libXft is patched, otherwise it will CRASH. It has an emoji picker. To use it, add a keybind to your build of dwm which runs /usr/bin/emojilist (Requires dmenu). It allows copying the output of a command. To use it, add a keybind to your build of dwm which runs /usr/bin/copyout (Requires dmenu) Keep in mind if you're using my build of dwm, these binds are already added.

### Keybinds
Here's a fairly incomplete list of keybinds for my build of st
- CTRL+y      | Copy (yank) to the clipboard
- CTRL+p      | Paste from the clipboard
- CTRL+=      | Increase font size
- CTRL+-      | Decrease font size
- CTRL+0      | Reset font size to default
- CTRL+j      | Scroll down
- CTRL+k      | Scroll up
- CTRL+Enter  | Opens a new terminal window in the same directory
- Scroll+up   | Scroll up (Mouse scrollback support)
- Scroll+down | Scroll down (Mouse scrollback support)

If you're using my zsh config (szsh):
- i           | Enter Insert mode
- Esc         | Enter Normal mode
- Tab         | Autocomplete

If you're using my build of dwm:
- Alt+Shift+e | Open emoji picker
- Alt+Shift+c | Open copyout selection
  
Most of these are Vim keybinds.
