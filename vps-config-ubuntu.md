# VPS Setup

This VPS is running on Ubuntu LTS (24.04 for now)

```sh
# update the system
apt update && apt upgrade -y

# create a new user and add to sudo group
adduser username
usermod -aG sudo username

# setup ssh key authentication
ssh-copy-id username@server_ip # on your local machine
vim /etc/ssh/sshd_config # on server and make the following changes:
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes

# restart the ssh daemon AND CHECK that you can connect
systemctl restart ssh

# setup automatic security updates
apt install unattended-upgrates
dpkg-reconfigure unattended-upgrades
vim /etc/apt/apt.conf.d/50unattended-upgrades # only keep security

# setup firewall
apt install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp  # SSH
ufw limit 22/tcp  # SSH 6 max connections per 30s
ufw allow 80/tcp  # HTTP
ufw allow 443/tcp # HTTPS
ufw enable
ufw status verbose # then check ssh still working

# fail2ban looks nice but let’s leave it for another time
```

## Nginx (reverse proxy)

To be able to serve multiple applications on multiple ports, I use nginx.

```sh
apt install nginx
vim /etc/nginx/sites-available/app1 # edit app1 config
ln -s /etc/nginx/sites-available/app1 /etc/nginx/sites-enabled/app1 # enable it
rm /etc/nginx/sites-enabled/default # remove default if not needed
nginx -t # test the config
systemctl restart nginx
```

Here is an example config.

```nginx
# /etc/nginx/sites-available/app1
server {
    listen 80;
    server_name app1.yourdomain.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

After having configured the DNS servers for your hosting service,
and checking that DNS works, we can now add certbot for HTTPS.

```sh
apt install certbot python3-certbot-nginx # install certbot
certbot --nginx # add certificates to your domains
systemctl status certbot.timer # to check the auto-renew service is enabled
certbot renew --dry-run # to check successful renew config
# then check that nginx config is still correct and restart it
nginx -t
systemctl restart nginx
```

## Docker / Podman

I prefer using Podman as it doesn’t require a daemon with root permissions.

```sh
apt install podman

# start app1 at port 8000 as config in nginx, and with inner port 8888
# the container automatically restarts if it crashes somehow
podman run --name app1 --restart always -p 8000:8888 ghcr.io/app1container:latest

# create a systemd service to be able to restart also on machine reboot
podman generate systemd -name app1 --restart-policy=always > ~/.config/systemd/user/app1
systemctl --user enable app1

# Ensure lingering is enabled for user services so it starts on boot,
# otherwise it will wait for the user ssh connection
loginctl enable-linger $(whoami)
```
