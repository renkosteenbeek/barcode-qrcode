# Gebruik een PHP 8 image als basis
FROM php:8-apache

# Stel de COMPOSER_ALLOW_SUPERUSER omgevingsvariabele in
ENV COMPOSER_ALLOW_SUPERUSER 1

# Update de packages, installeer requirements en verwijder cache
RUN apt-get update \
    && apt-get install -y git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installeer PHP Extentions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql

# Installeer Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && mv composer.phar /usr/local/bin/composer \
    && rm composer-setup.php

# Kopieer de broncode naar de container
COPY . /var/www/html

# Installeer PHP requirements met Composer
RUN composer update

# Stel de rechten in voor de webroot
RUN chown -R www-data:www-data /var/www/html

# Poort waarop de webserver luistert
EXPOSE 80

# Start Apache in de voorgrond
CMD ["apache2-foreground"]