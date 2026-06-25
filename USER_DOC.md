# USER_DOC.md

## Overview

This stack provides:

* Nginx web server with HTTPS.
* WordPress website.
* MariaDB database server.

## Starting the Project

From the repository root:

```bash
make
```

## Stopping the Project

```bash
make clean
```

## Removing Containers and Volumes

```bash
make fclean
```

## Accessing the Website

Open:

https://humontas.42.fr

## Accessing WordPress Administration

Open:

https://humontas.42.fr/wp-admin

Log in using the administrator account configured in the `.env` file.

## Credentials

Credentials are stored in:

```text
srcs/.env
```

The file contains database credentials and WordPress user accounts.

## Verifying Services

Check running containers:

```bash
docker ps
```

View logs:

```bash
docker logs mariadb
docker logs wordpress
docker logs nginx
```

The three services should be running without restart loops or errors.
