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

### Installation (Package manager)
If you're running Gentoo Linux, you can add my overlay and then simply emerge it.
- emerge layman
- layman -o https://raw.githubusercontent.com/spoverlay/splay/main/splay.xml -f -a splay
- emerge st-spde
  
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
- st-bold-is-not-bright
- st-boxdraw
- st-charoffsets
- st-clipboard
- st-delkey
- st-externalpipe
- st-font2
- st-fontfix
- st-glyph-wide-support-boxdraw
- st-ligatures-alpha-scrollback
- st-newterm
- st-nobadweight
- st-scrollback
- st-scrollback-mouse
- st-spoiler
- st-w3m
- st-xclearwin
- st-xresources
- st-keyboard-select
- st-undercurl
- st-csi
- st-copyurl
- st-dynamic-cursor-color
  
This build of st has full compatibility with .Xresources and allows defining these options:
- !! st resources
- ! special
- *.foreground:             #e7e7e7
- *.background:             #202020
- *.cursorColor:            #e7e7e7
- ! black
- *.color0:                 #262626
- *.color8:                 #737373
- ! red
- *.color1:                 #ff3534
- *.color9:                 #ff4f4c
- ! green
- *.color2:                 #35b723
- *.color10:                #82ff6e
- ! yellow
- *.color3:                 #eae804
- *.color11:                #dfff52
- ! blue
- *.color4:                 #362be4
- *.color12:                #5767ff
- ! magenta
- *.color5:                 #fa9cf8
- *.color13:                #cf89cf
- ! cyan
- *.color6:                 #4ed4d4
- *.color14:                #68efef
- ! white
- *.color7:                 #bebebe
- *.color15:                #f7f5f5
- ! alpha
- *.alpha:                  0.7
- ! font
- *.font:                   Terminus:pixelsize=15.5:antialias=true:autohint=true;
- *.font2:                  JoyPixels:pixelsize=12

Pywal support is also a thing and will automatically be used. No special scripts like my builds of dwm and dmenu require.

It also supports color emojis as long as libXft is patched, otherwise it will CRASH. It has an emoji picker. To use it, add a keybind to your build of dwm which runs /usr/bin/emojilist (Requires dmenu). It allows copying the output of a command. To use it, add a keybind to your build of dwm which runs /usr/bin/copyout (Requires dmenu) Keep in mind if you're using my build of dwm, these binds are already added.

### Keybinds
- CTRL+y      | Copy to the clipboard
- CTRL+p      | Paste from the clipboard
- CTRL+=      | Increase font size
- CTRL+-      | Decrease font size
- CTRL+0      | Reset font size to default
- CTRL+j      | Scroll down
- CTRL+k      | Scroll up
- CTRL+Shift+k| Copy the last URL
- CTRL+Enter  | Opens a new terminal window in the same directory
- Scroll+up   | Scroll up (Mouse scrollback support)
- Scroll+down | Scroll down (Mouse scrollback support)
- Shift+Esc   | Select mode
- 
- If you're using my zsh config:
- I           | Enter Insert mode
- Esc         | Enter Normal mode
- Tab         | Autocomplete

