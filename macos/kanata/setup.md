download the latest karabiner-driverkit-virtualhiddevie from https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/tree/main/dist

download the raw file and open and run the *.pkg file, 

go to general -> login items & extensions -> driver extensions

and give permissions, 

install kanata 

```bash
brew install kanata
```

go to `/Library/LaunchDaemons/` and create

```bash
com.example.kanata.plist
com.example.karabiner-vhiddaemon.plist
com.example.karabiner-vhidmanager.plist
```

```bash
#/Library/LaunchDaemons/com.example.kanata.plist

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.kanata</string>

    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/kanata</string>
        <string>-c</string>
        <string>/Users/mufeedcm/.config/kanata/config.kbd</string>
        <string>--port</string>
        <string>10000</string>
        <string>--debug</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/Library/Logs/Kanata/kanata.out.log</string>

    <key>StandardErrorPath</key>
    <string>/Library/Logs/Kanata/kanata.err.log</string>
</dict>
</plist>
```

```bash
#/Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.karabiner-vhiddaemon</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>

```

```bash
#/Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.karabiner-vhidmanager</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager</string>
        <string>activate</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>


```

then run
```bash

sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl enable system/com.example.kanata

sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist
sudo launchctl enable system/com.example.karabiner-vhiddaemon

sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
sudo launchctl enable system/com.example.karabiner-vhidmanager

sudo launchctl start com.example.kanata
sudo launchctl start com.example.karabiner-vhiddaemon
sudo launchctl start com.example.karabiner-vhidmanager

```
go to settings->keyboard->keyboard navigation ->keyboard shortcuts-> modifier keys

and select Karabiner DrivrKit VirtualHIDKeyboard x.x.x from dropdown


### add kanata to input monitoring and accesibility

go to  System Settings > Privacy & Security > Input Monitoring
click the + icon and press cmd+shift+G and enter /opt/homebrew/bin/

and from there select kanata, 

do the same for accesibility by going to 
System Settings > Privacy & Security > Accesibility






