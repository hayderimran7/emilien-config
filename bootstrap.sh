#!/bin/bash
#
# Bootstrap script (Inspired by Chmouel)
#
# Use : sudo apt-get -y install curl  && curl -L https://github.com/EmilienM/emilien-config/raw/master/bootstrap.sh | sh
#

export DEBIAN_FRONTEND=noninteractive
set -e

sudo apt-get -y install locales vim screen git-core zsh-beta
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales

sudo sed -i '/^%sudo/ { s/ALL$/NOPASSWD:ALL/ }' /etc/sudoers

sudo update-alternatives --set editor /usr/bin/vim.basic


sudo apt-get -y install ufw && \
    sudo ufw allow proto tcp from any to any port 22 && \
    sudo ufw -f enable

cd $HOME
mkdir -p git
cd git

sudo chsh -s /bin/zsh $USER
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git clone https://github.com/sontek/dotfiles/; cd dotfiles; ./install.sh;
cd ..

git clone https://github.com/EmilienM/emilien-config

for f in gitconfig screenrc vimrc zshrc;do
    rm -f ~/.${f}
    ln -fs emilien-config/rc-config/${f} ~/.${f}
done


for f in screenrc vimrc zshrc;do
   source ~/.${f}
done