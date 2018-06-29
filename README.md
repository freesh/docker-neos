# Docker Neos

This is a docker setup for local development with php, mariadb and nginx for Neos CMS (https://www.neos.io)

## Setup

1. clone repository
2. run ```make setup```
3. configure .env
5. copy your project to ./App/
5. run ```make install``` | this runs ```make up make composer-install make yarn-install make yarn-build```

## Commands

```make help``` | list all commands

```make setup``` | Setup docker environment

```make config``` | Show configuration from .env and rendered docker-compose.yml

```make install``` | Install project -> start docker-compose, composer install and the build process

### Composer

```make composer-install``` or ```make ci```| run _composer install_ on php container

### Yarn

```make yarn-install``` or ```make yi``` | execute _yarn install_ on node container"

```make yarn-build``` or ```make yb``` | execute _yarn build_ on node container"

```make yarn-watch``` or ```make yw``` | execute _yarn watch_ on node container"

### Docker

```make up``` | Run _docker-compose up -d_ and visit: http://localhost:8080

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

php 5.x is also supported. See all available version numbers at https://store.docker.com/images/php. Always the fpm-alpine images are used.

The local image build will be tagged und reused for other projects with the same php version. For saving discspace.

### php.ini

The php.ini can be found and edited in _/Docker/php/php.ini_. This file will be mounted in the container.

## Node configuration

### node version

The used node version can configured in ./.env file

```NODEVERSION=6```

See all available version numbers at https://store.docker.com/images/node. Always the alpine images are used.

The local image build will be tagged und reused for other projects with the same php version. For saving discspace.


## Overrides

### docker-compose.override.yml

Create a _docker-compose.override.yml_ file to override the default _docker-compose.yml_. This file is automaticly loaded and merged by running ```docker-compose up```. For more informations see https://docs.docker.com/compose/extends/#understanding-multiple-compose-files

### own configurationfiles

tbd.

## TBD

- simplify sending custom commands to container
- configurable configfile paths in .env
- seperate config files from dockerfiles
- create prebuild images
- create testing images
- build production images command