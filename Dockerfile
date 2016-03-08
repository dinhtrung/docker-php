FROM php:zts
RUN apt-get update && apt-get install -y \
    rsyslog libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
    libpng12-dev libicu-dev libxml2-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mbstring intl pdo_mysql zip sockets soap simplexml \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install pthreads && docker-php-ext-enable pthreads
ADD start-cron.sh /usr/sbin/start-cron.sh
RUN chmod +x /usr/sbin/start-cron.sh && sed -i '/session    required     pam_loginuid.so/c\#session    required     pam_loginuid.so' /etc/pam.d/cron
CMD /usr/sbin/start-cron.sh
