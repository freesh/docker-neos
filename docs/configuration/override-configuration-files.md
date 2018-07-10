# Override configuration files

Every container need some configurationfiles like _php.ini_ or _vhosts.conf_ for nginx. These files are placed in _./Docker/configuration/_ on the host system and will be mounted in to the container.
```
.
├── Docker
│   ├── Config
│   │   ├── mariadb
│   │   │   └── my.cnf
│   │   ├── nginx
│   │   │   └── vhost.conf
│   │   ├── node
│   │   │   └── .yarnrc
│   │   ├── php
│   │   │   └── php.ini
│   │   └── ssh
│   │       └── config
│   └── Dockerfile
│       └── ...
```

You can change these files directly and the containers will use it. In some reasons the container like nginx should restarted to work with the changed configuration correctly.

But in some cases you need a change on your host system only. This is the case if you habe a versioned project, wich is used by other developers und you need an additional or differen vhost for usage on your machine only.

In this case you can create an additional config file and change the path to it in the .env file.

_Example:_

```
CONF_NGINX_VHOST=./Docker/Config/nginx/vhost.conf

# changed to:

CONF_NGINX_VHOST=./local/vhost.conf

```

The _./local/_ folder is ignored by git per default, so you can put all your local stuff in there.
