# Docker Neos

This is a docker setup for local development with php, mariadb, node and nginx for Neos CMS (https://www.neos.io)

The goal is to get an instant setup, with maximum expandability and simplicity in the configuration, without the shell script hell.

After installation, a normal Neos will run immediately. Customizations can be easily created using .env, docker-compose.orverride.yml, or custom configs that override or extend the default values.

A makefile already includes the basic commands that are executed directly on the containers. e.g. composer, yarn, ssh, flow commands

## Documentation

**Basics**

* [Getting Started](docs/basics/getting-started.md)
* [CLI Commands](docs/basics/commands.md)
* [Caching](basics/caching.md)

**Configuration**

* [Configuration](docs/configuration/configuration.md)
  * [PHP](docs/configuration/configuration.md#php)
  * [Nginx](docs/configuration/configuration.md#nginx)
  * [SSH](docs/configuration/configuration.md#ssh)
    * [SSH config](docs/configuration/configuration.md#ssh-config)
    * [SSH rsa_id](docs/configuration/configuration.md#ssh-rsa_id)
    * [SSH agent](docs/configuration/configuration.md#ssh-agent)
  * [MariaDB](docs/configuration/configuration.md#mariadb)
  * [Overrides](docs/configuration/configuration.md#overrides)
* [Override configuration files](docs/configuration/override-configuration-files.md)
* [Override and extend Makefile commands](docs/configuration/extend-makefile.md)
* [Override or extend docker-compose.yml](docs/configuration/override-docker-compose-yml.md)
* [Override or extend Dockerfiles](docs/configuration/override-dockerfiles.md)


## Getting Started

**1. Init**

```bash
$ mkdir myprojectfolder
$ cd myprojectfolder
$ git clone git@github.com:freesh/docker-neos.git .
$ make setup
```

**2. Settings**

open .env file and change default versions and paths for your needs.

**3. Start docker**

```bash
$ make up
```

**4. Setup project**

Copy your project files to _./App_, or ssh in to the php container and init your project with composer. For database credentials take a look in the generated _.env_ file. Don't forget to configure your project for usage with the configured http port.

```bash
$ make ssh
> composer ...
```

**5. Enjoy**

http://localhost:8080/


## Configurations

You can change default configurations on two ways:

The first way is to manipulate the default files and versioning these with your project. This is recommended if the changes are project relevant.

The seccond way is to use local override files, wich are not versioned. This ist recommended for changes there just relevant on your own host stystem.

### .env file

To configure versions (php, node), ports, file path and some other stuff, you can make changes through the generated _.env_ file.

For more informations about possible versions, please take a look at the [configuration](docs/configuration/configuration.md) section in the [documentation](docs/index.md).

### Override docker-compose settings

To override the default docker-compose.yml you can use the docker-compose.override.yml

### Appending and extending make commands

Appending own commands to the make file or extending the existing commands ist also possible with an own configuration file. See: [Override and extend Makefile commands](docs/configuration/extend-makefile.md)




## TBD

- Documentation: Best practice

