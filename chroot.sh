#!/bin/bash

echo 'скрипт второй настройка системы в chroot '
timedatectl set-ntp true
pacman -Syyu --noconfirm
echo ""
read -p "Введите имя компьютера: " hostname
echo ""
echo " Используйте в имени только буквы латинского алфавита "
echo ""
read -p "Введите имя пользователя: " username

echo $hostname > /etc/hostname
echo ""
echo " Очистим папку конфигов, кеш, и скрытые каталоги в /home/$username от старой системы ? "
while
    read -n1 -p  "
    1 - да
    0 - нет: " i_rm      # sends right after the keypress
    echo ''
    [[ "$i_rm" =~ [^10] ]]
do
    :
done
if [[ $i_rm == 0 ]]; then
clear
echo " очистка пропущена "
elif [[ $i_rm == 1 ]]; then
rm -rf /home/$username/.*
clear
echo " очистка завершена "
fi
echo " Настройка localtime "
echo ""
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo " Часовой пояс установлен "

#####################################
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=ter-u16b" >> /etc/vconsole.conf
echo ""
echo " Укажите пароль для ROOT "
passwd

echo ""
useradd -m -g $username -G wheel -s /bin/bash $username
echo ""
echo 'Добавляем пароль для пользователя '$username' '
echo ""
passwd $username
echo ""
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo ""
pacman -Syy
clear
lsblk -f
###########################################################################
echo ""
echo " Если установка производиться на vds тогда grub "
echo ""
echo " Если у вас версия UEFI моложе 2013г. тогда ставьте UEFI-grub "
echo ""
echo "Какой загрузчик установить UEFI(systemd или GRUB) или Grub-legacy"
while
    read -n1 -p  "
    1 - UEFI(systemd-boot )

    2 - GRUB(legacy)

    3 - UEFI-GRUB: " t_bootloader # sends right after the keypress

    echo ''
    [[ "$t_bootloader" =~ [^123] ]]
do
    :
done
if [[ $t_bootloader == 1 ]]; then
bootctl install
clear
echo ' default arch ' > /boot/loader/loader.conf
echo ' timeout 10 ' >> /boot/loader/loader.conf
echo ' editor 0' >> /boot/loader/loader.conf
echo 'title   Arch Linux' > /boot/loader/entries/arch.conf
echo "linux  /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo ""
echo " Добавим ucode cpu? "
while
    read -n1 -p  "
    1 - amd

    2 - intel

    0 - ucode не добавляем : " i_cpu   # sends right after the keypress
    echo ''
    [[ "$i_cpu" =~ [^120] ]]
do
    :
done
if [[ $i_cpu == 0 ]]; then
clear
echo " Добавление ucode пропущено "
elif [[ $i_cpu  == 1 ]]; then
clear
pacman -S amd-ucode --noconfirm
echo  'initrd /amd-ucode.img ' >> /boot/loader/entries/arch.conf
elif [[ $i_cpu  == 2 ]]; then
clear
pacman -S intel-ucode  --noconfirm
echo ' initrd /intel-ucode.img ' >> /boot/loader/entries/arch.conf
fi
echo "initrd  /initramfs-linux.img" >> /boot/loader/entries/arch.conf
clear
lsblk -f
echo ""
echo " Укажите тот радел который будет после перезагрузки, то есть например "

echo " при установке с флешки ваш hdd может быть sdb, а после перезагрузки sda "

echo " выше видно что sdbX например примонтирован в /mnt, а после перезагрузки systemd будет искать корень на sdaX "

echo " если указать не правильный раздел система не загрузится "

