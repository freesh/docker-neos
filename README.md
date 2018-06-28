# Docker Neos

This is a docker setup for local development with php and nginx for Neos CMS (https://www.neos.io)

## Setup

1. clone repository
2. configure .env
4. run ```docker-compose up -d```
5. create your project in ./App/


## Commands

```make help``` | list all commands

### Composer

```make composer-install``` | run _composer install_ on php container

### Docker

```make up``` | Run _docker-compose -d_ and visit: http://localhost:8080

```make down``` | Run _docker-compose down_

```make logs``` | Show container logs

### SSH php container

```make ssh``` | bash with ssh-agent as www-data user

```make ssh-root``` | bash with ssh-agent as root user

**call example command with ssh-agent**

```docker-compose --user www-data php-fpm ssh-agent composer install```

```docker-compose --user www-data php-fpm ssh-agent ./flow clone:preset live```

### Neos commands

```make neos-cache-flush``` or ```make ncf``` | Clear cache

```make neos-clone``` or ```make nc``` | Clone data from existing neos system with sitegeist/magicwand

## Nginx configuration

The nginx.conf will be found in _./Docker/nginx/nginx.conf_ and mounted in the _webserver_ container.

## Php configuration

### php versions

The used php version can configured in ./.env file

```PHPVERSION=7.2```

php 5.x is also supported. See available version numbers at https://store.docker.com/images/php. Always the alpine images are used.

The local image build will be taged und reused for other projects with the same php version.

### php.ini

The php.ini can be found and edited in _/Docker/php/php.ini_. This file will be mounted in the container.
