#!/bin/sh

apt-get update && apt-get install -y \
	build-essential \
	texinfo \
	libgtk-3-dev \
	libgccjit libgccjit-dev \
	libjpeg-dev libtiff-dev libgif-dev \
	librsvg2-dev \
	libgnutls28-dev \
	libnurses libncurses-dev \
	libsystemd-dev

# install emacs documentations & info manuals
apt-get install -y emacs-common-non-dfsg

./autogen.sh
./configure --with-native-compilation \
	--with-mailutils \
	--with-modules \
	--with-mailutils \
	--with-file-notification=inotify
make -j$(nproc)
sudo make install
# sudo make uninstall

# create desktop icon for emacs
# ln -s ~/.emacs.d/emacs.desktop ~/.local/share/applications/emacs.desktop

