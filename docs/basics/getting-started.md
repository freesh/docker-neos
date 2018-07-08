# Getting started

**1. Create project folder and get docker-neos**

```bash
$ mkdir myprojectfolder
$ git clone git@github.com:freesh/docker-neos.git myprojectfolder
$ make setup
```
**2. configure your environment**

- open .env file and change default versions and paths for your needs.

**3. Start docker***

Can take some time on first run for building container images. (prebuild images are available soon as possible)

```
make up
```

**4. Move your project files to /App or create new neos project**

1. Init neos-base-distribution
```bash
$ make ssh
> composer create-project neos/neos-base-distribution .
> cp Configuration/Development/Settings.yaml.example Configuration/Development/Settings.yaml
```

2. Edit credetials in Configuration/Development/Settings.yaml with DB Data from your .env file. And for use with docker, set the http baseUri port.

_Example:_

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
3. Migrate database and import demo site or create an own empty site.

```bash
$ make ssh
> ./flow doctrine:migrate
> ./flow user:create --roles Administrator,Editor admin password Admin User

# import demo site
> ./flow site:import --package-key Neos.Demo

# or create own sitepackage and site
> ./flow kickstart:site --package-key Vendor.Domain.Site --site-name MySite
> ./flow site:create MySite Vendor.Domain.Site
```
**5. Visit http://localhost:8080/**