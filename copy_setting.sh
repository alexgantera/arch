#!/usr/bin/bash

sudo mkdir -p system/icons $dir
sudo rsync -r -t -v --progress -l -s /etc /root system

sudo rsync -r -t -v --progress -l -s /usr/share/icons/My_icons system/icons
sudo rsync -r -t -v --progress -l -s /usr/share/icons/default system/icons
sudo rsync -r -t -v --progress -l -s /usr/share/icons/Qogir-white-cursors system/icons

sudo rsync -r -t -v --progress -l -s /usr/share/sddm system
