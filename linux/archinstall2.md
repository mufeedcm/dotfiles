# Duel booting Windows with arch linux

## 1. initial setup
1. install windows, 
2. Download arch iso from https://archlinux.org/download
3. create unallocated parition with **diskmgmnt** on windows and shrink the volume,
4. check whether the layout is **uefi/gpt** or **bios/mbt**.
5. flash the arch iso to the usb drive with **rufus**.
6. create a **windows system restore point**
7. reboot and go to bios (usually f2) and remove **secure boot** and boot into the usb


## 2. font setup.
to increase the font size : `setfont ter-132n`

## 3. connecting to wifi.

```bash
iwctl  
device list # it will show wlan0.
station wlan0 get-networks #it will show the available networks.
station wlan0 connect <wifi-name> # wifi name is the name of the network you want to connect.
#Enter the passoword.
ping google.com #check if the wifi is working.
```

## 4. synchronizes packages and install archlinux-keyring.
```bash
pacman -Sy
pacman -Sy archlinux-keyring  #package containing gpg keys used to verify the integritty and authenticity of packages.
```

## 5. partition setup.

