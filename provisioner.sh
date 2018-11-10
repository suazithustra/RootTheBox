#!/bin/bash
# BASH-MISHINUH SEEKEEM

export DEBIAN_FRONTEND=noninteractive

## Install Pre-Requisites
echo "[*] Checking pre-requisite packages..."

## ONLY TRIGGERS WHEN THE SYSTEM HAS ALREADY BEEN PROVISIONED BEFORE
if [ -f installed.yes ]; then
  echo "[*] System and Python shit already installed, homie!"
  
  if [[ $(pgrep python) ]]; then
    echo "[*] Killing previously running server process"
    pgrep python | xargs kill
  else
    echo "[*] No previously running server process found"
  fi

  echo "[*] Repo already exists. Pulling latest code..."
  cd il_ctf && git pull

  echo "[*] Dropping MySQL Data"
  sudo mysql -u root <<EOF
  use mysql;
  DROP USER IF EXISTS rtb@localhost;
  create user 'rtb'@'localhost' identified by 'rtb';
  DROP DATABASE IF EXISTS rootthebox;
  create database rootthebox;
  grant all on rootthebox.* to 'rtb'@'localhost';
EOF

  echo "[*] Previous config file already exists. Skipping..."
  echo "[*] Resetting application to default..."
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

  echo "[*] Starting The Motherfucker"
  touch /home/vagrant/rootBox.log
  ./rootthebox.py --start > /home/vagrant/rootBox.log 2>&1 &
  
  echo "[*] All done, fucko!!"

else
  ## ONLY TRIGGERS WHEN THE SYSTEM IS COMING ONLINE THE FIRST TIME!
  # # Prep system
  echo "[*] Updating APT"
  sudo apt-get -qq update &> /dev/null

  echo "[*] Upgrading System Packages"
  sudo apt-get -qq upgrade -y &> /dev/null

  echo "[*] Installing system-level packages..."
  sudo apt-get -qq install -y build-essential expect libmemcached-dev libmysqlclient-dev memcached mysql-server python-dev python-mysqldb python-mysqldb-dbg python-pip python-pycurl python-recaptcha zlib1g-dev &> /dev/null
  
  echo "[*] Installing Python packages..."
  pip2 install --quiet defusedxml future mysql-python mysqlclient netaddr nose pbkdf2 python-dateutil python-memcached python-resize-image sqlalchemy tornado --upgrade;

  echo "[*] Cloning repo..."
  git clone http://git0.loc/illuria/il_ctf/ && cd il_ctf

  echo "[*] Setting Up MySQL"
  sudo mysql -u root <<EOF
  use mysql;
  create user 'rtb'@'localhost' identified by 'rtb';
  create database rootthebox;
  grant all on rootthebox.* to 'rtb'@'localhost';
EOF

  echo "[*] Generating Default Configs"
  ./rootthebox.py --save
  echo "[*] Adding Admin IP"
  sed -i "s#'::1'#'10.0.2.2'#g" files/rootthebox.cfg

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

  echo "[*] Touching flagfile..."
  touch /home/vagrant/installed.yes

  echo "[*] All done, fucko!!"
fi
