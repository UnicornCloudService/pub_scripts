#!/bin/bash
# Script to install npm and nodejs latest version
sudo apt remove libnode-dev -y
sudo apt update
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update
sudo apt-get install -y nodejs
sudo npm install -g npm@latest