# Caching

Build processes like composer and yarn using a cache to install packages with a better performance.

## Caching Composer

The php-fpm container uses the composer cache directory as a mount from your local composer cache from your host system. _~/.composer/cache_


## Caching Yarn

For yarn the --cache-folder flag is configured in the _./Docker/Config/node/.yarnrc_ file. 

```
--cache-folder /home/node/yarn/yarn-cache/
```

This path is linked to a docker volume, because the yarn container exist only for runtime of the yarn command.

## Caching node_modules

The _node_modules_ folder is linked to a volume, because the yarn container exist only for runtime of the yarn command.