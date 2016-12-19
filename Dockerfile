FROM php:7.0-fpm
MAINTAINER Remo Vetere <remo.vetere@gmail.com>
# see: https://codeable.io/wordpress-developers-intro-docker/
# and: https://github.com/docker-library/docs/tree/master/php

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libcurl4-gnutls-dev \
        libssl-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mbstring fileinfo curl ftp mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

VOLUME /var/www/html

WORKDIR /usr/local/etc/php/conf.d

COPY php.ini ./php.ini
