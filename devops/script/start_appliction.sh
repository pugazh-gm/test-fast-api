#!/bin/bash
set -e
 
echo "Running ApplicationStart hook..."
 
# cp -R /home/ubuntu/images/* /var/www/html/storage/app/public/
 
# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl restart apache2
 
echo "ApplicationStart completed."