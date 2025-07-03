#!/bin/bash
set -e
 
echo "Running BeforeInstall hook..."
 
# Stop Apache
sudo systemctl stop apache2 || true
 
# Clear old application (optional)
sudo rm -rf /var/www/html/*
 
echo "BeforeInstall completed."