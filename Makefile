###############################################################################
#                                VARIABLES                                    #
###############################################################################
-include .env
export
SHELL=/bin/bash
WORKDIR=App
#.PHONY: build

###############################################################################
#                                  HELP                                       #
###############################################################################
help:
	@echo ""
	@echo "Command           | Shorthand | Description"
	@echo "-------------------------------------------------------------------"
	@echo " help             |           | List all commands"
	@echo " setup            |           | Setup docker environment"
	@echo " install          |           | Install project -> start build process and composer install"
	@echo " config           |           | Show configuration from .env and rendered docker-compose.yml"
	@echo ""
	@echo "Docker Commands"
	@echo "-------------------------------------------------------------------"
	@echo " up               |           | Run docker-compose up -d"
	@echo " down             |           | Run docker-compose down"
	@echo " logs             |           | Show container logs"
	@echo ""
	@echo "SSH Commands"
	@echo "-------------------------------------------------------------------"
	@echo " ssh              |           | opens a php bash with ssh [user: www-data]"
	@echo " ssh-root         |           | opens a php bash with ssh [user: root]"
	@echo " ssh-mariadb      |           | opens a mariadb bash with ssh"
	@echo " ssh-node         |           | opens a node shell with ssh [user: node]"
	@echo ""
	@echo "Composer Commands"
	@echo "-------------------------------------------------------------------"
	@echo " composer-install | ci        | execute composer install"
	@echo ""
	@echo "Yarn Commands"
	@echo "-------------------------------------------------------------------"
	@echo " yarn-install     | yi        | execute yarn install"
	@echo " yarn-build       | yb        | execute yarn build"
	@echo " yarn-watch       | yw        | execute yarn watch"
	@echo " yarn-clear       | yc        | empties node_modules volume"
	@echo ""
	@echo "Neos Commands"
	@echo "-------------------------------------------------------------------"
	@echo " neos-cache-flush | ncf       | Flush neos cache"
	@echo " neos-clone       | nc        | Clone project from choosen preset [package: sitegeist/magicwand]"

###############################################################################
#                                  SETUP                                    #
###############################################################################
setup:
	if [ ! -f .env ]; then cp ./.env.sample ./.env; fi
	if [ ! -f docker-compose.override.yml ]; then echo "version: \"3.6\"" >> docker-compose.override.yml; fi
	if [ -f App/.gitkeep ]; then rm ./App/.gitkeep; fi

###############################################################################
#                                  INSTALL                                    #
###############################################################################
install: up composer-install yarn-install yarn-build

config:
	@echo ".env config"
	@echo "______________________________________________"
	@echo ""
	@echo "Versions"
	@echo "--------"
	@echo "Php-fpm: $(VERSION_PHP)"
	@echo "Node: $(VERSION_NODE)"
	@echo "MariaDB: $(VERSION_MARIADB)"
	@echo ""
	@echo "Ports"
	@echo "-----"
	@echo "Nginx port: $(PORT_NGINX)"
	@echo "MariaDB port: $(PORT_MARIADB)"
	@echo ""
	@echo "Configuration files"
	@echo "-------------------"
	@echo "Php php.ini: $(CONF_PHP_PHPINI)"
	@echo "MariaDB my.cnf: $(CONF_MARIADB_MYCNF)"
	@echo "Node .yarnrc: $(CONF_NODE_YARNRC)"
	@echo "Nginx vhost: $(CONF_NGINX_VHOST)"
	@echo "SSH config: $(CONF_SSH)"
	@echo ""
	@echo "Credentials"
	@echo "-----------"
	@echo "MySQL database: $(CRED_MYSQL_DATABASE)"
	@echo "MySQL user: $(CRED_MYSQL_USER)"
	@echo "MySQL password: $(CRED_MYSQL_PASSWORD)"
	@echo "MySQL root-password: $(CRED_MYSQL_ROOT_PASSWORD)"
	@echo ""
	@echo ""
	@echo "docker config"
	@echo "______________________________________________"
	@docker-compose config

###############################################################################
#                                  COMPOSER                                   #
###############################################################################
ci: composer-install
composer-install:
	@docker-compose exec --user www-data php-fpm ssh-agent composer install

###############################################################################
#                                  Yarn                                       #
###############################################################################
yi: yarn-install
yarn-install:
	@docker-compose run --rm node yarn install

yb: yarn-build
yarn-build:
	@docker-compose run --rm node yarn build

yw: yarn-watch
yarn-watch:
	@docker-compose run --rm node yarn watch

yc: yarn-clear
yarn-clear:
	@docker-compose run --rm node rm -Rf ./node_modules/*

###############################################################################
#                                  Docker                                     #
###############################################################################
up:
	@docker-compose up --scale node=0 -d

down:
	@docker-compose down

logs:
	@docker-compose logs

###############################################################################
#                                  Neos                                       #
###############################################################################

# experimental
neos-create:
	@docker-compose exec --user www-data php-fpm ssh-agent composer create-project neos/neos-base-distribution .

# experimental
ncf: neos-cache-flush
neos-cache-flush:
	@docker-compose exec --user www-data php-fpm ssh-agent ./flow flow:cache:flush

# experimental
ndm: neos-doctrine-migrate
neos-doctrine-migrate:
	@docker-compose exec --user www-data php-fpm ssh-agent ./flow doctrine:migrate

# experimental
nc: neos-clone
neos-clone:
	@docker-compose exec --user www-data php-fpm ssh-agent ./flow clone:list; \
		read -p "Enter preset name: " PRESETNAME; \
    	docker-compose exec --user www-data php-fpm ssh-agent ./flow clone:preset $$PRESETNAME --yes

###############################################################################
#                                  SSH                                        #
###############################################################################
ssh:
	docker-compose exec --user www-data php-fpm ssh-agent $(SHELL)

ssh-root:
	docker-compose exec --user root php-fpm ssh-agent $(SHELL)

ssh-mariadb:
	docker-compose exec mariadb $(SHELL)

ssh-node:
	@docker-compose run --rm --user node node /bin/sh
