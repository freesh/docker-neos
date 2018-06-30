# Configurationfiles

Please use for your individual modifications your own config files in ./local or other places on your host system like ~/myDockerConfigs... and update paths in your .env file. So you can pull updates without overwriting your modifications.

- [mariadb](#mariadb)
- [php](#php)
- [nginx](#nginx)
- [ssh](#ssh)

# mariadb

## Customize configuration

To add your own configuration you can use the mounted conf file in _Docker/Config/mariadb/my.cnf_. It will be mounted in the container. Don't forget to restart the container.

Example:

```conf
[mysqld]
# innodb settings
innodb_large_prefix=1
```


## Show used confguration

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
<br/>
<div align="right">
    <b><a href="#----">↥ back to top</a></b>
</div>
<br/>


# PHP

tbd.

# Nginx

tbd.

# SSH

tbd.

# Node

## .yarnrc 

Yarn config can found in _./Docker/Config/node/.yarnrc_. Default values are used to move _node_modules_ and _yarn-cache_ to _/home/node/yarn/_ and are mounted to a volume. ```yarn install``` will be extremely fast after first install command and packages within _node_modules_ will not be shared with host and other containers.
For more informations about _.yarnrc_ please visit https://yarnpkg.com/lang/en/docs/yarnrc/
