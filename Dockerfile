FROM php:apache
RUN apt-get update && apt-get install -y \
 libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libssl-dev \
 libpng12-dev libicu-dev libxml2-dev libaio-dev unzip \
 && docker-php-ext-install -j$(nproc) iconv mcrypt mbstring intl pdo_mysql zip sockets soap simplexml \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd \
 && pecl install mongodb \
 && docker-php-ext-enable mongodb \
 && apt-get clean \
 && a2enmod rewrite

ADD instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
ADD instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/local/ \
 && unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/local/ \
 && ln -s /usr/local/instantclient_12_1 /usr/local/instantclient \
 && ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so \
 && rm -rf /tmp/* \
 && docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,/usr/local/instantclient,12.1.0.2.0 \
 && docker-php-ext-install pdo_oci \
 && docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient \
 && docker-php-ext-install oci8
