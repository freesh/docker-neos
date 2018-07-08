# Commands

* [Misc](#misc)
* [Docker](#docker)
* [SSH](#ssh)
* [Composer](#composer)
* [Yarn](#yarn)
* [Neos](#neos)

### Misc

```make help``` | list all commands

```make setup``` | Setup docker environment

```make config``` | Show configuration from .env and rendered docker-compose.yml

### Docker

```make up``` | Run _docker-compose up -d_ and visit: http://localhost:8080

```make down``` | Run _docker-compose down_

```make logs``` | Show container logs

### SSH

```make ssh``` | opens a php bash with ssh [user: www-data]

```make ssh-root``` | opens a php bash with ssh [user: root]

```make ssh-mariadb``` | opens a mariadb bash with ssh

```make ssh-node``` | opens a node shell with ssh [user: node]

### Composer

```make composer-install``` or ```make ci```| exucute _composer install_ on php container

### Yarn

```make yarn-install``` or ```make yi``` | execute _yarn install_ on node container"

```make yarn-build``` or ```make yb``` | execute _yarn build_ on node container"

```make yarn-watch``` or ```make yw``` | execute _yarn watch_ on node container"

```make yarn-clear``` or ```make yc``` | empties node_modules volume

### Neos

**_(experimental)_**

```make neos-cache-flush``` or ```make ncf``` | Clear cache

```make neos-doctrine-migrate:``` or ```make ndm``` | Migrate database

```make neos-clone``` or ```make nc``` | Clone data from existing neos system with sitegeist/magicwand