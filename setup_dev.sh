#!/usr/bin/env bash

# quit on fail
set -e

# x windows, window manager, virtualbox guest, mount as non-root, boot to gui
DEPENDENCIES="x-window-system virtualbox-guest-x11 wmaker rungetty udisks policykit-desktop-privileges"

# additional packages for calibre
DEPENDENCIES="$DEPENDENCIES libltdl7 fonts-liberation fonts-mathjax libaudio2 libchm1 libjs-mathjax libjs-sphinxdoc libjs-underscore libmysqlclient18 libpodofo0.9.0 libqt4-dbus libqt4-declarative libqt4-designer libqt4-help libqt4-network libqt4-opengl libqt4-script libqt4-scripttools libqt4-sql libqt4-sql-mysql libqt4-svg libqt4-test libqt4-xml libqt4-xmlpatterns libqtassistantclient4 libqtcore4 libqtdbus4 libqtgui4 libqtwebkit4 libtidy-0.99-0 libwebpmux1 mysql-common python-apsw python-beautifulsoup python-cherrypy3 python-cssselect python-cssutils python-dateutil python-dnspython python-feedparser python-markdown python-mechanize python-netifaces python-pil python-pygments python-pyparsing python-qt4 python-repoze.lru python-routes python-sip python-utidylib python-webob qdbus qtchooser qtcore4-l10n"

sudo apt-get update
sudo apt-get -y install $DEPENDENCIES

sed -i "s@^exec /sbin/getty.*@exec /sbin/rungetty tty1 --autologin vagrant@" /etc/init/tty1.conf

HOME=/home/vagrant sudo -u vagrant /bin/bash <<EOF
mkdir -p ~/GNUstep/Library/WindowMaker
echo "calibre &" > ~/GNUstep/Library/WindowMaker/autostart
chmod +x ~/GNUstep/Library/WindowMaker/autostart
echo "exec wmaker" > ~/.xinitrc
cp /vagrant/.bash_profile ~
EOF

if [ -e /vagrant/custom_config.sh ]; then
  /vagrant/custom_config.sh
fi

sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
sudo shutdown -h now
