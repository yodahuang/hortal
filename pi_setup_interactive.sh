#!/usr/bin/env bash

# Adguard Home
# TODO: Use the docker version instead of this one that installs into /opt/AdGuardHome/
# Dangerously piping shell script to shell. I have to confess I have not proofread the script.
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v

# Caddy
# https://caddyserver.com/docs/install#debian-ubuntu-raspbian
# Installing as a package instead of a Docker image makes testing much easier (as we get the cli),
# and it comes with a systemd service.
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo tee /etc/apt/trusted.gpg.d/caddy-stable.asc
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

# Docker
# Again, dangerous pipe.
curl -fsSL https://get.docker.com | sudo sh -s
# Rootless Docker
# https://docs.docker.com/engine/security/rootless/
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF
# The following workaround suppose you are using a OS based on Debian 10 (Buster)
# https://github.com/moby/moby/issues/42048
wget https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.12/slirp4netns-armv7l
mv slirp4netns-armv7l ~/bin/slirp4netns && chmod +x ~/bin/slirp4netns
dockerd-rootless-setuptool.sh install
# Follow what's shown on screen to add that to ~/.bashrc
# Enable docker daoemon on startup
systemctl --user enable docker
sudo loginctl enable-linger "$(whoami)"

# Docker Compose
# The architecture is not supported by official binary. So use the pip version.
sudo apt install -y python3-pip libffi-dev
sudo pip3 install docker-compose

# TailScale
curl -fsSL https://tailscale.com/install.sh | sh

# https://docs.linuxserver.io/faq#libseccomp
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list
sudo apt update
sudo apt install -t buster-backports libseccomp2