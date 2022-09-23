# xCaddy with Cloudfalre plugin

## About Caddy
Caddy simplifies your infrastructure. It takes care of TLS certificate renewals, OCSP stapling, static file serving, reverse proxying, Kubernetes ingress, and more.
Its modular architecture means you can do more with a single, static binary that compiles for any platform.
Caddy runs great in containers because it has no dependencies—not even libc. Run Caddy practically anywhere.

## Setup / use
1. Clone the repo
2. Navigate into this directory
3. Make the scrip executable `chmod +x caddy-dependensies.sh`
4. Run the script `caddy-dependensies.sh`, only when keeping the default values in the `docker-compose.yml` file
5. Change the default values of the `/etc/caddy/Caddyfile` to your needed values
6. Start the container `docker compose up -d`