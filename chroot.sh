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
#####################################
echo " Настройка localtime "
echo ""
echo " Укажите город(1-27) и нажмите Enter  "
 while
    read   -p  "
    1 - Калининград        14 - Красноярск

    2 - Киев               15 - Магадан

    3 - Киров              16 - Новокузнецк

    4 - Минск              17 - Новосибирск

    5 - Москва             18 - Омск

    6 - Самара             19 - Уральск

    7 - Саратов            20 - Алматы

    8 - Ульяновск          21 - Среднеколымск

    9 - Запарожье          22 - Ташкент

    10 - Чита              23 - Тбилиси

    11 - Иркутск           24 - Томск

    12 - Стамбул           25 - Якутск

    13 - Камчатка          26 - Екатеринбург

                27 - Ереван


0 - пропустить  : " wm_sity
    echo ''
    [[ $wm_sity -lt 0 ||$wm_sity -gt 27 || "$wm_sity" =~ [^12345670] ]]
do
    :
done
if [[ $wm_sity == 1 ]]; then
   ln -sf /usr/share/zoneinfo/Europe/Kaliningrad /etc/localtime
    echo " Калиниград "
elif [[ $wm_sity == 2 ]]; then
  ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
    echo " Киев  "
elif [[ $wm_sity == 3 ]]; then
   ln -sf /usr/share/zoneinfo/Europe/Kirov /etc/localtime
    echo " Киров  "
