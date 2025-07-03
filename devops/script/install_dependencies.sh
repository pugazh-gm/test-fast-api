#!/bin/bash
echo "Installing dependencies..."

# Update package manager
sudo apt-get update

# Install required system packages
sudo apt-get install -y python3-pip python3-dev

# Just in case: install pip3 if it's missing
if ! command -v pip3 &> /dev/null
then
  echo "Installing pip3..."
  curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3
fi

# Install Python dependencies globally
cd /home/ubuntu/fastapi-app
sudo pip3 install -r requirements.txt
