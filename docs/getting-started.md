# Getting started

**1. Create project folder and get docker-neos**

```bash
cd myprojectfolder
git clone git@github.com:freesh/docker-neos.git .
```

**2. init .env and docker-compose.override.yml**

```bash
make setup
```

**3. configure your environment**

- open .env file and set your needet versions for php and node.

_Defaults:_
```
PHP_VERSION=7.2
NODE_VERSION=6
NGINX_PORT=8080
```

**4. create new neos project**

1. Create project

```bash
make ssh
> composer create-project neos/neos-base-distribution .
> cp Configuration/Development/Settings.yaml.example Configuration/Development/Settings.yaml
```

2. Go to http://localhost:8080/setup and follow the instructions
Then edit credetials in Configuration/Development/Settings.yaml with DB Data from your .env file.

_Defaults:_

```yaml
Neos:
  Flow:
    persistence:
      backendOptions:
        host: 'mariadb'
        dbname: 'app'
        user: 'toor'
        password: 'toor'
    http:
      baseUri: http://localhost:8080/
```
3. Migrate Database

```
make ssh
> ./flow doctrine:migrate
> ./flow user:create --roles Administrator,Editor admin password Admin User
> ./flow kickstart:site --package-key Vendor.Domain.Site --site-name MySite
> ./flow site:create MySite Vendor.Domain.Site
```