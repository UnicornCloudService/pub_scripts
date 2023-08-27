#!/bin/bash
# Script to install kubelogin
wget https://github.com/Azure/kubelogin/releases/download/v0.0.31/kubelogin-linux-amd64.zip
unzip kubelogin-linux-amd64.zip
sudo mv bin/linux_amd64/kubelogin /usr/local/bin/
sudo chmod 775 /usr/local/bin/kubelogin
rm kubelogin-linux-amd64.zip