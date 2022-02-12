# 🐳 Docker-Compose
The food for the whale called Docker. Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## ⌨️ Install docker-compose
To install docker-compose run the following commands or follow the installation guide on the docker [website](https://docs.docker.com/compose/install/).
1. Run this command to download the current stable release of Docker Compose:
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
2. Run this command to download the current stable release of Docker Compose:
```bash
sudo chmod +x /usr/local/bin/docker-compose
```
3. Test the installation:
```bash
docker-compose --version
```