FROM php:7.1.27-apache

RUN apt-get update -y \
        && apt-get install -y libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6-dev libxml2-dev tzdata

RUN  cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
         &&  echo "America/Sao_Paulo" > /etc/timezone


RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    --enable-gd-native-ttf

RUN docker-php-ext-install pdo_mysql mbstring json hash ctype session xml dom gd

RUN docker-php-ext-enable pdo_mysql mbstring json hash ctype session xml dom gd

ADD kanboard-1.2.8.tar.gz /opt

COPY docker-entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

RUN mv /opt/kanboard-1.2.8 /opt/kanboard \
        && rm /opt/kanboard/config.default.php

COPY config.php /opt/kanboard/config.php
ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["apachectl", "-D", "FOREGROUND"]
