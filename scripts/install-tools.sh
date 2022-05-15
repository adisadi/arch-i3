#update keys
sudo pacman-key --init
sudo pacman-key --populate archlinux

#full upgrade
sudo pacman -Syu --noconfirm

#install vbguest
sudo pacman -R virtualbox-guest-utils-nox --noconfirm
sudo pacman -S virtualbox-guest-utils --noconfirm

#install packages
sudo pacman -S \
    xorg-xinit \
    ttf-dejavu \
    ttf-font-awesome \
    picom \
    lxdm \
    i3 \
    dmenu \
    firefox \
    ranger \
    feh \
    neofetch \
    kitty \
    git \
    nano \
    --noconfirm

#display manager & autologin
sudo sed -i 's|# session=/usr/bin/startlxde|session=/usr/bin/i3|g' /etc/lxdm/lxdm.conf
sudo sed -i 's|# autologin=dgod|autologin=vagrant|g' /etc/lxdm/lxdm.conf

#Locale
sudo localectl --no-convert set-keymap de_CH-latin1
sudo localectl --no-convert set-x11-keymap ch pc106
echo 'LANG=de_CH.UTF-8' | sudo tee /etc/locale.conf
echo 'KEYMAP=de_CH-latin1' | sudo tee /etc/vconsole.conf
sudo ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
sudo timedatectl set-local-rtc 0
sudo sed -i 's|#de_CH.UTF-8 UTF-8|de_CH.UTF-8 UTF-8|g' /etc/locale.gen
sudo sed -i 's|en_US.UTF-8 UTF-8|#en_US.UTF-8 UTF-8|g' /etc/locale.gen
sudo locale-gen

#Set default Terminal
echo 'TERMINAL=kitty' | sudo tee -a /etc/environment

#Set default Editor
echo 'EDITOR=nano' | sudo tee -a /etc/environment

#start display manager
sudo systemctl enable lxdm
sudo systemctl start lxdm

 #install aur helper pikaur
sudo pacman -S --needed base-devel git --noconfirm
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri --noconfirm
cd ..
rm -rf pikaur

#install vscode aur
pikaur -S visual-studio-code-bin --noconfirm

#install docker
#sudo pacman -S \
#    docker \
#    docker-compose \
#    --noconfirm

# systemctl enable docker.service
# systemctl start docker.service

#install dotnet-sdk
#sudo pacman -S dotnet-sdk

#add user to virtualbox group
sudo usermod -G vboxsf -a $USER

#install configs
echo "Coping config files to $HOME/.config/"
cp -R /vagrant/.config/* $HOME/.config/

#delete packages & cache
sudo pacman -Sc --noconfirm

sleep 1
echo "Finished.."
