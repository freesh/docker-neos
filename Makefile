###############################################################################
#                                VARIABLES                                    #
###############################################################################
SHELL=/bin/bash
WORKDIR=App
#.PHONY: build

###############################################################################
#                                  HELP                                       #
###############################################################################
help:
	@echo "Available Commands"
	@echo "------------------"
	@echo "install			- Install project"
	@echo "composer-install	- execute composer install"
	@echo ""
	@echo "clone			- clone project from choosen preset [package: sitegeist/magicwand]"
	@echo ""
	@echo "ssh			- opens a bash with ssh [user: www-data]"
	@echo "ssh-root		- opens a bash with ssh [user: root]"

###############################################################################
#                                  INSTALL                                    #
###############################################################################
install:
	#@set -e
	#@test $(site) || (echo "site is not set" && exit 1)
	cd ${WORKDIR} && nvm use && yarn install && yarn build
	#&& ln -sf ./Build/Githooks/pre-commit ./.git/hooks/pre-commit
	

###############################################################################
#                                  COMPOSER INSTALL                           #
###############################################################################
composer-install:
	@docker-compose exec --user www-data php-fpm ssh-agent composer install

###############################################################################
#                                  CLONE                                      #
###############################################################################
clone:
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
