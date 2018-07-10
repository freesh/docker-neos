# Configurationfiles

Please use for your individual modifications your own config files in ./local or other places on your host system like ~/myDockerConfigs... and update paths in your .env file. So you can pull updates without overwriting your modifications.

- [PHP](#php)
- [Nginx](#nginx)
- [SSH](#ssh)
  - [SSH config](#ssh-config)
  - [SSH rsa_id](#ssh-rsa_id)
  - [SSH agent](#ssh-agent)
- [MariaDB](#mariadb)

# PHP

### php versions

The used php version can configured in ./.env file

```PHP_VERSION=7.2```

php 5.x is also supported. See all available version numbers at https://store.docker.com/images/php. Always the fpm-alpine images are used.

The local image build will be tagged und reused for other projects with the same php version. For saving discspace.

### php.ini

The php.ini can be found and edited in _/Docker/Config/php/php.ini_. This file will be mounted in the _php-fpm_ container.


# Nginx

### Port

The used nginx port can configured in ./.env file

```NGINX_PORT=8080```

### nginx.conf

The nginx.conf can be found and edited in _/Docker/Config/nginx/nginx.conf_. This file will be mounted in the _webserver_ container.

# SSH

### SSH config

For composer und git usage within the containers, there is a default ssh conf. This is mouted in containers wich need to access git repositories.

_./Docker/Config/ssh/config_

```
Host *
    IdentityFile /run/secrets/id_rsa
    AddKeysToAgent yes
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

You can change the path to this file in your .env file: ```CONF_SSH=...```

### SSH rsa_id

Additionally in the _docker-compose.yml_ secrets are configured with the path to your hosts rsa_id files:

```yaml
# definition:
secrets:
  id_rsa.pub:
    file: ~/.ssh/id_rsa.pub
  id_rsa:
    file: ~/.ssh/id_rsa

# used like that:
services:
  php-fpm:
    # ...
    secrets:
      - id_rsa.pub
      - id_rsa
```

You can change this in an [overriding docker-compose.yml](configuration/override-docker-compose-yml.md) file.

### SSH agent

The ssh agent is transvered with the make commands to the containers. So you have to insert your rsa_id secret just one time per session if needed.

# Node

### node version

The used node version can configured in ./.env file

```NODE_VERSION=6```

See all available version numbers at https://store.docker.com/images/node. Always the alpine images are used.

The local image build will be tagged und reused for other projects with the same php version. For saving discspace.

## .yarnrc 

Yarn config can found in _./Docker/Config/node/.yarnrc_. Default values are used to move _node_modules_ and _yarn-cache_ to _/home/node/yarn/_ and are mounted to a volume. ```yarn install``` will be extremely fast after first install command and packages within _node_modules_ will not be shared with host and other containers.
For more informations about _.yarnrc_ please visit https://yarnpkg.com/lang/en/docs/yarnrc/


# mariadb

### Customize configuration

To add your own configuration you can use the mounted conf file in _Docker/Config/mariadb/my.cnf_. It will be mounted in the container. Don't forget to restart the container.

Example:

```conf
[mysqld]
# innodb settings
innodb_large_prefix=1
```


### Show used confguration

For all used conf variables:

```bash
mysql -uroot -utoor

MariaDB [(none)]> SHOW VARIABLES;
```


Serach for variables with _LIKE_:
```bash
mysql -uroot -utoor

MariaDB [(none)]> SHOW VARIABLES LIKE '%innodb%';
+---------------------------------------------+------------------------+
| Variable_name                               | Value                  |
+---------------------------------------------+------------------------+
| ignore_builtin_innodb                       | OFF                    |
| innodb_adaptive_flushing                    | ON                     |
| innodb_adaptive_flushing_lwm                | 10.000000              |
| innodb_adaptive_hash_index                  | ON                     |
| innodb_adaptive_hash_index_partitions       | 1                      |
| innodb_adaptive_max_sleep_delay             | 150000                 |
| innodb_additional_mem_pool_size             | 8388608                |

...

1 row in set (0.00 sec)
```
