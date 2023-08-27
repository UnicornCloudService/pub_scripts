#!/bin/bash
# Script to install PowerShell
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell-lts
sudo rm packages-microsoft-prod.deb
pwsh -NonInteractive -NoProfile -NoLogo -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
pwsh -NonInteractive -NoProfile -NoLogo -Command "Install-Module -Name Az -AllowClobber -Scope AllUsers -Force"
pwsh -NonInteractive -NoProfile -NoLogo -Command "Install-Module -Name powershell-yaml -AllowClobber -Scope AllUsers -Force"