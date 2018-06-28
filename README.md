# Docker Neos

This is a docker setup for local development with php and nginx for Neos CMS (https://www.neos.io)

## Setup

1. clone repository
2. configure .env
4. run ```docker-compose up -d```
5. create your project in ./App/

## Run Application

**Run**

```docker-compose up -d```

visit: http://localhost:8080

**Stop**

```docker-compose down```


## Access php container

**bash with ssh-agent as web or root user**

```make ssh```

```make ssh-root```

**composer install in container**

```make composer-install```

**call example command with ssh-agent**

```docker-compose --user www-data php-fpm ssh-agent composer install```

```docker-compose --user www-data php-fpm ssh-agent ./flow clone:preset live```


## Nginx configuration

The nginx.conf will be found in _./Docker/nginx/nginx.conf_ and mounted in the _webserver_ container.

## Php configuration

### php versions

The used php version can configured in ./.env file

```PHPVERSION=7.2```

php 5.x is also supported. See available version numbers at https://store.docker.com/images/php. Always the alpine images are used.

The local image build will be taged und reused for other projects with the same php version.

### php.ini

tbd.
