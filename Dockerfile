ARG TAG

FROM php:$TAG

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    build-base

# PHP modules and GD requirements can not be virtual
RUN apk add --no-cache \
    freetype \
    gmp-dev \
    libpng \
    libjpeg-turbo \
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libzip-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install -j$(nproc) \
    exif \
    gd \
    gmp \
    pdo_mysql \
    zip

RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

RUN apk del .build-deps