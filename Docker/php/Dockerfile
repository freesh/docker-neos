ARG phpversion
FROM php:$phpversion-fpm-alpine
WORKDIR "/application"

RUN apk --update add --no-cache \
        autoconf \
        bash \
        bzip2 \
        freetype-dev \
        g++ \
        imagemagick-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libtool \
        make \
        pcre-dev \
        # used for neos magicwand and composer
        openssh-client \
        git \
        rsync \
        mysql-client \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS \
    ###################
    # pecl
    && docker-php-source extract \
    && pecl install \
        apcu \
        imagick \
    && docker-php-ext-enable \
        apcu \
        imagick \
    && apk del .phpize-deps-configure \
    ####################
    # docker-php-ext-configure
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    ####################
    # docker-php-ext-install
    && docker-php-ext-install \
        bcmath \
        gd \
        #iconv \
        mcrypt \
        mysqli \
        pdo_mysql \
    ####################
    # clear
    && apk del \
        autoconf \
        g++ \
        libtool \
        make \
        pcre-dev \
    && docker-php-source delete \
    ####################
    # install composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
