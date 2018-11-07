#!/bin/bash
# BASH-MISHINUH SEEKEEM

# # Prep system
echo "[*] Prepping System"
sudo apt-get update
sudo apt-get upgrade -y
pgrep python | xargs kill

# # Install Pre-Requisites
echo "[*] Installing Prerequisite Packages"
sudo apt-get install -y \
build-essential \
expect \
libmemcached-dev \
libmysqlclient-dev
memcached \
mysql-server \
python-dev \
python-mysqldb \
python-mysqldb-dbg \
python-pip \
python-pycurl \
python-recaptcha \
zlib1g-dev \

# # Clone Rootthebox
echo "[*] Cloning Repo"
# if [ -d "RootTheBox" ]; then rm -Rf RootTheBox; fi
git clone git://github.com/armenr/RootTheBox.git
cd RootTheBox

# # Set up Dependencies for RootTheBox
echo "[*] Installing Python Packages From Pip"
defusedxml \
future \
mysql-python \
mysqlclient \
netaddr \
nose \
pbkdf2 \
pip2 install \
python-dateutil \
python-memcached \
python-resize-image \
sqlalchemy \
tornado \
--upgrade

# # Set up MySQL for RootTheBox
echo "[*] Setting Up MySQL"
sudo mysql -u root <<EOF
use mysql;
create user 'rtb'@'localhost' identified by 'rtb';
create database rootthebox;
grant all on rootthebox.* to 'rtb'@'localhost';
EOF

# # Generate Default Config for RootTheBox
echo "[*] Generating Default Configs"
./rootthebox.py --save

# Bootstrap production instance
# Automagically give it admin user and password
echo "[*] BootStrapping Prod"
expect - <<EOF
spawn ./rootthebox.py --setup=prod
expect "Username: "
send "armenr\\r"
expect "New Admin: "
send -- "parevbleegner123\\r"
expect "Confirm New Admin: "
send -- "parevbleegner123\\r"
expect "Production boot strap completed successfully."
EOF

# Start the bitch
echo "[*] Starting The Motherfucker"
touch /home/vagrant/rootBox.log
./rootthebox.py --start > /home/vagrant/rootBox.log 2>&1 &
