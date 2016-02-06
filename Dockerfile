FROM nguyendinhtrung141/php:yii2
RUN apt-get update && apt-get install -y libssl-dev \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-install -j$(nproc) sockets && \
    && docker-php-ext-install -j$(nproc) soap    
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/bin