echo " если у вас один hdd/ssd тогда это будет sda 99%"
echo ""
read -p "Укажите ROOT  раздел для загрузчика(пример  sda6,sdb3 ): " root
echo options root=/dev/$root rw >> /boot/loader/entries/arch.conf
#
cd /home/$username
git clone https://aur.archlinux.org/systemd-boot-pacman-hook.git
chown -R $username:$username /home/$username/systemd-boot-pacman-hook
chown -R $username:$username /home/$username/systemd-boot-pacman-hook/PKGBUILD
cd /home/$username/systemd-boot-pacman-hook
sudo -u $username makepkg -si --noconfirm
rm -Rf /home/$username/systemd-boot-pacman-hook
cd /home/$username
#
clear
elif [[ $t_bootloader == 2 ]]; then
clear
echo " Если на компьютере/сервере будет только один ArchLinux
и вам не нужна мультибут  >>> тогда 2
если же установка рядом в Windows или другой OS тогда 1 "
echo ""
echo " Нужен мультибут (установка рядом с другой OS)? "
while
    read -n1 -p  "
    1 - да

    2 - нет: " i_grub      # sends right after the keypress
    echo ''
    [[ "$i_grub" =~ [^12] ]]
do
    :
done
if [[ $i_grub == 2 ]]; then
pacman -S grub --noconfirm
lsblk -f
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
grub-mkconfig -o /boot/grub/grub.cfg
echo " установка завершена "
elif [[ $i_grub == 1 ]]; then
pacman -S grub grub-customizer os-prober  --noconfirm
lsblk -f
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
grub-mkconfig -o /boot/grub/grub.cfg
echo " установка завершена "
fi
elif [[ $t_bootloader == 3 ]]; then
pacman -S grub os-prober --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
fi
mkinitcpio -p linux
##########
echo ""
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
###########
echo ""
echo ""
echo " Добавление Multilib репозитория"
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
echo " Multilib репозиторий добавлен"
######
pacman -Sy xorg-server xf86-video-amdgpu --noconfirm
clear

echo "Добавление хука автоматической очистки кэша pacman "
echo "[Trigger]
Operation = Remove
Operation = Install
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Removing unnecessary cached files…
When = PostTransaction
Exec = /usr/bin/paccache -rvk0" >> /usr/share/libalpm/hooks/cleanup.hook
echo "Хук добавлен "
clear
echo " "
 echo "Добавление репозитория Archlinuxcn"
 echo '[archlinuxcn]' >> /etc/pacman.conf
 echo 'Server = http://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf
 pacman -Sy archlinuxcn-keyring --noconfirm
 clear

echo " Установка KDE и набора программ "

# Последний вариант

pacman -Sy plasma kde-system-meta kio-extras konsole yakuake htop dkms --noconfirm

pacman -S alsa-utils ark aspell aspell-en aspell-ru audacious audacious-plugins bat bind rsync --noconfirm

pacman -S dolphin-plugins grub-btrfs fd filelight findutils meld firefox firefox-i18n-ru --noconfirm

pacman -S fish fzf git gnome-calculator gtk-engine-murrine gvfs gwenview haveged highlight kfind lib32-alsa-plugins --noconfirm

pacman -S lib32-freetype2 lib32-glu lib32-libcurl-gnutls lib32-libpulse lib32-libxft lib32-libxinerama --noconfirm

pacman -S lib32-libxrandr lib32-openal lib32-openssl-1.0 lib32-sdl2_mixer nano-syntax-highlighting --noconfirm

pacman -S noto-fonts-emoji p7zip partitionmanager pcmanfm perl-image-exiftool pkgfile xdg-desktop-portal --noconfirm

pacman -S plasma5-applets-weather-widget python-pip python-virtualenv python-language-server qbittorrent --noconfirm

pacman -S kate smplayer smplayer-themes sox spectacle starship telegram-desktop --noconfirm

pacman -S terminus-font ttf-arphic-ukai ttf-arphic-uming ttf-caladea ttf-carlito ttf-croscore --noconfirm

pacman -S ttf-dejavu ttf-liberation ttf-sazanami unrar xclip xorg-xrandr foliate xreader youtube-dl zim expac --noconfirm

pacman -Syy fastfetch-git downgrade duf yay timeshift systemd-numlockontty ventoy-bin --noconfirm  --overwrite='*'

# pacman -S systemd-kcm downgrade duf yay timeshift systemd-numlockontty --noconfirm

systemctl enable numLockOnTty.service

clear

echo " Установка pipewire-pulse и pipewire-alsa "
yes | pacman -S pipewire-pulse pipewire-alsa
clear
fire
echo " Установка драйверов AMDGPU "

