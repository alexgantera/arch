#!/usr/bin/bash

sudo mkdir -p system/icons $dir
sudo rsync -r -t -v -a --progress -l -s /etc /root system

sudo rsync -r -t -v -a --progress -l -s /usr/share/icons/My_icons system/icons
sudo rsync -r -t -v -a --progress -l -s /usr/share/icons/default system/icons
sudo rsync -r -t -v -a --progress -l -s /usr/share/icons/Qogir-white-cursors system/icons

sudo rsync -r -t -v -a --progress -l -s /usr/share/fish system
sudo rsync -r -t -v -a --progress -l -s /usr/share/pipewire system
sudo rsync -r -t -v -a --progress -l -s /usr/share/sddm system
sudo rsync -r -t -v -a --progress -l -s /usr/share/nano-syntax-highlighting system
sudo rsync -r -t -v -a --progress -l -s /usr/share/alsa-card-profile system
sudo rsync -r -t -v -a --progress -l -s /var/spool/cron system
