# Install Debian Unstable
sudo cp sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y full-upgrade
sudo apt-get -y dist-upgrade

echo "Reboot To Finish.."
