# 🐳 Docker-Compose
The food for the whale is called Docker-Compose. Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## ⌨️ Install Docker & Docker-Compose
To install Docker & Docker-Compose over apt run the following commands or follow the installation guide on the Docker [website](https://docs.docker.com/).

Install via apt:
```bash
sudo apt update && sudo apt upgrade
sudo apt install -y \
    docker.io \
    docker-compose
```

Test the installation of Docker & Docker-Compose:
```bash
docker version
docker-compose version
```