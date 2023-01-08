#!/usr/bin/env bash

set -e

# Debian normal upgrades
sudo apt update
sudo apt upgrade -y

# Docker compose stuff

docker context use default

stacks=(home-assistant octoprint portainer-agent)

for stack in "${stacks[@]}"; do
    pushd "$stack"
    docker compose pull
    docker compose up -d
    popd
done

