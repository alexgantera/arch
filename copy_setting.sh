#!/usr/bin/bash

sudo mkdir -p system/icons $dir
sudo rsync -r -v --progress -l /etc /root system
sudo chattr -i $dir system/etc/resolv.conf


sudo rsync -r -v -a --progress -l /usr/share/icons/My_icons system/icons
sudo rsync -r -v -a --progress -l /usr/share/icons/default system/icons
sudo rsync -r -v -a --progress -l /usr/share/icons/Qogir-white-cursors system/icons

sudo rsync -r -v -a --progress -l /usr/share/nano system
sudo rsync -r -v -a --progress -l /usr/share/nano-syntax-highlighting system

sudo rsync -r -v -a --progress -l /usr/share/pipewire system
sudo rsync -r -v -a --progress -l /usr/share/alsa-card-profile system

sudo rsync -r -v -a --progress -l /usr/share/sddm system

sudo rsync -r -v -a --progress -l /usr/share/fish system

sudo rsync -r -v -a --progress -l /var/spool/cron system
