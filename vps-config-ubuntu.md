# VPS Setup

Target OS: **Ubuntu 26.04 LTS**. The steps below apply to any recent Ubuntu LTS.

> Order matters. Don't lock down SSH until you've confirmed key login works in a _second_
> terminal, and don't install anything on ports 80 / 443 / 3000 if you plan to run Dokploy.
>
> **On `sudo`:** these commands are written assuming a root shell (common during initial
> provisioning). Once you've created your non-root user and disabled root login (steps 2–3),
> you should be logged in as that user and prefixing privileged commands with `sudo` — that's
> the correct, safer habit. For a long privileged sequence (like the Docker + Dokploy installs),
> `sudo -i` to get a root shell, do the work, then `exit`.

## 1. Update the system

```sh
apt update && apt upgrade -y
```

## 2. Create a non-root sudo user

```sh
adduser username
usermod -aG sudo username
```

## 3. SSH key authentication

```sh
# on your LOCAL machine — prefer an ed25519 key (shorter, faster, strong)
ssh-keygen -t ed25519 -C "label"          # if you don't have one yet
ssh-copy-id -i ~/.ssh/id_ed25519.pub username@server_ip
```

> Point `-i` at the `.pub` file specifically. Without `-i`, `ssh-copy-id` copies _every_
> public key in your agent and `~/.ssh/*.pub` (e.g. an old rsa key lands on the server too).

Then on the server edit `/etc/ssh/sshd_config`:

```sh
vim /etc/ssh/sshd_config
```

```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```

Restart the daemon — but **first open a new terminal and confirm `ssh username@server_ip`
works** while your current session is still alive, so you can't lock yourself out:

```sh
systemctl restart ssh
```

## 4. Basics: timezone, NTP, swap

Often skipped, occasionally painful later.

```sh
# timezone + clock sync
timedatectl set-timezone Europe/Paris   # adjust as needed
timedatectl set-ntp true

# swap — Docker builds can OOM a small VPS; skip only if you have plenty of RAM
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab
```

## 5. Automatic security updates

```sh
apt install unattended-upgrades         # note the spelling
dpkg-reconfigure unattended-upgrades
vim /etc/apt/apt.conf.d/50unattended-upgrades   # keep only the -security origin
```

Optional — let it reboot for kernel updates during a quiet window:

```
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "04:00";
```

## 6. fail2ban

Promoted from "another time" — it's quick and complements UFW's rate limiting.

```sh
apt install fail2ban
```

Create `/etc/fail2ban/jail.local`:

```ini
[sshd]
enabled = true
maxretry = 5
bantime = 1h
```

```sh
systemctl enable --now fail2ban
fail2ban-client status sshd
```

## 7. Firewall (UFW)

```sh
apt install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp     # SSH
ufw limit 22/tcp     # rate-limit SSH (max ~6 connections / 30s)
ufw allow 80/tcp     # HTTP
ufw allow 443/tcp    # HTTPS
ufw enable
ufw status verbose   # confirm SSH still works before logging out
```

> **Do NOT add `ufw allow 3000`.** See the Dokploy section — the dashboard should not be
> exposed to the internet, and UFW can't fully control it anyway.

---

## Docker (install this yourself, before Dokploy)

**Install Docker manually before running the Dokploy installer.** Dokploy's script _can_
install Docker for you, but letting it do so tends to cause problems — install Docker first
so it's already present and correctly configured when the Dokploy installer runs (it detects
an existing Docker and skips that part).

Approach:

- Follow the official guide, which stays current:
  **https://docs.docker.com/engine/install/ubuntu/** — use the "install using the apt
  repository" method.
- Do **not** use Ubuntu's `docker.io` package — it's outdated. Install from Docker's own apt
  repository so you get patches and current versions.
- Install the full set: engine, CLI, containerd, plus the buildx and compose plugins.
- Verify with `sudo docker run --rm hello-world`.
- Add your user to the `docker` group so you can run `docker` without `sudo`
  (`sudo usermod -aG docker username`, then log out / back in). Note the `docker` group is
  effectively root-equivalent, so only add trusted users.

### Duplicate-repo warning when running `apt update`

If you see warnings like:

```
Warning: Target Packages (stable/binary-amd64/Packages) is configured multiple times in
/etc/apt/sources.list.d/docker.list:1 and /etc/apt/sources.list.d/docker.sources:1
```

…it means the Docker repo is defined **twice** — usually because an older one-line
`docker.list` exists alongside the newer `docker.sources` (e.g. you ran two different guides,
or the install steps twice). These are warnings, not errors. Fix them by keeping only one
definition (the modern `.sources` is preferred) and deleting the other:

```sh
sudo rm /etc/apt/sources.list.d/docker.list
sudo apt update
```

