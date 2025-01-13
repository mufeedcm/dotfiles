#!/bin/bash
set -e

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sleep 1

stow -t $HOME zsh
stow -t $HOME suckless 
stow -t $HOME backgrounds
stow -t $HOME starship
stow -t $HOME dunst
stow -t $HOME feh 
stow -t $HOME flameshot
stow -t $HOME mpv
stow -t $HOME nvim
stow -t $HOME picom
stow -t $HOME tmux
stow -t $HOME zathura
# stow -t $HOME i3
# stow -t $HOME kitty
# stow -t $HOME polybar
# stow -t $HOME rofi
#

cd ~

sudo apt install zsh -y

sleep 2

chsh -s zsh

brew install starship gh -y
sudo apt install tmux vim lf -y
sudo apt install dunst feh flameshot fzf htop imagemagick mpv picom latexmk texlive texlive-latex-extra ripgrep zathura brave-browser -y
sudo apt install xcape xclip -y
# sudo apt install i3 polybar rofi -y
sudo apt install cowsay figlet neofetch tree lxappearance bucklespring -y
sudo apt instal curl wget -y

cd ~

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22

cd ~

read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

gh auth login

git config --global user.name "$git_username"
git config --global user.email "$git_email"

cd ~ 


mkdir ~/.zsh/
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/plugins/.zsh-vi-mode
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting

cd ~

suso su -
sudo apt install vim -y 
exit

cd ~

zsh


