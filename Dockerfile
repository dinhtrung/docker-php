FROM php:fpm-alpine
RUN apk update && apk add --no-cache coreutils freetype-dev libjpeg-turbo-dev libltdl libmcrypt-dev libpng-dev icu-dev libxml2-dev openssl-dev libxslt-dev \
&& docker-php-ext-install -j$(nproc) iconv mcrypt mbstring intl mysqli pdo_mysql zip sockets soap simplexml xsl opcache \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
&& /usr/bin/curl -sS https://getcomposer.org/installer | /usr/local/bin/php -- --install-dir=/usr/local/bin --filename=composer
