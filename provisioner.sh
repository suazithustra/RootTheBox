#!/bin/bash

# Prep system
echo "[*] Prepping System"
sudo apt-get update
sudo apt-get upgrade -y

# Install Pre-Requisites
echo "[*] Installing Prerequisite Packages"
sudo apt-get install -y expect python-pip python-dev build-essential mysql-server memcached libmemcached-dev python-mysqldb python-mysqldb-dbg python-pycurl python-recaptcha zlib1g-dev libmysqlclient-dev

# Clone Rootthebox
echo "[*] Cloning Repo"
git clone git://github.com/armenr/RootTheBox.git
cd RootTheBox

# Set up Dependencies for RootTheBox
echo "[*] Installing Python Packages From Pip"
pip2 install tornado --upgrade
pip2 install pbkdf2 --upgrade
pip2 install mysql-python --upgrade
pip2 install mysqlclient --upgrade
pip2 install sqlalchemy --upgrade
pip2 install python-memcached --upgrade
pip2 install python-dateutil --upgrade
pip2 install defusedxml --upgrade
pip2 install netaddr --upgrade
pip2 install nose --upgrade
pip2 install future --upgrade
pip2 install python-resize-image --upgrade

# Set up MySQL for RootTheBox
echo "[*] Setting Up MySQL"
sudo mysql -u root <<EOF
use mysql;
create user 'rtb'@'localhost' identified by 'rtb';
create database rootthebox;
grant all on rootthebox.* to 'rtb'@'localhost';
EOF

# Generate Default Config for RootTheBox
echo "[*] Generating Default Configs"
./rootthebox.py --save

# Bootstrap production instance
# Automagically give it admin user and password
echo "[*] BootStrapping Prod"
# expect - <<EOF
# spawn python2 rootthebox.py --setup=prod
# expect "RootTheBox Admin Username:"
# send "armenr\r"
# expect "New Admin Password:"
# send "fuckmeintheass123123\r"
# expect "Confirm New Admin Password:"
# send "fuckmeintheass123123\r"
# EOF

echo "armenr mamankoonerem123 mamankoonerem123" | ./rootthebox.py --setup=prod

# Start the bitch
echo "[*] Starting The Motherfucker"
touch /home/vagrant/rootBox.log
./rootthebox.py --start > /home/vagrant/rootBox.log 2>&1 &
