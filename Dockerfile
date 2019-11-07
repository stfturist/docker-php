ARG BASEIMAGE

FROM $BASEIMAGE

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    build-base

COPY docker-php-ext-get /usr/local/bin/

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
        --with-jpeg-dir=/usr/include/ && \
    docker-php-source extract && \
    docker-php-ext-get mongodb 1.6.0 && \
    docker-php-ext-install -j$(nproc) \
        gd \
        gmp \
        mongodb \
        pdo_mysql \
        zip && \
    docker-php-source delete

RUN apk del .build-deps