Keep exactly one Docker repo definition — don't delete both, or apt won't find Docker packages.

---

## Dokploy

Open-source self-hosted PaaS (an alternative to Vercel / Netlify / Heroku) that builds and
deploys git repos for you. It runs on **Docker Swarm** and bundles **Traefik**, which manages
ports 80 and 443 and handles Let's Encrypt SSL automatically — so don't put Nginx or anything
else on those ports.

**Requirements:** ≥ 2 GB RAM, ≥ 30 GB disk, and ports **80, 443, 3000** free (install fails
otherwise). Docker should already be installed from the section above.

### ⚠️ The UFW + Docker footgun (read this)

Docker (and Swarm) write their own `iptables` rules that **bypass UFW**. A published container
port becomes reachable from the internet even though `ufw status` shows nothing allowing it —
UFW reports it as blocked while it is in fact open. So the firewall section above does **not**
protect the Dokploy dashboard on port 3000 on its own.

Pick one of these to actually keep 3000 private:

1. **Recommended:** set up a domain + HTTPS for the dashboard (Dokploy → Domains), then remove
   the public 3000 publication entirely:
   ```sh
   docker service update --publish-rm "published=3000,target=3000,mode=host" dokploy
   ```
2. Reach the dashboard over an **SSH tunnel** instead of opening it:
   ```sh
   # from your local machine
   ssh -L 3000:localhost:3000 username@server_ip
   # then browse http://localhost:3000
   ```

### Install

The official one-liner (it will detect the Docker you installed above and skip installing it,
then set up Swarm + the Dokploy stack):

```sh
curl -sSL https://dokploy.com/install.sh | sh
```

Piping a script to a shell runs arbitrary code as root — if that bothers you, download and read
`install.sh` first, or use the Manual Installation guide. For pinning versions, updating,
setting the advertise address, and other options, see the official docs:
**https://docs.dokploy.com/docs/core/installation**

> If you're running as your sudo user rather than root, pipe to `sudo sh`. Note that env vars
> set in _your_ shell don't pass into the root-run script, so run the install in a root shell
> (`sudo -i`) if you need to set any.

### After install

1. Wait ~15s, then reach the dashboard at `http://your_server_ip:3000` (via the SSH tunnel
   from above is cleanest).
2. Create the admin account immediately — anyone who hits that page first owns your instance.
3. Configure a domain + Let's Encrypt for the dashboard, verify HTTPS works, then disable the
   `ip:port` access per option 1 above.
4. Deploy apps via Dokploy → Projects → Git repository.

### Notes

- Dokploy/Traefik own 80 + 443. Let Traefik terminate SSL; don't run a second reverse proxy.
- Backups, S3 destinations, and scheduled jobs are built in — worth configuring once you have
  something running.

---

## Dev tools

Rust toolchain plus a few CLI tools. Install these as your normal user (not root) — Rust goes
in `~/.cargo` / `~/.rustup` and shouldn't be installed system-wide via `sudo`.

### Rust + Cargo

Install via rustup (the official installer; check current instructions at
**https://rustup.rs**). It installs `rustc`, `cargo`, and `rustup`:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# then load cargo into the current shell (rustup adds this to your profile too)
. "$HOME/.cargo/env"
```

You may need a C linker/toolchain for building some crates:

```sh
sudo apt install -y build-essential
```

### cargo-binstall

Installs Rust binaries from prebuilt release artifacts instead of compiling from source — much
faster than `cargo install`. Official one-liner (see
**https://github.com/cargo-bins/cargo-binstall** for current instructions):

```sh
curl -L --proto '=https' --tlsv1.2 -sSf \
  https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
```

### zellij (terminal multiplexer) — via cargo-binstall

```sh
cargo binstall zellij
```

`binstall` falls back to building from source if no prebuilt binary matches your target, so it
always resolves one way or another.

### ripgrep (fast recursive search)

Also available through binstall:

```sh
cargo binstall ripgrep      # provides the `rg` command
```

(Alternatively `sudo apt install ripgrep`, though the apt version tends to lag upstream.)

### Helix (modal editor)

Helix doesn't distribute via crates.io in a way that's reliable for `binstall`. The old
`ppa:maveonair/helix-editor` PPA that older guides reference is now **deprecated** and often
lacks a release for recent Ubuntu versions — don't use it. Helix is now packaged in Ubuntu's
own repositories, so on 26.04 the simplest route is plain apt:

```sh
sudo apt install helix      # provides the `hx` command
```

If that package isn't available or is too old for your taste, the official AppImage from the
releases page is the maintained fallback. Always check current options at
**https://docs.helix-editor.com/install.html**.

After install, run `hx --health` to check language-server/grammar status. Language servers
(e.g. `rust-analyzer`, added with `rustup component add rust-analyzer`) are installed
separately per language.
