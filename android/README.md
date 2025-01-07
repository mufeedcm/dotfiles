## Installation Guide

### Step 1: Install F-Droid
Download and install F-Droid from the official site:  
[https://f-droid.org/](https://f-droid.org/)

### Step 2: Install Required Apps from F-Droid
Install the following apps:  
- [Termux](https://f-droid.org/en/packages/com.termux/)  
- [Termux:API](https://f-droid.org/en/packages/com.termux.api/)  
- [Termux:Styling](https://f-droid.org/en/packages/com.termux.styling/)

### Step 3: Customize Termux Appearance
Long-press on the Termux terminal, then change the style and font using Termux:Styling.
   - **Theme**: Set to "Gruvbox."
   - **Font**: Choose any font you prefer, exept the default.

### Step 4: Run the Setup Script
Run the following commands in Termux:

```bash
pkg update -y && pkg upgrade -y --allow-downgrades --option Dpkg::Options::="--force-confold"
pkg i git stow -y
cd ~
git clone https://github.com/mufeedcm/dotfiles
cd ~/dotfiles/android/
chmod +x install.sh
./install.sh
```

