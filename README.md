# Hortal

Docker-compose and shell script based self hosted system. Ansible / chef is probaly overkill here.

## What's included

A homepage (homer) that containing LAN specific domain names. These domain names are resolved by local DNS server (dnsmasq + Adguard Home) and then handled by a reverse proxy (Caddy), who dispatch the requests to their corresponding ip + ports.

A resource grabbing system (see radarr and friends), for eh, grabbing resources.

And many more and keep adding.

## What's special about this config

My setup is repeatable, all containerized, and no hacks.

## Rootless Docker vs normal Docker

Rootless docker has the daemon also in user space, which is pretty sweet, but now it's impossible to use host network type. This is a deal breaker for HomeBridge (as it dynamically assigns port) and AdGuard Home (as it needs access to the actual client IP). Thus, on the Pi setup we have both normal Docker and rootless Docker. It can be switched via `docker context use default/rootless`.