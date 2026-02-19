#!/bin/sh
set -e

# Ensure storage directories exist
mkdir -p /var/www/html/storage/framework/sessions
mkdir -p /var/www/html/storage/framework/views
mkdir -p /var/www/html/storage/framework/cache
mkdir -p /var/www/html/storage/logs
mkdir -p /var/www/html/bootstrap/cache

# Fix permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
if [ -d "/var/www/html/storage" ]; then
    chmod 600 /var/www/html/storage/oauth-*.key 2>/dev/null || true
fi

if [ "$1" = "php-fpm" ]; then
    # Create storage link if missing
    # We run this as www-data via gosu to ensure correct ownership of the symlink
    if [ ! -L "/var/www/html/public/storage" ]; then
        gosu www-data php artisan storage:link || true
    fi
    
    # Optimizations
    gosu www-data php artisan config:cache || true
    gosu www-data php artisan route:cache || true
    gosu www-data php artisan view:cache || true
fi

exec "$@"
