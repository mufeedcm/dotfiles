#!/usr/bin/bash

SETUP_DIR=~/dotfiles/setup

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install APT packages
if [ -f $SETUP_DIR/apt-packages.txt ]; then
    echo "Installing apt packages..."
    xargs -a $SETUP_DIR/apt-packages.txt sudo apt install -y
else
    echo "No apt-packages.txt found!"
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
if [ -f $SETUP_DIR/brew-packages.txt ]; then
    echo "Installing Homebrew packages..."
    xargs brew install < $SETUP_DIR/brew-packages.txt
else
    echo "No brew-packages.txt found!"
fi

echo "Setup complete!"

