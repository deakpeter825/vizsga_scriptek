#!/bin/bash


echo "samba" > etc/hostname

echo "127.0.1.1		localhost" > /etc/hosts

echo "127.0.1.1		samba" >> /etc/hosts

sudo apt-get update
sudo apt-get install samba -y

# leterhozunk egy kozos dirt amely mindenki számára olvasására és írására

sudo mkdir/srv/kozos
sudo chmod 755 /srv/readonly

cd /etc/samba
sudo mv /etc/samba/smb.conf /etc/samba/smb_old.conf
cp ./smb.conf /etc/samba/smb.conf


sudo service smbd restart
sudo service smbd status
sudo testparm
sudo adduser user2

sudo mkdir /srv/user2
sudo chown user2 /srv/user2
sudo chmod 700 /srv/user2


sudo smbpasswd -a user2 hallgato #adjuk meg a jelszót: hallgato

sudo service smbd restart
