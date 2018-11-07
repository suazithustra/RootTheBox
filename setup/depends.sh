current_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$EUID" != "0" ]]; then
  echo "[!] This script must be run as root." 1>&2
  exit 1
fi

echo -e "\t#########################"
echo -e "\t   Linux Configuration"
echo -e "\t#########################"

echo "[*] Installing pip/gcc..."
apt-get install -y python-pip python-dev build-essential

echo "[*] Installing packages..."
apt-get -y install mysql-server memcached libmemcached-dev python-mysqldb python-mysqldb-dbg python-pycurl python-recaptcha zlib1g-dev libmysqlclient-dev "$SKIP"

echo "[*] Installing python libs..."

#sh "$current_path/python-depends.sh"
python_version="$(python -c 'import platform; major, minor, patch = platform.python_version_tuple(); print(major);')"
if [[ "$python_version" == "2" ]]; then
    sh "$current_path/python2-depends.sh"
else
    sh "$current_path/python3-depends.sh"
fi

echo ""
echo "[*] Setup Completed."
