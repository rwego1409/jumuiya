# Use the official PHP image from Docker Hub
FROM php:8.1-fpm

# Set working directory inside the container
WORKDIR /var/www

# Install system dependencies (required for Laravel)
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git unzip && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

# Install Composer (PHP package manager)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy the Laravel project files to the container
COPY . .

# Install project dependencies (via Composer)
RUN composer install --no-dev --optimize-autoloader

# Expose the port Laravel runs on
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]
