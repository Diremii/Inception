# DEV_DOC.md

## Prerequisites

Required software:

* Docker
* Docker Compose
* GNU Make

## Project Configuration

The main configuration files are:

```text
srcs/docker-compose.yml
srcs/.env
```

Service-specific configurations:

```text
srcs/requirements/mariadb/
srcs/requirements/wordpress/
srcs/requirements/nginx/
```

## Building the Project

Build and start:

```bash
make
```

Rebuild:

```bash
make re
```

## Docker Compose Commands

Start manually:

```bash
cd srcs
docker compose up --build
```

Stop:

```bash
docker compose down
```

Check containers:

```bash
docker ps
```

Check logs:

```bash
docker logs mariadb
docker logs wordpress
docker logs nginx
```

## Volumes and Persistence

Persistent data is stored on the host machine:

```text
/home/humontas/data/mariadb
/home/humontas/data/wordpress
```

These directories are mounted into containers using bind mounts.

As a result:

* MariaDB data survives container recreation.
* WordPress files persist between restarts.

## Project Architecture

The infrastructure contains three containers:

* MariaDB
* WordPress (PHP-FPM)
* Nginx

All services communicate through the dedicated Docker network named `inception`.
