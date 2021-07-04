#!/bin/bash
loadkeys ru
setfont ter-u18b
clear
echo''
echo "UEFI или Legacy на выбор!"
echo''
echo '-------------------------'
echo''
echo "Начнём установку? "

while
    read -n1 -p  "
    1 - да

    0 - нет: " hello # sends right after the keypress
    echo ''
    [[ "$hello" =~ [^10] ]]
do
    :
done
 if [[ $hello == 1 ]]; then
  clear
  echo "Добро пожаловать в установку ArchLinux"
  elif [[ $hello == 0 ]]; then
   exit
fi
###
echo ""
#echo " Обновление ключей "
clear
pacman -Syy
#echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
#pacman-key --refresh-keys
##

echo "Добро пожаловать в установку ArchLinux режим GRUB-Legacy "
lsblk -f
echo ""
echo " Выбирайте "1", если ранее не производилась разметка диска и у вас нет разделов для ArchLinux "
echo ""
echo 'Нужна разметка диска?'
while
   read -n1 -p  "
   1 - да

   0 - нет: " cfdisk # sends right after the keypress
    echo ''
    [[ "$cfdisk" =~ [^10] ]]
do
   :
done
 if [[ $cfdisk == 1 ]]; then
  clear
 lsblk -f
  echo ""
read -p " Укажите диск (sda/sdb/sdc) " cfd
cfdisk /dev/$cfd
elif [[ $cfdisk == 0 ]]; then
echo 'разметка пропущена.'
fi
#
 clear
 lsblk -f
  echo ""
read -p "Укажите ROOT раздел(sda/sdb 1.2.3.4 (sda5 например)):" root
echo ""
mkfs.btrfs -f /dev/$root -L Root
mount /dev/$root /mnt

btrfs sub cr /mnt/@
#btrfs subvolume create /mnt/@home

umount /dev/$root
mount -o rw,noatime,compress-force=zstd,discard=async,autodefrag,space_cache=v2,subvol=@ /dev/$root /mnt
mkdir -p /mnt/home
echo ""
##
 clear
 lsblk -f
  echo ""

clear
echo ""
echo " Можно использовать раздел от предыдущей системы( и его не форматировать )
далее в процессе установки можно будет удалить все скрытые файлы и папки в каталоге
пользователя"
echo ""
echo 'Добавим раздел  HOME ?'
while
    read -n1 -p  "
    1 - да

    0 - нет: " homes # sends right after the keypress
    echo ''
    [[ "$homes" =~ [^10] ]]
do
    :
done
   if [[ $homes == 0 ]]; then
     echo 'пропущено'
  elif [[ $homes == 1 ]]; then
    echo ' Форматируем HOME раздел?'
while
    read -n1 -p  "
    1 - да

    0 - нет: " homeF # sends right after the keypress
    echo ''
    [[ "$homeF" =~ [^10] ]]
do
    :
done
   if [[ $homeF == 1 ]]; then
   echo ""
   lsblk -f
#   read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
#   mkfs.ext4 /dev/$home -L home
#   mkdir /mnt/home
#   mount /dev/$home /mnt/home
    read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
    mount /dev/$home /mnt
    btrfs sub cr /mnt/@home
    umount /dev/$home
    mount -o rw,noatime,compress-force=zstd,discard=async,autodefrag,space_cache=v2,subvol=@home /dev/$home /mnt/home
   elif [[ $homeF == 0 ]]; then
 lsblk -f

# read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" homeV
# mount /dev/$homeV /mnt
# btrfs sub cr /mnt/@home
# umount /dev/$homeV
 lsblk -f

# read -p "Укажите ROOT раздел(sda/sdb 1.2.3.4 (sda5 например)):" root
# mount -o rw,noatime,compress-force=zstd,discard=async,autodefrag,space_cache=v2,subvol=@ /dev/$root /mnt
# mkdir -p /mnt/home
# mount -o noatime,compress-force=zstd,discard=async,autodefrag,space_cache=v2,subvol=@home /dev/$root /mnt/home

 read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" homeV
 mount -o rw,noatime,compress-force=zstd,discard=async,autodefrag,space_cache=v2,subvol=@home /dev/$homeV /mnt/home

# mount /dev/$homeV /mnt/home
fi
fi
###################  раздел  ###############################################################
 clear

# смена зеркал
echo ""

pacman -Sy --noconfirm
 ###################################################################################
clear
echo ""
echo " Если у вас есть wifi модуль и вы сейчас его не используете, то для "
echo " исключения ошибок в работе системы рекомендую "1" "
echo ""
echo 'Установка базовой системы, будете ли вы использовать wifi?'
while
    read -n1 -p  "
    1 - да

    2 - нет: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^12] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
  clear
  pacstrap /mnt base linux linux-headers dhcpcd which netctl inetutils  base-devel  wget linux-firmware  nano wpa_supplicant dialog
  genfstab -pU /mnt >> /mnt/etc/fstab
elif [[ $x_pacstrap == 2 ]]; then
  clear
  pacstrap /mnt base dhcpcd linux linux-headers which netctl inetutils pacman-contrib base-devel wget linux-firmware nano
  genfstab -pU /mnt >> /mnt/etc/fstab
fi
 clear
###############################
clear
echo "Если вы производите установку используя Wifi тогда рекомендую  "1" "
echo ""
echo "если проводной интернет тогда "2" "
echo ""
echo 'wifi или dhcpcd ?'
while
    read -n1 -p  "1 - wifi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  curl -LO https://raw.githubusercontent.com/alexgantera/arch/my_kde/chroot.sh
  mv chroot.sh /mnt
  chmod +x /mnt/chroot.sh

  echo 'первый этап готов '
  echo 'ARCH-LINUX chroot'
  echo '1. проверь  интернет для продолжения установки в черуте || 2.команда для запуска ./chroot.sh '
  arch-chroot /mnt
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -a
reboot
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/alexgantera/arch/my_kde/chroot.sh)"
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -a
reboot

fi


##############################################
elif [[ $menu == 0 ]]; then
exit
fi
