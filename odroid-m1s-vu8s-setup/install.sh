#!/bin/bash
echo "🚀 Iniciando configuración de ODROID M1S + VU8S..."
sudo apt-get update --allow-releaseinfo-change
sudo apt-get upgrade -y
sudo mount -o remount,rw /boot
sudo bash -c 'cat > /boot/config.ini << EOT
[generic]
overlay_resize=16384
overlay_profile=
overlays="i2c0 i2c1 display_vu8s"
[overlay_custom]
overlays="i2c0 i2c1"
EOT'
sudo apt-get install -y lightdm lightdm-gtk-greeter-settings
sudo groupadd -r autologin || true
sudo gpasswd -a odroid autologin
sudo bash -c 'cat > /etc/lightdm/lightdm.conf << EOT
[Seat:*]
autologin-user=odroid
autologin-user-timeout=0
user-session=ubuntu
EOT'
sudo mkdir -p /etc/X11/xorg.conf.d
sudo bash -c 'cat > /etc/X11/xorg.conf.d/99-vu8s.conf << EOT
Section "Device"
    Identifier "Rockchip DRM"
    Driver "modesetting"
    Option "AccelMethod" "none"
    Option "PageFlip" "false"
    Option "ShadowFB" "true"
EndSection
Section "Monitor"
    Identifier "VU8S"
    Option "PreferredMode" "800x480"
EndSection
Section "Screen"
    Identifier "Screen0"
    Device "Rockchip DRM"
    Monitor "VU8S"
    DefaultDepth 24
    SubSection "Display"
        Modes "800x480"
    EndSubSection
EndSection
EOT'
sudo apt-get install -y onboard dconf-cli gnome-shell-extension-onboard
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
dconf write /org/onboard/auto-show/enabled true
gsettings set org.gnome.desktop.interface enable-animations false
sudo apt-get install -y cpufrequtils
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl restart cpufrequtils
echo "✅ Instalación completada. Reiniciando..."
sleep 5
sudo reboot
