#!/bin/bash
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
pkg install -y nano sudo xorg sddm kde5 firefox libreoffice vim drm-kmod
echo "proc	/proc		procfs	rw	0	0">>/etc/fstab
sysrc dbus_enable=yes
sysrc hald_enable=yes
sysrc sddm_enable=yes
touch /home/$TMPUSER/.xinitrc
echo "exec startkde">/home/$TMPUSER/.xinitrc
pw group mod wheel -m $TMPUSER
echo "%wheel ALL=(ALL:ALL) ALL">>/usr/local/etc/sudoers
clear
echo Now I need to know which video card you have in your computer in order to load the correct driver.
echo paste the right driver name into the box
echo if you have an intel gpu enter:  "i915kms"
echo if you have an amd gpu enter:    "amdgpu"
echo if you have an radeon gpu enter: "radeonkms"
read USER_DRIVER_PC
echo ok hai impostato $USER_DRIVER_PC
sysrc -f /etc/rc.conf kld_list+=$USER_DRIVER_PC
sysrc -f /etc/rc.conf kld_list+=acpi_video
sleep 3
dialog --backtitle "BSD-desktop-install" \
                 --title "Congratulation!" \
                 --msgbox "The installation was complete, click enter to reboot system" 0 0
reboot
