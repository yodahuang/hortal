# Hortal

Docker-compose and shell script based self hosted system. Ansible / chef is probaly overkill here.

## What's included

A homepage (homer) that containing LAN specific domain names. These domain names are resolved by local DNS server (dnsmasq + Adguard Home) and then handled by a reverse proxy (Caddy), who dispatch the requests to their corresponding ip + ports.