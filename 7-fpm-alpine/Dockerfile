FROM php:7-fpm-alpine

RUN apk add --no-cache --virtual .build-deps \
    zlib-dev

# GD requirements can not be virtual
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    exif \
    gd \
    pdo_mysql \
    zip

RUN apk del .build-deps