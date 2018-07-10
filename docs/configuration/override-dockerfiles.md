# Override or extend Dockerfiles

There are two ways to add changed Dockerfiles to your setup:

One for [local usage](#local-changes) only, and the other for [versioning](#versioning-changes) your changes with the project. In both ways you have to change the imagename in the _docker-compose.yml_ or _docker-compose.overrides.yml_

**Note:** Dont't forget to change the imagename in you docker-compose config, otherwise these changes can have sideeffects to other projects with the same images.

## Local changes:
Use _./local/Dockerfiles/php/Dockerfile_ and _docker-compose.overrides.yml_ for your local changes.

_Example: docker-compose.overrides.yml_

```yaml
version: "3.6"
services:
  php-fpm:
    image: local-projectname-php-fpm:${VERSION_PHP}
    build:
      context: ./local/Dockerfiles/php
      ...
```

## Versioned changes:
Edit Dockerfiles directly and change the imagename in the docker-compose.yml if these changes should be versioned with your project.

_Example: docker-compose.yml_

```yaml
version: "3.6"
services:
  php-fpm:
    image: projectname-php-fpm:${VERSION_PHP}
    build:
      ...
```
