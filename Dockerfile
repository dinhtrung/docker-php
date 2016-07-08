FROM php:fpm-alpine
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
RUN docker-php-ext-install pdo_mysql iconv mcrypt mbstring intl zip intl gd sockets soap
