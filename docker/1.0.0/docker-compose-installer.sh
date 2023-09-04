#!/bin/bash
# Script to install Docker Compose
curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chown root:docker /usr/local/bin/docker-compose
sudo chmod 775 /usr/local/bin/docker-compose