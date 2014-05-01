#!/usr/bin/env bash

# quit on fail
set -e

DEPENDENCIES="x-window-system virtualbox-guest-x11 wmaker rungetty libltdl7 udisks policykit-desktop-privileges"

sudo apt-get update
sudo apt-get -y install $DEPENDENCIES

#echo 'ATTRS{idVendor}=="1949",ATTRS{idProduct}=="0004",MODE="0666",GROUP="vagrant"' > /etc/udev/rules.d/70-kindle.rules
#sed -i "s@^      <allow_any.*@      <allow_any>yes</allow_any>@" /usr/share/polkit-1/actions/org.freedesktop.udisks.policy
#cp /vagrant/55-myconf.conf /etc/polkit-1/localauthority/50-local.d/

sed -i "s@^exec /sbin/getty.*@exec /sbin/rungetty tty1 --autologin vagrant@" /etc/init/tty1.conf

HOME=/home/vagrant sudo -u vagrant /bin/bash <<EOF
mkdir -p ~/GNUstep/Library/WindowMaker
echo "calibre &" > ~/GNUstep/Library/WindowMaker/autostart
chmod +x ~/GNUstep/Library/WindowMaker/autostart
echo "exec wmaker" > ~/.xinitrc
cp /vagrant/.bash_profile ~
EOF

sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
sudo shutdown -h now
