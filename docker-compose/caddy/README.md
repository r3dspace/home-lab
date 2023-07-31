# xCaddy with Cloudfalre plugin

### 💡 About Caddy

Caddy simplifies your infrastructure. It takes care of TLS certificate renewals, OCSP stapling, static file serving, reverse proxying, Kubernetes ingress, and more.
Its modular architecture means you can do more with a single, static binary that compiles for any platform.
Caddy runs great in containers because it has no dependencies—not even libc. Run Caddy practically anywhere.


---

### ⚙️ Manual setup

Create `caddy` directory & copy `Caddyfile` to that directory:

```bash
sudo mkdir /etc/caddy
sudo cp ./data/Caddyfile /etc/caddy/
```

Set `Caddyfile` permissions:

```bash
sudo chmod -R 770 /etc/caddy
```

Run the docker compose file.


### ⚙️ Script setup

*Note: Only run script when using defaukt `docker-compose.yml` file*

Make the scrip executable & run it:

```bash
sudo chmod +x caddy-dependensies.sh
sudo ./caddy-dependensies.sh
```

Run the docker compose file.


---

### ⚠️ Warning

Please beware that products can change over time. I do my best to keep up with the latest changes and releases, but please understand that this won’t always be the case.


---

### 🤝 Contribution and Support

If you’d like to contribute to this project, reach out to me on social media or [Discord](https://dc.spicydragon.net), or create a pull request for the necessary changes. 