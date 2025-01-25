# installing duel booted arch with windows
## sources
s1 - https://www.youtube.com/watch?v=NxqU1G8hKWk

create unallocated partition with `diskmgmnt`.
the windows will ussually have 100mb efi partition, and a c parition and a recovery partition,

we will be creating another efi partition for arch, so 
`shrink the volume of c drive`


go to https://archlinux.org/download
and download arch iso,

check weather the layout is `Uefi/gpt` or `bios/mbt`


connect the usb drive, 
then install `rufus`, and flash the iso to the usb stick, 

create a windows `system restore point`


reboot the pc and go to the bios with ussually it is `f2`,
then remove the `secure boot`
then boot into the usb,

to increase the font size : `setfont ter-132n`

#### to connect to wifi,

```
iwctl

device list

station wlan0 get-networks

station wlan0 connect <wifi-name>

```
check with `ping`



#### 
```
pacman -Sy

pacman -Sy archlinux-keyring
```

#### partition setup

```
lsblk

cfdisk /dev/sda
```
on the free space,

create a efi partition, with `Efi Partition` as Type, here it is sda5

create another root partition, with `Linux filesystem` as type (sda6)

create swap partition with, `Linux swap` as type.

write the changes and quit

```
lsblk

mkfs.fat -F32 /dev/sda5
mkfs.ext /dev/sda6
mkswap /dev/sda7

mount /dev/sda6 /mnt
mkdir /mnt/boot
mount /dev/sda5 /mnt/boot
swapon /dev/sda7

```

```
pacstrap -i /mnt base base-devel linux linux-firmware git sudo neofetch htop intel-ucode vim bluez bluez-utils network manager


genfstab -U /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab

```


```
arch-chroot /mnt

neofetch
htop

passwd

useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash <user-name>

passwd <user-name>

Editor=vim visudo

```
and on the bottom uncomment the line 
`%wheel ALL=(ALL:ALL) NOPASSWD: ALL`
``` 
su - <user-name>
sudo pacman -Syu
exit
```

```
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

hwclock --systohc

vim /etc/locale.gen

```
go to the bottom and uncomment

`en_US.UTF-8 UTF-8`


```
locale-gen

vim /etc/locale.conf
(add)
LANG=en_US.UTF-8
```

``` 
vim /etc/hostname
(add)
archlinux
```

```
vim /etc/hosts
(add)

127.0.0.1                   localhost
::1                         localhost
127.0.1.1                   archlinux.localdomain                archlinux
```

```
pacman -S grub efibootmgr dosfstools mtools

lsblk
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

```


```
systemctl enalble bluetooth
systemctl enalble NetworkManager
```

```
unmount -lR /mnt 
```

```
shutdown now
```

```
nmtui

# sudo pacman -S
```


```
install nvidia driver (i haven't done this yet)
lspci | grep -E "NVIDIA"
sudo pacman -Sy nvidia
nvidia-smi
```


adding windows to grub
```
sudo pacman -Sy os-prober
sudo vim /etc/default/grub
(uncomment)
GRUB_DISABLE_OS_PROBER=false

(then)
sudo grub-mkconfig -o /boot/grub/grub.cfg
(if it doen't find windows boot manager)

sudo mkdir /mnt/win11
sudo mount /dev/sda1 /mnt/win11
sudo grub-mkconfig -o /boot/grub/grub.cfg
(or (i haven't tried this yet))
(install `fuse3` i heard it is dependent on fuse3)
```


## for dwm
source: https://www.youtube.com/watch?v=jD8BtmMK0do

```
sudo pacman -Sy base-devel git 
sudo pacman -Sy xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk
```

```
sudo pacman -Sy stow
git clone https://github.com/mufeedcm/dotfiles

cd dotfiles

stow -t $HOME backgrounds dunst feh nvim picom starship suckless tmux zathura zsh x rofi


chsh -s $(which zsh)

then sudo make clean install dwm and st and dmenu and slock
```

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```


```
sudo pacman -Sy dunst zsh feh figlet firefox flameshot neovim picom tmux ttf-meslo-nerd xclip zathura
pacman -Ss xsetroot
```

`yay -S github-cli-git`



### audio setup 

```
sudo pacman -S pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol

systemctl --user enable pipewire.service
systemctl --user start pipewire.service
systemctl --user enable wireplumber.service
systemctl --user start wireplumber.service


(for blutooth)
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
```

```
(for notification)
sudo pacman -S libnotify

sudo pacman -S rofi
```

```
for status bar
sudo pacman -S xorg-xsetroot
```

```
sudo pacman -S xautolock
sudo pacman -S network-manager-applet
sudo pacman -S xorg-setxkbmap
sudo pacman -S xcape


```







