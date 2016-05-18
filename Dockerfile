FROM php:fpm
RUN groupmod -g 48 www-data && usermod -u 1000 www-data && chown -R www-data:www-data /var/www/html && \
    apt-get update && apt-get install -y \
    libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
    libpng12-dev libicu-dev libxml2-dev libssl-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mbstring intl pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-install -j$(nproc) soap 
