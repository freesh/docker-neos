###############################################################################
#                                VARIABLES                                    #
###############################################################################
include .env
export
SHELL=/bin/bash
WORKDIR=App
#.PHONY: build

###############################################################################
#                                  HELP                                       #
###############################################################################
help:
	@echo ""
	@echo "Command           | shorthand | describtion"
	@echo "-------------------------------------------------------------------"
	@echo " install          |           | Install project"
	@echo " composer-install |           | execute composer install"
	@echo ""
	@echo "SSH Commands"
	@echo "-------------------------------------------------------------------"
	@echo " ssh              |           | opens a bash with ssh [user: www-data]"
	@echo " ssh-root         |           | opens a bash with ssh [user: root]"
	@echo ""
	@echo "Neos Commands"
	@echo "-------------------------------------------------------------------"
	@echo " neos-cache-flush | ncf       | flush neos cache"
	@echo " neos-clone       | nc        | clone project from choosen preset [package: sitegeist/magicwand]"
###############################################################################
#                                  INSTALL                                    #
###############################################################################
install:
	#@set -e
	#@test $(site) || (echo "site is not set" && exit 1)
	cd ${WORKDIR} && nvm use && yarn install && yarn build
	#&& ln -sf ./Build/Githooks/pre-commit ./.git/hooks/pre-commit
	

config:
	echo "Php version: $(PHPVERSION)"

###############################################################################
#                                  COMPOSER INSTALL                           #
###############################################################################
composer-install:
	@docker-compose exec --user www-data php-fpm ssh-agent composer install

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
