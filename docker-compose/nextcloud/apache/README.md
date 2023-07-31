## ⌨️ Setup
Before running the docker-compose file please follow these steps.

1. Add the relevant information into the .env file. Please insure the .env is in the same folder as the docker-compose file.
```bash
nano .env
```

2. Start the docker-compose file.
```bash
docker-compose up -d
```

3. Konfigure your reverse proxy to access container on port 8180.

*Anmerkung:*
- Keine `#` in der *.env* files