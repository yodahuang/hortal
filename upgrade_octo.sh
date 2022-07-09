#!/usr/bin/env bash

set -e

# Debian normal upgrades
sudo apt update
sudo apt upgrade -y

# Docker compose stuff

docker context use rootless

stacks=(home-assistant octoprint)

for stack in "${stacks[@]}"; do
    pushd "$stack"
    docker compose pull
    docker compose up -d
    popd
done

stacks=(portainer-agent)
for stack in "${stacks[@]}"; do
    pushd "$stack"
    docker compose -f docker-compose-rootless.yml pull
    docker compose -f docker-compose-rootless.yml up -d
    popd
done
