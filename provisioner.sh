#!/bin/bash

# Prep system
sudo apt-get update
sudo apt-get upgrade -y

# Install Pre-Requisites
sudo apt-get install python2.7 python-pip expect -y

# Clone Rootthebox
git clone git://github.com/moloch--/RootTheBox.git
cd RootTheBox

# Set up Dependencies for RootTheBox
sudo yes | sudo ./setup/depends.sh

# Set up MySQL for RootTheBox
sudo mysql -u root <<EOF
use mysql;
create user 'rtb'@'localhost' identified by 'rtb';
create database rootthebox;
grant all on rootthebox.* to 'rtb'@'localhost';
EOF

# Generate Default Config for RootTheBox
./rootthebox.py --save

# Bootstrap production instance
# Automagically give it admin user and password
expect - <<EOF
spawn python2 rootthebox.py --setup=prod
expect "RootTheBox Admin Username:"
send "armenr\n"
expect "New Admin Password:"
send "fuckmeintheass123!!123!!\n"
expect "Confirm New Admin Password:"
send "fuckmeintheass123!!123!!\n"
EOF

# Start the bitch
touch /home/vagrant/rootBox.log
./rootthebox.py --start > /home/vagrant/rootBox.log 2>&1 &
