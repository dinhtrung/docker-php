FROM php:5-fpm-alpine
RUN apk update && apk add \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libmcrypt-dev \
  libpng-dev \
  icu-dev \
  libxml2-dev \
  openssl-dev 
RUN docker-php-ext-install mysqli mysql pdo_mysql iconv mcrypt mbstring intl zip intl gd sockets soap
RUN mkdir -p /etc/php && touch /etc/php/php.ini && ln -sf /etc/php/php.ini /usr/local/etc/php/php.ini
RUN deluser www-data && addgroup -g1000 www-data && adduser -D -H -h /var/www/html -G www-data -u 1000 www-data
