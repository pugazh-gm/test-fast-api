#!/bin/bash
set -e
 
echo "Running AfterInstall hook..."
pwd
ls -lhrt
 
if [ -f /etc/profile.d/deploy_env.sh ]; then
  source /etc/profile.d/deploy_env.sh
fi
 
echo "Deploy Environment from user data: $DEPLOY_ENV"
# Go to app directory
cd /var/www/html
 
cp .env.$DEPLOY_ENV .env
sudo chown www-data:www-data .env
sudo chmod 775 .env
# cp -R /home/ubuntu/images/* /var/www/html/storage/app/public/
# Laravel folders setup
mkdir -p storage/framework/{cache,sessions,views}
mkdir -p storage/logs
mkdir -p bootstrap/cache
 
# Set permissions
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
 
# Touch log file
sudo touch storage/logs/laravel.log
sudo chown www-data:www-data storage/logs/laravel.log
sudo chmod 664 storage/logs/laravel.log
 
# Install PHP dependencies WITHOUT running artisan discover
composer install --no-dev --optimize-autoloader --no-scripts
 
# Laravel commands after install
php artisan config:clear || true
php artisan cache:clear || true
php artisan route:clear || true
php artisan view:clear || true
 
# Node.js build (optional)
npm install
npm run dev
sudo php artisan storage:link
 
# Apache VirtualHost setup (optional)
APACHE_CONF_PATH="/etc/apache2/sites-available/raido_admin.conf"
 
if [ ! -f "$APACHE_CONF_PATH" ]; then
  echo "Creating Apache VirtualHost configuration..."
  sudo tee $APACHE_CONF_PATH > /dev/null <<EOL
<VirtualHost *:8000>
    ServerAdmin webmaster@localhost
    ServerName localhost
 
    DocumentRoot /var/www/html/public
 
    <Directory /var/www/html/public>
        AllowOverride All
        Require all granted
    </Directory>
 
    ErrorLog \${APACHE_LOG_DIR}/raido_admin_error.log
    CustomLog \${APACHE_LOG_DIR}/raido_admin_access.log combined
</VirtualHost>
EOL
 
sudo tee /etc/apache2/ports.conf > /dev/null <<EOL
Listen 8000
EOL
 
  sudo a2ensite raido_admin.conf
  sudo a2enmod rewrite
fi
 
echo "AfterInstall completed successfully."