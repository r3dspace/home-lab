# **Wireguard**
WireGuard is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache. It intends to be considerably more performant than OpenVPN. WireGuard is designed as a general purpose VPN for running on embedded interfaces and super computers alike, fit for many different circumstances.

## 📚 **Guide**
A guide to the installation and setup can be found [here](https://docs.r3dspace.xyz/posts/pi-hole/) !

## 🧾 **Setup using script**
Setup a WG (Wireguard) Docker container using a script.</br>
This script will create and place the WG dir. into /opt/docker,
as well as create the docker network for you.


**---**

Clone the repo and navigate into the WG dir:
```bash
git clone https://github.com/r3dspace/home-lab.git
cd ./home-lab/docker-compose/wireguard
```

Make the script executable and run it:
```bash
sudo chmod +x wireguard-dependensies.sh
sudo sh wireguard-dependensies.sh
```

Start the container:
```bash
sudo docker compose up -d
```

**---**
