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
sudo mv smb.conf smb_old.conf

touch smb.conf

echo " [global]
netbios name=samba
security=user
map to guest=bad user
workgroup = WORKGROUP
public=yes" > etc/samba/smb.conf


echo " [kozos]
comment=nyilvános írható-olvasható megosztás
path=/srv/kozos
writeable=yes
read only=no
browseable=yes
guest ok=yes
public=yes

[readonly]
comment=nyilvános csak olvasható megosztás
path=/srv/readonly
read only=yes
browseable=yes
guest ok=yes
public=yes" >> etc/samba/smb.conf

sudo service smbd restart
sudo service smbd status
sudo testparm
sudo adduser user2

sudo mkdir /srv/user2
sudo chown user2 /srv/user2
sudo chmod 700 /srv/user2


echo "[user2]
comment=írható-olvasható megosztás a user2 felhasználónak
path=/srv/user2
writeable=yes
browseable=no
public=no
read list=user2
writelist=user2
force directory mode=0777
force create mode=0777" >> etc/samba/smb.conf

sudo smbpasswd -a user2 hallgato #adjuk meg a jelszót: hallgato

sudo service smbd restart
