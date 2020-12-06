#!/usr/bin/bash

sudo mkdir system $dir
sudo rsync -r -t -v --progress -l -s /etc /root system
sudo rsync -r -t -v --progress -l -s /usr/share/icons system
sudo rsync -r -t -v --progress -l -s /usr/share/sddm system
sudo rsync -r -t -v --progress -l -s /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/ui/FullRepresentation.qml system/
