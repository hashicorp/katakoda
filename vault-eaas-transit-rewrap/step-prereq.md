Clone the `vault-guides` repository.

```shell
git clone --depth 1 https://github.com/hashicorp/vault-guides.git
```{{execute}}

This repository contains supporting content for all of the Vault learn guides.
The content specific to this guide can be found within a sub-directory.

Set the working directory to `vault-guides/encryption/vault-transit-rewrap`.

```shell
cd vault-guides/encryption/vault-transit-rewrap
```{{execute}}

Display the contents of the `vault-transit-rewrap` directory.

```shell
tree
```{{execute}}

A MySQL database is required.

Pull a MySQL server image with `docker`.

```shell
docker pull mysql/mysql-server:5.7
```{{execute}}

Create a directory for the demo data.

```shell
mkdir ~/rewrap-data
```{{execute}}

Create a database named `my_app` that sets the root user password to `root` and
adds a user named `vault`.

```shell
docker run --name mysql-rewrap \
    -p 3306:3306 \
    -v ~/rewrap-data/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_ROOT_HOST=% \
    -e MYSQL_DATABASE=my_app \
    -e MYSQL_USER=vault \
    -e MYSQL_PASSWORD=vaultpw \
    -d mysql/mysql-server:5.7
```{{execute}}

The required files are present and the database is available.
