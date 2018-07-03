# Docker Neos

This is a docker setup for local development with php, mariadb, node and nginx for Neos CMS (https://www.neos.io)

The goal is to get an instant setup, with maximum expandability and simplicity in the configuration, without the shell script hell.

After installation, a normal Neos will run immediately. Customizations can be easily created using .env, docker-compose.orverride.yml, or custom configs that override or extend the default values.

A makefile already includes the basic commands that are executed directly on the containers. e.g. composer, yarn, ssh, flow commands

## Getting started

**1. Create project folder and get docker-neos**

```bash
cd myprojectfolder
git clone git@github.com:freesh/docker-neos.git .
make setup
```
**2. configure your environment**

- open .env file and change default versions and paths for your needs.

**3. Start docker***

Can take some time on first run for building container images. (prebuild images are available soon as possible)

```
make up
```

**4. Move your project files to /App or create new neos project**

1. Init neos-base-distribution
```bash
make ssh
> composer create-project neos/neos-base-distribution .
> cp Configuration/Development/Settings.yaml.example Configuration/Development/Settings.yaml
```

2. Edit credetials in Configuration/Development/Settings.yaml with DB Data from your .env file. And for use with docker, set the http baseUri port.

_Example:_

```yaml
Neos:
  Flow:
    persistence:
      backendOptions:
        host: 'mariadb'
        dbname: 'app'
        user: 'toor'
        password: 'toor'
    http:
      baseUri: http://localhost:8080/
```
3. Migrate database and import demo site or create an own empty site.

```bash
make ssh
> ./flow doctrine:migrate
> ./flow user:create --roles Administrator,Editor admin password Admin User

# import demo site
> ./flow site:import --package-key Neos.Demo

# or create own sitepackage and site
> ./flow kickstart:site --package-key Vendor.Domain.Site --site-name MySite
> ./flow site:create MySite Vendor.Domain.Site
```
**5. Visit http://localhost:8080/**

## Basic Commands

**Misc**

```make help``` | list all commands

```make setup``` | Setup docker environment

```make config``` | Show configuration from .env and rendered docker-compose.yml

**Docker**

```make up``` | Run _docker-compose up -d_ and visit: http://localhost:8080

```make down``` | Run _docker-compose down_

```make logs``` | Show container logs

**SSH php container**

```make ssh``` | bash with ssh-agent as www-data user

```make ssh-root``` | bash with ssh-agent as root user

**Composer**

```make composer-install``` or ```make ci```| run _composer install_ on php container

**Yarn**

```make yarn-install``` or ```make yi``` | execute _yarn install_ on node container"

```make yarn-build``` or ```make yb``` | execute _yarn build_ on node container"

```make yarn-watch``` or ```make yw``` | execute _yarn watch_ on node container"

**Neos (experimental)**

```make neos-cache-flush``` or ```make ncf``` | Clear cache

```make neos-clone``` or ```make nc``` | Clone data from existing neos system with sitegeist/magicwand

```make neos-doctrine-migrate:``` or ```make ndm``` | Migrate database


## TBD

- Documentation: Commands
- Documentation: Configuration and Expandability
- Documentation: Caching for yarn and composer
- Documentation: Kickstart projects with butler, not only Neos. TYPO3 and Node projects are possible too.
- Documentation: Best practice
