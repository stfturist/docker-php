FROM php:7-fpm-alpine

RUN apk add --no-cache --virtual .build-deps \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    zlib-dev

RUN docker-php-ext-install \
   gd \
   pdo_mysql \
   zip

RUN apk del .build-deps