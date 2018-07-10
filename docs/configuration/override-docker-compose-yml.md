# Override or extend docker-compose.yml

For local overrides of the versioned docker-compose.yml docker-compose is extendable by autoloading a docker-compose.override.yml. This is a default feature of docker-compose. For more informations take a look at the offical documentation: https://docs.docker.com/compose/extends/

## Adding additionaly own override files:
You can add additionally own files. For example add a global docker-compose file from your host system is easy with configuring them in the .env file.

_Example: Add ~/docker-compose.global.yml_

```
# ...

# Docker
COMPOSE_FILE=./docker-compose.yml:./docker-compose.override.yml:/Users/myuser/docker-compose.global.yml
```

**Note:** ~/ for linking to users home directory is not supported by docker-compose. So you have to use the absolute path for that.