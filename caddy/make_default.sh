#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo ln -s "$SCRIPT_DIR/Caddyfile" /etc/caddy/Caddyfile