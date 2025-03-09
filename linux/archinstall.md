# Dual booting Windows with arch linux
> **Disclaimer:** this is a guide i have written for my own personal use after my initial arch installation.

## 1. Initial setup
1. install windows, 
2. Download arch iso from https://archlinux.org/download
3. create unallocated parition with **diskmgmnt** on windows and shrink the volume,
4. check whether the layout is **uefi/gpt** or **bios/mbr**.
5. flash the arch iso to the usb drive with **rufus**.
6. create a **windows system restore point**
7. reboot and go to bios (usually f2) and remove **secure boot** and boot into the usb


## 2. Font setup.
to increase the font size : `setfont ter-132n`

## 3. Connecting to wifi.

```bash
iwctl  
device list # it will show wlan0.
station wlan0 get-networks #it will show the available networks.
station wlan0 connect <wifi-name> # wifi name is the name of the network you want to connect.
#Enter the passoword.
ping google.com #check if the wifi is working.
```

## 4. Synchronizing packages and install archlinux-keyring.
```bash
pacman -Sy
pacman -Sy archlinux-keyring  #package containing gpg keys used to verify the integritty and authenticity of packages.
```

## 5. Partition setup.

```bash
lsblk #lists the storage devices
cfdisk /dev/sda #select the disk to install arch
```
1. On the free space create a efi partition with TYPE as **Efi Partition**.(for eg: sda5).
2. Create another root partition with TYPE as **Linux FileSytem**. (for eg: sda6).
3. Create swap partition with type **Linux Swap**. (for eg: sda7).

## 6. Formatting the Partitions.
```bash
lsblk #lists the storage devices and partitions

mkfs.fat -F32 /dev/sda5 #format efi partion (sda5) as fat32.
mkfs.ext4 /dev/sda6 #format root partition (sda6) as ext4
mkswap /dev/sda7 #initialize the swap partition (sda7)
```

## 7. Mounting the Paritions.

```bash
mount /dev/sda6 /mnt #mount the root partition to /mnt
mkdir /mnt/boot 
mount /dev/sda5 /mnt/boot #mounting efi partition to /mnt/boot
swapon /dev/sda7 #enable swap
```

## 8. Installing essential packages.

```bash
pacstrap -K /mnt base linux linux-firmware intel-ucode base-devel git sudo vim bluez bluez-utils networkmanager man ntfs-3g
```

## 9. Generating fstab

```bash
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab #see the fstab-file
```

## 10. Chroot into arch and setting up users.

```bash
arch-chroot /mnt #chroot
passwd #setup root password
useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash <user-name> #adding user
passwd <user-name> #setting up user password 

Editor=vim visudo #to allow the user to run sudo commands uncomment the line
# %wheel ALL=(ALL:ALL) NOPASSWD: ALL

#checking whether the usr is working
sudo - <user-name>
sudo pacman -Syu
exit #and exit
```

## 11. Configuring System time and language.

```bash
#setting up time-zone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime 
hwclock --systohc 

#setting up language
vim /etc/locale.gen #uncomment the line
# en_US.UTF-8 UTF-8

locale-gen #generate locale
vim /etc/locale.conf #then add the line 
# LANG=en_US.UTF-8
```

## 12. Setting up host.
```bash
vim /etc/hostname #and add the line 
# archlinux

vim /etc/hosts #and add the lines
127.0.0.1                   localhost
::1                         localhost
127.0.1.1                   archlinux.localdomain                archlinux
```

## 13. Setting up Bootloader

```bash
pacman -S grub efibootmgr dosfstools mtools
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #install grub to efi-partition
grub-mkconfig -o /boot/grub/grub.cfg #generate grub config file

#adding windows to grub
sudo pacman -Sy os-prober
sudo vim /etc/default/grub #and uncomment the line 
# GRUB_DISABLE_OS_PROBER=false

sudo grub-mkconfig -o /boot/grub/grub.cfg
#if this doens't work show windows boot manager

# 1st option,
sudo mkdir /mnt/win11
sudo mount /dev/sda1 /mnt/win11
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 2nd option,(i haven't tried this yet)
sudo pacman -S fuse3 #i heard os-prober is dependent on fuse3
```

