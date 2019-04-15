#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo adduser git
sudo apt-get -y install mc nmap git
wget https://dl.gogs.io/0.11.86/gogs_0.11.86_linux_amd64.tar.gz
tar xvf gogs_0.11.86_linux_amd64.tar.gz
sudo mkdir /var/log/gogs
sudo chown -R git:git /var/log/gogs/
sudo cp gogs/scripts/systemd/gogs.service /etc/systemd/system
sudo rsync -avz gogs/* /home/git/
sudo chown -R git:git /home/git/
sudo setcap CAP_NET_BIND_SERVICE=+eip /home/git/gogs

echo "[Unit]
Description=Gogs
After=syslog.target
After=network.target

[Service]
# Modify these two values and uncomment them if you have
# repos with lots of files and get an HTTP error 500 because
# of that
###
#LimitMEMLOCK=infinity
#LimitNOFILE=65535
Type=simple
User=git
Group=git
WorkingDirectory=/home/git
ExecStart=/home/git/gogs web -port 80
Restart=always
Environment=USER=git HOME=/home/git

# Some distributions may not support these hardening directives. If you cannot start the service due
# to an unknown option, comment out the ones not supported by your version of systemd.
##ProtectSystem=full
##PrivateDevices=yes
##PrivateTmp=yes
##NoNewPrivileges=true

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/gogs.service

# /etc/ssh/sshd_config: Port 2200
cd /home/git/
sudo mkdir custom
cd custom
sudo mkdir conf
cd conf
sudo touch app.ini
echo "APP_NAME = gogs
RUN_USER = git
RUN_MODE = prod

[database]
DB_TYPE  = sqlite3
HOST     = 127.0.0.1:3306
NAME     = gogs
USER     = root
PASSWD   =
SSL_MODE = disable
PATH     = data/gogs.db

[repository]
ROOT = /home/git/gogs-repositories

[server]
DOMAIN           = virtgepipje
HTTP_PORT        = 80
ROOT_URL         = http://virtgepipje:80/
DISABLE_SSH      = false
SSH_PORT         = 22
START_SSH_SERVER = true
OFFLINE_MODE     = false

[mailer]
ENABLED = false

[service]
REGISTER_EMAIL_CONFIRM = false
ENABLE_NOTIFY_MAIL     = false
DISABLE_REGISTRATION   = false
ENABLE_CAPTCHA         = true
REQUIRE_SIGNIN_VIEW    = false

[picture]
DISABLE_GRAVATAR        = false
ENABLE_FEDERATED_AVATAR = false

[session]
PROVIDER = file

[log]
MODE      = file
LEVEL     = Info
ROOT_PATH = /home/git/log

[security]
INSTALL_LOCK = true
SECRET_KEY = haoVAtD4oKMe" >> /home/git/custom/conf/app.ini

sudo chown -R git:git /home/git/custom 


sudo shutdown -r now








