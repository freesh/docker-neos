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
	@echo " help             |           | List all commands
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
	@echo " ssh              |           | opens a bash with ssh [user: www-data]"
	@echo " ssh-root         |           | opens a bash with ssh [user: root]"
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
	@echo ""
	@echo "Neos Commands"
	@echo "-------------------------------------------------------------------"
	@echo " neos-cache-flush | ncf       | Flush neos cache"
	@echo " neos-clone       | nc        | Clone project from choosen preset [package: sitegeist/magicwand]"

###############################################################################
#                                  INSTALL                                    #
###############################################################################
setup:
	cp ./.env.sample ./.env
###############################################################################
#                                  INSTALL                                    #
###############################################################################
install:
	#@set -e
	#@test $(site) || (echo "site is not set" && exit 1)
	cd ${WORKDIR} && nvm use && yarn install && yarn build
	#&& ln -sf ./Build/Githooks/pre-commit ./.git/hooks/pre-commit
	

config:
	@echo ".env config"
	@echo "-------------"
	@echo "Php version: $(PHPVERSION)"
	@echo "Node version: $(NODEVERSION)"
	@echo ""
	@echo "docker config"
	@echo "-------------"
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
	@docker-compose run node yarn install

yb: yarn-build
yarn-build:
	@docker-compose run node yarn build

yw: yarn-watch
yarn-watch:
	@docker-compose run node yarn watch

###############################################################################
#                                  Docker                                     #
###############################################################################
up:
	@docker-compose up -d

down:
	@docker-compose down

logs:
	@docker-compose logs

###############################################################################
#                                  Neos                                       #
###############################################################################
nc: neos-clone
neos-clone:
	@docker-compose exec --user www-data php-fpm ssh-agent ./flow clone:list; \
		read -p "Enter preset name: " PRESETNAME; \
    	docker-compose exec --user www-data php-fpm ssh-agent ./flow clone:preset $$PRESETNAME --yes

ncf: cache-flush
neos-cache-flush:
	@docker-compose exec --user www-data php-fpm ssh-agent ./flow flow:cache:flush --yes

###############################################################################
#                                  SSH                                        #
###############################################################################
ssh:
	docker-compose exec --user www-data php-fpm ssh-agent $(SHELL)

ssh-root:
	docker-compose exec --user root php-fpm ssh-agent $(SHELL)
