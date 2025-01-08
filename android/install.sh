#!/bin/bash
set -e

echo "Setting up configurations with stow..."

stow -t $HOME zsh
stow -t $HOME nvim
stow -t $HOME starship
stow -t $HOME tmux

cd ~

echo "Installing Zsh..."
pkg i -y zsh

echo "Changing default shell to Zsh..."
chsh -s zsh

echo "Installing essential packages..."
pkg i -y starship git gh vim neovim nodejs-lts ripgrep tmux

echo "Configuring Git..."
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email


echo "Would you like to configure GitHub CLI (gh)? [y/N]"
read -r configure_gh

if [[ "$configure_gh" =~ ^[Yy]$ ]]; then
    echo "Logging into GitHub CLI..."
    gh auth login
    echo "GitHub CLI configured."
else
    echo "Skipping GitHub CLI configuration."
fi

git config --global user.name "$git_username"
git config --global user.email "$git_email"
echo "Git configured with username '$git_username' and email '$git_email'."

echo "Installing Termux API..."
pkg i -y termux-api

echo "Installing additional programming tools..."
pkg i -y clang lua-language-server gopls
pkg i -y python python-pip
pkg i -y build-essential curl wget fzf neofetch

npm install -g @astrojs/language-server --yes
npm install -g @tailwindcss/language-server --yes

cd ~ 

echo "Configuring zsh auto suggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

cd ~

echo "Setup complete! Please restart Termux"

zsh
