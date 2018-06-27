# Docker Neos

This is a docker setup for local development with php and nginx for Neos CMS (https://www.neos.io)

## Setup

1. clone repository

2. create your project in ./App/

## Run Application

**Run**

```docker-compose run -d```

visit: http://localhost:8080

**Stop**

```docker-compose down```


## Access php container

**bash with ssh-agent as web or root user**

```docker exec -i -t --user www-data leanferret-php7-fpm ssh-agent /bin/bash```

```docker exec -i -t --user root leanferret-php7-fpm ssh-agent /bin/bash```


**call example command with ssh-agent**

```docker exec -i -t --user www-data leanferret-php7-fpm ssh-agent composer install```

```docker exec -i -t --user www-data leanferret-php7-fpm ssh-agent ./flow clone:preset live```


## Nginx configuration

tbd.

## Php configuration

### php versions

tbd.

### php.ini

tbd.