elif [[ $wm_sity == 4 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Minsk /etc/localtime
    echo " Минск  "
elif [[ $wm_sity == 5 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
    echo " Москва  "
elif [[ $wm_sity == 6 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Samara /etc/localtime
    echo " Самара   "
elif [[ $wm_sity == 7 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Saratov /etc/localtime
    echo " Саратов   "
elif [[ $wm_sity == 8 ]]; then
   ln -sf /usr/share/zoneinfo/Europe/Ulyanovsk /etc/localtime
    echo " Ульяновск  "
elif [[ $wm_sity == 9 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Zaporozhye /etc/localtime
    echo " Запорожье "
elif [[ $wm_sity == 10 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Chita /etc/localtime
    echo " Чита "
elif [[ $wm_sity == 11 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Irkutsk /etc/localtime
    echo " Иркутск  "
elif [[ $wm_sity == 12 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Istanbul /etc/localtime
    echo " Стамбул  "
elif [[ $wm_sity == 13 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Kamchatka /etc/localtime
    echo " Камчатка "
elif [[ $wm_sity == 14 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Krasnoyarsk /etc/localtime
    echo " Красноярск "
elif [[ $wm_sity == 15 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Magadan /etc/localtime
    echo " Магадан   "
elif [[ $wm_sity == 16 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Novokuznetsk /etc/localtime
    echo " Новокузнецк   "
elif [[ $wm_sity == 17 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime
    echo " Новосибирск  "
elif [[ $wm_sity == 18 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Omsk /etc/localtime
    echo " Омск "
elif [[ $wm_sity == 19 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Oral /etc/localtime
    echo " Уральск "
elif [[ $wm_sity == 20 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Almaty /etc/localtime
    echo " Алматы  "
elif [[ $wm_sity == 21 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Srednekolymsk /etc/localtime
    echo " Среднеколымск  "
elif [[ $wm_sity == 22 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Tashkent /etc/localtime
    echo " Ташкент "
elif [[ $wm_sity == 23 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Tbilisi /etc/localtime
    echo " Тбилиси "
elif [[ $wm_sity == 24 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Tomsk /etc/localtime
    echo " Томск   "
elif [[ $wm_sity == 25 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Yakutsk /etc/localtime
    echo " Якутск   "
elif [[ $wm_sity == 26 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
    echo " Екатеринбург "
elif [[ $wm_sity == 27 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Yerevan /etc/localtime
    echo " Ереван "
elif [[ $wm_sity == 0 ]]; then
clear
echo " Этап пропущен "
echo ""
fi
echo " Часовой пояс установлен "
#####################################
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
echo ""
echo " Укажите пароль для ROOT "
passwd

echo ""
useradd -m -g users -G wheel -s /bin/bash $username
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
chown -R $username:users /home/$username/systemd-boot-pacman-hook
chown -R $username:users /home/$username/systemd-boot-pacman-hook/PKGBUILD
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
pacman -S grub os-prober  --noconfirm
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
echo ""
echo ""
echo " Добавление Multilib репозитория"
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
echo " Multilib репозиторий добавлен"
######
pacman -Sy xorg-server xorg-drivers --noconfirm
clear

echo "Добавление репозитория Archlinuxcn"
echo '[archlinuxcn]' >> /etc/pacman.conf
echo 'Server = https://mirror.xtom.nl/archlinuxcn/$arch' >> /etc/pacman.conf

pacman -Syy archlinuxcn-keyring --noconfirm
clear

echo " Установка KDE и набора программ "
echo " "

echo "Для отображения иконки Pamac в трее нужно будет установить пакет pamac-tray-icon-plasma "

echo " "

# Последний вариант

pacman -Sy plasma kde-system-meta kio-extras konsole yakuake htop dkms --noconfirm

pacman -S alsa-utils ark aspell aspell-en aspell-ru audacious audacious-plugins bat bind bleachbit --noconfirm

pacman -S firefox-i18n-ru dnsmasq dolphin-plugins downgrade fd filelight findutils fzf git --noconfirm

pacman -S gnome-calculator gtk-engine-murrine telegram-desktop gvfs gvfs-afc gvfs-mtp gvfs-gphoto2 --noconfirm

pacman -S gwenview haveged highlight kfind lib32-alsa-plugins lib32-freetype2 lib32-glu lib32-libcurl-gnutls --noconfirm

pacman -S lib32-libpulse lib32-libxft lib32-libxinerama lib32-libxrandr lib32-openal lib32-openssl-1.0 --noconfirm

pacman -S lib32-sdl2_mixer ntfs-3g nano-syntax-highlighting neofetch noto-fonts-emoji okular perl-image-exiftool --noconfirm

pacman -S partitionmanager pcmanfm pkgfile p7zip pulseaudio-alsa --noconfirm

pacman -S pamac-aur qbittorrent plasma5-applets-weather-widget qt5-xmlpatterns systemd-kcm --noconfirm

pacman -S kate smplayer smplayer-themes spectacle terminus-font timeshift --noconfirm

pacman -S ttf-arphic-ukai ttf-arphic-uming ttf-caladea ttf-carlito ttf-croscore ttf-dejavu --noconfirm

pacman -S ttf-liberation ttf-sazanami unrar xclip xorg-xrandr zim yay youtube-dl starship --noconfirm


pacman -Rns discover --noconfirm

echo "Для отображения иконки Pamac в трее нужно будет установить пакет pamac-tray-icon-plasma "

wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh

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

grub-mkfont -s 16 -o /boot/grub/ter-u16b.pf2 /usr/share/fonts/misc/ter-u16b.otb
grub-mkconfig -o /boot/grub/grub.cfg
clear
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
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
echo " Заменим оболочку терминала на fish или zsh? "
echo ""
echo "При необходимости можно будет установить другую оболочку в уже установленной системе "
while
    read -n1 -p  "
    1 - установить zsh
    2 - установить fish
    0 - оставим bash по умолчанию " x_shell
    echo ''
    [[ "$x_shell" =~ [^120] ]]
do
    :
done
if [[ $x_shell == 0 ]]; then
clear
  echo ' Оболочка не изменена, по умолчанию bash '
elif [[ $x_shell == 1 ]]; then
clear
pacman -S zsh  zsh-syntax-highlighting zsh-autosuggestions grml-zsh-config --noconfirm
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /etc/zsh/zshrc
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> /etc/zsh/zshrc

chsh -s /bin/zsh
chsh -s /bin/zsh $username
clear
echo " При первом запуске консоли(терминала) нажмите "0" "
echo " Оболочка изменена с bash на zsh "
elif [[ $x_shell == 2 ]]; then
pacman -S fish

chsh -s /bin/fish
chsh -s /bin/fish $username
clear
echo " Оболочка изменена с bash на fish "
fi
echo ""
clear
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
  chown -R $username:users  /home/$username/{Downloads,Music,Pictures,Videos,Documents}
  exit
fi
clear
echo " Установка завершена для выхода введите >> exit << "
exit
