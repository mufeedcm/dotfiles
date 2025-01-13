#!/usr/bin/bash

# Define the setup directory dynamically based on the script's location
SETUP_DIR=$(dirname "$(realpath "$0")")

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install APT packages
if [ -f "$SETUP_DIR/apt-packages.txt" ]; then
    echo "Installing apt packages..."
    xargs -a "$SETUP_DIR/apt-packages.txt" sudo apt install -y
else
    echo "No apt-packages.txt found!"
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
if [ -f "$SETUP_DIR/brew-packages.txt" ]; then
    echo "Installing Homebrew packages..."
    xargs brew install < "$SETUP_DIR/brew-packages.txt"
else
    echo "No brew-packages.txt found!"
fi

# Install Flatpak packages
if [ -f "$SETUP_DIR/flatpak-packages.txt" ]; then
    echo "Installing Flatpak packages..."
    while read -r package; do
        flatpak install -y "$package"
    done < "$SETUP_DIR/flatpak-packages.txt"
else
    echo "No flatpak-packages.txt found!"
fi

mkdir ~/.zsh/
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/plugins/.zsh-vi-mode
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting





echo "Setup complete!"
