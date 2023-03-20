#!/bin/bash
 
set -e -u

umask 022

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/bash root
cp -aT /etc/skel/ /root/
chmod 750 /root
passwd -d root

#useradd -m liveuser -u 500 -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash
useradd -m -p "" -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash liveuser
chown -R liveuser:liveuser /home/liveuser

if ! grep -q "liveuser" /etc/sudoers;  then
	echo "liveuser ALL=(ALL) ALL" >> /etc/sudoers
fi

#enable autologin
groupadd -r autologin
gpasswd -a liveuser autologin

groupadd -r nopasswdlogin
gpasswd -a liveuser nopasswdlogin

##
mkdir -pv /home/liveuser/Desktop
chown liveuser:liveuser /home/liveuser/Desktop

#systemd services
systemctl enable haveged
systemctl enable NetworkManager.service
systemctl enable pacman-init.service choose-mirror.service
systemctl enable ntpd.service
systemctl enable smb.service
systemctl enable nmb.service
systemctl enable vboxservice.service
systemctl enable sshd.service
systemctl enable bluetooth.service
systemctl enable lightdm.service
systemctl set-default graphical.target

## Fix permissions
chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel
#chmod 644 /etc/systemd/system/*.service
chown 0 /etc/sudoers.d
chown 0 /etc/sudoers.d/g_wheel
chown root:root /etc/sudoers.d
chown root:root /etc/sudoers.d/g_wheel
chmod 755 /

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

## Wifi not available with networkmanager (BugFix)
su -c 'echo "" >> /etc/NetworkManager/NetworkManager.conf'
su -c 'echo "[device]" >> /etc/NetworkManager/NetworkManager.conf'
su -c 'echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager.conf'


# This is key!
pacman-key --init
pacman-key --populate archlinux

# Stop lightdm user from expiring
chage -E -1 lightdm

pacman -Rs xfwm4-themes --noconfirm

LC_ALL=C xdg-user-dirs-update --force

rm -rf /usr/share/backgrounds/xfce
rm -rf /usr/share/backgrounds/gnome


####

pacman -Sc --noconfirm
pacman -Syu --noconfirm --needed

####
cp -af /usr/share/applications/menux.desktop /home/liveuser/Desktop/menux.desktop
cp -af /usr/share/applications/wgetm.desktop	  /home/liveuser/Desktop/wgetm.desktop
cp -af /usr/share/applications/playmovie.desktop	  /home/liveuser/Desktop/playmovie.desktop
cp -af /usr/share/applications/axelc8.desktop	  /home/liveuser/Desktop/axelc8.desktop
chown liveuser:liveuser /home/liveuser/Desktop/*.desktop
chmod +x /home/liveuser/Desktop/*.desktop
chown liveuser /home/liveuser/Desktop/*.desktop

