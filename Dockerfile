FROM alpine:latest
RUN apk update && apk add --no-cache apache2 curl php7 php7-apache2 php7-phar php7-dom php7-zip php7-sockets php7-opcache php7-apcu php7-xmlrpc php7-tokenizer php7-intl php7-mbstring php7-fileinfo php7-gd php7-json php7-xml php7-soap php7-curl php7-session php7-mcrypt php7-openssl php7-simplexml php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite
RUN mkdir -p /run/apache2 && \
  /usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php -- --install-dir=/usr/bin --filename=composer && \
  /usr/bin/composer global require fxp/composer-asset-plugin

WORKDIR /var/www/localhost/htdocs
ENTRYPOINT http -DFOREGROUND
