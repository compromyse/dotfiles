#!/bin/bash

CURRENT_DIR=$(pwd)
TEMP_DIR=$CURRENT_DIR/temp
rm -rf $TEMP_DIR
mkdir $TEMP_DIR

# Warning To Install Debian Unstable
echo "Please run \"move_to_unstable.sh\" before this."
read -p "Press enter to continue..."

# Add `bash_aliases`
cp .bash_aliases $HOME

# Install Dependancies
sudo apt-get -y install git curl wget build-essential unzip
sudo apt-get -y install libxft-dev libx11-dev libxinerama-dev libpam0g-dev libxcb1-dev xorg libpam0g-dev
sudo apt-get -y install fonts-droid-fallback fonts-font-awesome j4-dmenu-desktop mate-polkit feh picom dunst network-manager-gnome volumeicon-alsa blueman xss-lock
sudo apt-get -y install lxappearance materia-gtk-theme papirus-icon-theme breeze-cursor-theme

# Change `/opt` Permissions
sudo chown $USER:$USER -R /opt

# Go To `/opt` And Clone Repositories
cd /opt
git clone https://github.com/compromyse/dwm

# Install `DWM`
cd /opt/dwm
make
sudo make install
make clean

# Install `ly`
cd /opt
git clone --recurse-submodules https://github.com/fairyglade/ly
cd /opt/ly
make
sudo make install
sudo make installsystemd
sudo systemctl enable ly.service

# Install `xsecurelock`
cd /opt
git clone https://github.com/google/xsecurelock
cd xsecurelock
sh autogen.sh
echo "Enter a PAM service name (in /etc/pam.d): "
read choice
./configure --with-pam-service-name=$choice
make
sudo make install
make clean

# Add `DWM.desktop`
sudo mkdir /usr/share/xsessions
cd $CURRENT_DIR
sudo cp DWM.desktop /usr/share/xsessions

# Install `WMName`
cd /opt
git clone https://git.suckless.org/wmname
cd /opt/wmname
make
sudo make install
make clean

# Add Dotfiles
cd $CURRENT_DIR/.config
cp -r * $HOME/.config
cd $CURRENT_DIR
cp -r .dwm $HOME

# Install `NeoVim`
cd $TEMP_DIR
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt-get -y install ./nvim-linux64.deb

# Install `packer.nvim`
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install Font
mkdir $HOME/.fonts
cd $TEMP_DIR
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip
unzip UbuntuMono.zip
mv *.ttf $HOME/.fonts
cd $CURRENT_DIR

# Install Programs
sudo apt-get install -y terminator nemo

# Make `bash` Case Insensitive
echo 'set completion-ignore-case On' | sudo tee -a /etc/inputrc

# Make systemd ignore power key
echo "HandlePowerKey=ignore" | sudo tee -a /etc/systemd/logind.conf

# Remove The Temporary Directory
rm -rf $TEMP_DIR