#pacman -S libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau --noconfirm
#pacman -S lib32-vulkan-icd-loader amdvlk lib32-amdvlk --noconfirm
pacman -S libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon --noconfirm
clear

pacman -Rns bluedevil discover plasma-thunderbolt bolt plasma-firewall --noconfirm


#wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh


grub-mkfont -s 16 -o /boot/grub/ter-u16b.pf2 /usr/share/fonts/misc/ter-u16b.otb
grub-mkfont -s 18 -o /boot/grub/ter-u18b.pf2 /usr/share/fonts/misc/ter-u18b.otb

grub-mkconfig -o /boot/grub/grub.cfg
clear
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:$username /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
echo "exec startplasma-x11 " >> /home/$username/.xinitrc
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
echo ""
pacman -R konqueror --noconfirm
clear
echo "Plasma KDE успешно установлена"
echo "Установка sddm "
pacman -S sddm sddm-kcm --noconfirm
systemctl enable sddm.service -f
echo "[General]" >> /etc/sddm.conf
echo "..." >> /etc/sddm.conf
echo "Numlock=on" >> /etc/sddm.conf
clear
echo " установка sddm  завершена "
pacman -Sy networkmanager networkmanager-openvpn network-manager-applet --noconfirm
systemctl enable NetworkManager.service
clear
echo ""

echo "  Установка  программ закончена"

echo ""

chsh -s /bin/fish
chsh -s /bin/fish $username
clear

clear

echo ""

echo "##################################################################################"
echo "###################№   <<<< Копирование настроек >>>    ######################№№№№"
echo "##################################################################################"

echo " Копируем настройки из /home/$username/system ?"
while
    read -n1 -p  "1 - да, 0 - нет: " vm_cpset # sends right after the keypress
    echo ''
    [[ "$vm_cpset" =~ [^10] ]]
do
    :
done
if [[ $vm_cpset == 0 ]]; then
  echo 'этап пропущен'
elif [[ $vm_cpset == 1 ]]; then

rm -r /root
#rm -r /usr/share/icons
rm -r /usr/share/sddm

cd /home/$username/system/
rsync -r -t -v --progress -l -s etc /
rsync -r -t -v --progress -l -s root /

rsync -r -t -v --progress -l -s nano /usr/share
rsync -r -t -v --progress -l -s fish /usr/share
rsync -r -t -v --progress -l -s icons /usr/share
rsync -r -t -v --progress -l -s sddm /usr/share
rsync -r -t -v --progress -l -s pipewire /usr/share
rsync -r -t -v --progress -l -s nano-syntax-highlighting /usr/share
rsync -r -t -v --progress -l -s alsa-card-profile /usr/share
rsync -r -t -v  --progress -l -s cron /var/spool


fi

mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg

echo "
Данный этап может исключить возможные ошибки при первом запуске системы
Фаил откроется через редактор  !nano!"
echo ""
echo " Просмотрим/отредактируем /etc/fstab ?"
while
    read -n1 -p  "1 - да, 0 - нет: " vm_fstab # sends right after the keypress
    echo ''
    [[ "$vm_fstab" =~ [^10] ]]
do
    :
done
if [[ $vm_fstab == 0 ]]; then
  echo 'этап пропущен'
elif [[ $vm_fstab == 1 ]]; then
nano /etc/fstab
fi
clear
echo "################################################################"
echo ""
echo "Создаем папки музыка, видео и т.д. в директории пользователя?"
while
    read -n1 -p  "1 - да, 0 - нет: " vm_text # sends right after the keypress
    echo ''
    [[ "$vm_text" =~ [^10] ]]
do
    :
done
if [[ $vm_text == 0 ]]; then
  echo 'этап пропущен'
 exit
elif [[ $vm_text == 1 ]]; then
  mkdir /home/$username/{Downloads,Music,Pictures,Videos,Documents}
  chown -R $username:$username  /home/$username/{Downloads,Music,Pictures,Videos,Documents}
exit
fi
clear
echo " Установка завершена для выхода введите >> exit << "
exit
