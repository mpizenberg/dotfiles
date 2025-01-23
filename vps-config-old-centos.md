# VPS setup on CentOS 8

## Create a new admin user

```sh
ssh root@server_address
adduser matthieu
passwd matthieu
usermod -aG wheel matthieu
exit
```

## Add ssh key to VPS

```sh
ssh-copy-id matthieu@server_address
```

## Remove root and password ssh

```sh
ssh matthieu@server_address
sudo vi /etc/ssh/sshd_config
 -> PermitRootLogin no
 -> PasswordAuthentication no
sudo systemctl restart sshd
exit
```

## Enable cockpit monitoring

```sh
ssh matthieu@server_address
systemctl sudo enable --now cockpit.socket
exit
```

The Web interface is now available at
http://server_address:9090

## Automatic security updates

CF https://www.tecmint.com/dnf-automatic-install-security-updates-automatically-in-centos-8/

```sh
ssh matthieu@server_address
sudo dnf -y install dnf-automatic
sudo vi /etc/dnf/automatic.conf
 -> upgrade_type = security
 -> download_updates = yes
 -> upply_updates = yes
sudo systemctl enable --now dnf-automatic.timer

sudo dnf -y install firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --list-all
sudo firewall-cmd --reload

# Nginx
# https://serverfault.com/questions/819423/reverse-proxy-nginx-bad-gateway
sudo setsebool -P httpd_can_network_connect true

# coturn (STUN/TURN server)
sudo firewall-cmd --permanent --add-port=3478/udp
sudo firewall-cmd --permanent --add-port=3478/tcp
sudo firewall-cmd --permanent --add-port=5349/udp
sudo firewall-cmd --permanent --add-port=5349/tcp
sudo firewall-cmd --reload

exit
```

## Config packages

```sh
ssh matthieu@server_address
sudo dnf -y install epel-release
sudo dnf -y upgrade
sudo dnf -y group install "Development Tools"
sudo dnf -y install htop tmux vim neovim stow git nginx cmake
```

## Install dotfiles

CF https://github.com/mpizenberg/dotfiles

## Install nvm

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install --lts
```
