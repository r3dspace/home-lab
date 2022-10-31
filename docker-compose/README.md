# 🐳 Docker & Docker-Compose
The food for the whale is called Docker-Compose. Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## ⌨️ Install Docker & Docker-Compose
To install Docker & Docker-Compose we will be using the Docker *convenience script*. For more information visit the Docker [website](https://docs.docker.com/engine/install/).

Run the following command's to start the installation process.

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Test the installation of Docker & Docker-Compose, by running the following commands.
```bash
docker version
docker compose version
```

Enable the service, if you wish to run Docker as the root user, with the following command.
```bash
systemctl enable docker
```

## 🔒 Running Docker in rootless mode
Running the Docker daemon as a non-root user increases the security on your system. If you would like to do this follow the steps on the Docker [website](https://docs.docker.com/engine/security/rootless/).