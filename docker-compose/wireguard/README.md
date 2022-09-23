# Wireguard
WireGuard is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache. It intends to be considerably more performant than OpenVPN. WireGuard is designed as a general purpose VPN for running on embedded interfaces and super computers alike, fit for many different circumstances.

## Setup (CLI)
Setup a WG (Wireguard) Docker container using CLI.

**---**

Clone the repo and navigate into the WG dir:
```bash
git clone https://github.com/r3dspace/home-lab.git
cd ./docker-compose/wireguard
```


Create a docker network for the WG server to bind to: </br>
*Note: If you are unable to use the network listed below please update the values in the docker-compose.yml file.*
```bash
sudo docker network create \
    --driver=bridge \
    --subnet=172.155.0.0/16 \
    --ip-range=172.155.5.0/24 \
    --gateway=172.155.5.254 \
    wireguard_network
```

Start the container:
```bash
sudo docker compose up -d
```

**---**

## Setup (Script)
Setup a WG (Wireguard) Docker container using a script.


**---**

Clone the repo and navigate into the WG dir:
```bash
git clone https://github.com/r3dspace/home-lab.git
cd ./docker-compose/wireguard
```

Make the script executable and run it:
```bash
sudo chmod +x wireguard-dependensies.sh
ssudo sh wireguard-dependensies.sh
```

Start the container:
```bash
sudo docker compose up -d
```

**---**

## Show QR-Code in CLI
The 'show-qr-in-cli.sh' script will print the QR-Code of the peer config.</br>
*Note: 'LOG_CONFS=true' must be set to use this feature!*

**---**

Make script executable and run it:
```bash
sudo chmod +x show-qr-in-cli.sh
sudo sh show-qr-in-cli.sh
```