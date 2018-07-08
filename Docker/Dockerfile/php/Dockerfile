ARG phpversion=7.0
FROM php:$phpversion-fpm-alpine
#WORKDIR "/application"

ARG phpversion=7.0
ENV PHPIZE_DEPS \
        autoconf \
        g++ \
        libtool \
        make \
        pcre-dev 
RUN printf "\e[1;34m### RUN apk add \n \e[0m" \
    && apk --update add --no-cache \
        bash \
        bzip2 \
        freetype-dev \
        imagemagick \
        imagemagick-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        # used for neos magicwand and composer
        openssh-client \
        git \
        rsync \
        mysql-client \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS \
    ###################
    # pecl
    && printf "\e[1;34m### RUN pecl install \n \e[0m" \
    && docker-php-source extract \
    && if [[ ${phpversion:0:1} == "5" ]] ; \
        then  \
            printf "\e[1;34mInstall Pecl php 5.x \n \e[0m"; \
            pecl install apcu-4.0.11 imagick; \
            docker-php-ext-enable apcu imagick; \
        else \
            printf "\e[1;34mInstall Pecl php 7.x \n \e[0m"; \
            pecl install apcu imagick; \
            docker-php-ext-enable apcu imagick; \
    fi \
    && apk del .phpize-deps-configure \
    ####################
    # docker-php-ext-configure
    && printf "\e[1;34m### RUN docker-php-ext-configure \n \e[0m" \
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    ####################
    # docker-php-ext-install
    && printf "\e[1;34m### RUN docker-php-ext-install \n \e[0m" \
    && docker-php-ext-install \
        bcmath \
        gd \
        mysqli \
        pdo_mysql \
        opcache \
    ####################
    # clear
    && printf "\e[1;34m### Clear \n \e[0m" \
    && docker-php-source delete \
    ####################
    # install composer
    && printf "\e[1;34m### Install composer \n \e[0m" \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
