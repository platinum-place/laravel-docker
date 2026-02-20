
# ----------------------
# Stage 1: Build Frontend Assets
# ----------------------
FROM node:24-alpine AS frontend

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY vite.config.js ./
COPY resources ./resources
COPY public ./public

RUN npm run build

# ----------------------
# Stage 2: Build PHP App
# ----------------------
FROM php:8.5-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libpq-dev \
    libicu-dev \
    libmagickwand-dev \
    gosu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure intl \
    && docker-php-ext-install pdo_pgsql pgsql mbstring exif pcntl bcmath gd zip intl

# Install Redis and Imagick extensions
RUN pecl install redis imagick \
    && docker-php-ext-enable redis imagick

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy existing application directory contents
COPY . /var/www/html

# Copy built frontend assets (manifest etc. needed for mix/vite helpers)
COPY --from=frontend /app/public/build /var/www/html/public/build

# Copy PHP configurations
COPY docker/prod/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY docker/prod/php.ini /usr/local/etc/php/conf.d/99-custom.ini
COPY docker/prod/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Create system user to run Composer and Artisan Commands
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

ENTRYPOINT ["docker-entrypoint.sh"]

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
