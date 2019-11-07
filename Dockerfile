ARG BASEIMAGE

FROM $BASEIMAGE

COPY docker-php-ext-get /usr/local/bin/

RUN apk add --no-cache --virtual .build-deps \
        autoconf \
        build-base \
 && apk add --no-cache \
        freetype \
        gmp-dev \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libzip-dev \
 && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
 && docker-php-source extract \
 && docker-php-ext-get mongodb 1.6.0 \
 && docker-php-ext-install -j$(nproc) \
        gd \
        gmp \
        mongodb \
        pdo_mysql \
        zip \
 && docker-php-source delete \
 && apk del .build-deps