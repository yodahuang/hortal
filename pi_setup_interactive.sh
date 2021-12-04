#!/usr/bin/env bash

# Note: the script is only tested on RaspberryPi OS based on bullseye.

# ======================================================== #
# ===================== Common Utils ===================== #
# ======================================================== #

sudo apt install vim fzf

echo -e "\n# Added for fzf" >> ~/.bashrc
echo 'source /usr/share/doc/fzf/examples/key-bindings.bash' >> ~/.bashrc
echo 'source /usr/share/doc/fzf/examples/completion.bash' >> ~/.bashrc

python3 -m pip install --user pipx
python3 -m pipx ensurepath
echo 'eval "$(register-python-argcomplete pipx)"' >> ~/.bashrc

# ======================================================== #
# ======================== Docker ======================== #
# ======================================================== #

# Dangerous pipe.
curl -fsSL https://get.docker.com | sudo sh -s
# Rootless Docker
# https://docs.docker.com/engine/security/rootless/
sudo apt install -y uidmap fuse-overlayfs slirp4netns
dockerd-rootless-setuptool.sh install
# Follow what's shown on screen to add that to ~/.bashrc
# Note: I recently find that in some cases we need host network.
# Thus, instead of setting env var, using `docker context use` is a better option.
echo -e "\n# Added for rootless docker" >> ~/.bashrc
echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' >> ~/.bashrc 
# Expose privileged ports.
sudo setcap cap_net_bind_service=ep /usr/bin/rootlesskit

# Enable docker daemon on startup
systemctl --user enable docker
sudo loginctl enable-linger "$(whoami)"

# Now it's compose time
sudo apt install -y libffi-dev
pipx install docker-compose

# ======================================================== #
# ========================== VPN ========================= #
# ======================================================== #

curl -fsSL https://tailscale.com/install.sh | sh

# ======================================================== #
# ======================== Secrets ======================= #
# ======================================================== #

pushd ~
mkdir Softwares && cd Softwares
git clone https://github.com/sobolevn/git-secret.git git-secret
cd git-secret && make build
PREFIX="/home/pi/.local" make install
popd

# ======================================================== #
# ========================== git ========================= #
# ======================================================== #

git config --global user.email "realyanda@hey.com"
git config --global user.name "Yanda Huang"