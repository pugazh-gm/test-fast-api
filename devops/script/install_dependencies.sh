#!/bin/bash
echo "Installing dependencies..."

cd /home/ubuntu/fastapi-app

# Install venv if missing
sudo apt-get update
sudo apt-get install -y python3-venv

# Create virtual environment if it doesn't exist
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Upgrade pip inside venv
pip install --upgrade pip

# Install requirements inside the venv
pip install -r requirements.txt

# Done
echo "Dependencies installed inside virtual environment."
