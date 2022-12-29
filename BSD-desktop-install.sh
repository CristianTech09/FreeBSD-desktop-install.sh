#!/bin/sh
dialog --backtitle "BSD-desktop-install" \
                 --title "Welcome!" \
                 --msgbox "welcome to the installation procedure of the desktop environment on freeBSD (and derivatives)" 0 0
dialog --backtitle "BSD-desktop-install" --title "insert your UNIX user" \
--inputbox "to configure (Sudo) and some permissions you need to know which user you need to assign them to" 0 0 2>user.txt
TMPUSER=`cat user.txt`
rm user.txt
echo \*****************
echo Installing...
echo \*****************
sleep 1
echo 3!
sleep 1
echo 2!
sleep 1
echo 1!...
sleep 1
pkg
pkg install -y nano
pkg install -y sudo
pkg install -y xorg
pkg install -y sddm
pkg install -y kde5
echo "proc	/proc		procfs	rw	0	0">>/etc/fstab
sysrc dbus_enable=yes
sysrc hald_enable=yes
sysrc sddm_enable=yes
touch /home/$TMPUSER/.xinitrc
echo "exec startkde">/home/$TMPUSER/.xinitrc
echo "$TMPUSER ALL=(ALL:ALL) ALL">>/usr/local/etc/sudoers
pkg install -y firefox
dialog --backtitle "BSD-desktop-install" \
                 --title "Congratulation!" \
                 --msgbox "The installation was complete, click enter to reboot system" 0 0
reboot
