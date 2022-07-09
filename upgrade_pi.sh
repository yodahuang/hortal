#!/usr/bin/env bash

set -e

# Debian normal upgrades
sudo apt update
sudo apt upgrade -y

# Docker compose stuff

docker context use rootless

stacks=(homer networks portainer)

for stack in "${stacks[@]}"; do
    pushd "$stack"
    docker compose pull
    docker compose up -d
    popd
done

docker context use default

stacks=(homebridge portainer-agent)
for stack in "${stacks[@]}"; do
    pushd "$stack"
    docker compose pull
    docker compose up -d
    popd
done

stacks=(networks)
for stack in "${stacks[@]}"; do
    pushd "$stack"
    docker compose -f non-rootless-docker-compose.yml pull
    docker compose -f non-rootless-docker-compose.yml up -d
    popd
done

docker context use rootless