## 14. Enable Network and Bluetooth.

```bash
systemctl enable bluetooth
systemctl enable NetworkManager
```

## 15. Un-mounting and rebooting.

```bash
unmount -lR /mnt
shutdown now
```

## 16. Connect to wifi and synchronize the packages

```bash
nmtui
sudo pacman -Syu
```
## 17. Setting Up nvidia drivers (Haven't tried this yet)

```bash
lspci | grep -E "NVIDIA"
sudo pacman -Sy nvidia
nvidia-smi
```

## 18. Dwm and essential package setup

```bash
#installing essential packages
sudo pacman -Sy xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk
sudo pacman -S xorg-xrandr

#installing beautification and monitoring
sudo pacman -Sy htop fastfetch figlet bucklespring tree

#installing stow for symlink and setting it up
sudo pacman -Sy stow
git clone https://github.com/mufeedcm/dotfiles
cd dotfiles
stow -t $HOME backgrounds dunst feh nvim picom starship suckless tmux zathura zsh x rofi
cd ~

#install zsh and configure it.
sudo pacman -Sy zsh
chsh -s $(which zsh)

cd ~/.config/suckless/dwm
sudo make clean install

cd ~/.config/suckless/st
sudo make clean install

cd ~/.config/suckless/dmenu
sudo make clean install

cd ~/.config/suckless/slock
sudo make clean install

cd ~

#installing essential packages
sudo pacman -S zsh feh figlet firefox flameshot neovim picom tmux ttf-meslo-nerd xclip zathura zathura-pdf-poppler rofi dunst libnotify xorg-xsetroot xautolock xorg-setxkbmap xcape network-manager-applet fuse2 noto-fonts-emoji unzip wget ripgrep lf imagemagick mpv numlockx xdotool

yay -S tty-clock


#latex-setup (optional) 
sudo pacman -S texlive-core texlive-latexextra texlive-binextra

#kmonadsetup
cd ~dotfiles/linux/
stow -t $HOME kmonad
cp ~/dotfiles/linux/kmonad/.config/kmonad/kmonad.service /etc/systemd/system/kmonad.service
sudo systemctl enable kmonad.service
sudo systemctl start kmonad.service

#pyton setup
sudo pacman -S python python-pip python-pipx
sudo pacman -S gobject-introspection python-gobject

#audio setup
sudo pacman -S pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol alsa-utils

systemctl --user enable pipewire.service
systemctl --user start pipewire.service
systemctl --user enable wireplumber.service
systemctl --user start wireplumber.service

#setting up aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

#installing gh
yay -S github-cli-git

#installing nvm and nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install --lts


#to setup up appimages (example)
ln -s ~/Applications/<app-name>.AppImage ~/.local/bin/<app-name>


# doom emacs setup 
sudo pacman -S emacs ripgrep fd
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
# should replace the doom config.
cd ~/dotfiles/linux/
stow -t $HOME doom

#syncthing setup 
sudo pacman -S syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

# scrcpy for phone connection
sudo pacman -S scrcpy
# connect via usb
adb tcpip 5555
adb shell ip route
adb connect <ip-address>:5555
# get the ip and connect via wifi
adb devices
scrcpy --turn-screen-off --stay-awake


# for audio player
sudo pacman -S mpd ncmpcpp mpc
cd ~/dotfiles/linux
stow -t $HOME mpd
systemctl --user enable --now mpd

#for pentablet setup 
yay -S opentabletdriver

sudo ln -s /usr/lib/opentabletdriver/OpenTabletDriver.Daemon /usr/bin/opentabletdriver-daemon
sudo ln -s /usr/lib/opentabletdriver/OpenTabletDriver.UX.Gtk /usr/bin/opentabletdriver

opentabletdriver-daemon &
opentabletdriver

systemctl --user enable opentabletdriver
systemctl --user start opentabletdriver


```
