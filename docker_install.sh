#!/bin/bash

set -e

echo "Updating system..."
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install -y ca-certificates curl gnupg

echo "adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | 
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Setting up Docker repository..."
echo 
"deb [arch=$(dpkg --print-architecture) 
signed-by=/etc/apt/keyrings/docker.gpg] 
https://download.docker.com/linux/ubuntu 
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | 
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package list..."
sudo apt-get update -y

echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Starting Docker..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Docker installation complete"
echo "Please log out and log back in (or run 'newgrp docker') to use Docker without sudo."
