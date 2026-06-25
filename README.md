# README.md

*This project has been created as part of the 42 curriculum by humontas.*

## Description

Inception is a system administration project from the 42 curriculum focused on containerization using Docker.

The goal is to create a small infrastructure composed of multiple isolated services running inside Docker containers. The stack includes:

* Nginx as a web server with TLS support.
* WordPress with PHP-FPM.
* MariaDB as the database server.

The services communicate through a dedicated Docker network and use persistent volumes to preserve data between container restarts.

### Docker and Project Design

This project uses Docker to isolate services and simplify deployment. Each service runs in its own container and communicates with the others through a private Docker network.

#### Virtual Machines vs Docker

Virtual machines emulate an entire operating system and require more resources. Docker containers share the host kernel and are therefore lighter, faster to start, and easier to manage.

#### Secrets vs Environment Variables

Environment variables are convenient for passing configuration values to containers. Docker secrets are more secure because sensitive information is stored separately from the container environment. For this project, environment variables are used to configure the services.

#### Docker Network vs Host Network

A Docker bridge network isolates containers from the host system while allowing controlled communication between services. Host networking removes this isolation and directly exposes services to the host network.

#### Docker Volumes vs Bind Mounts

Docker volumes are managed by Docker and simplify data persistence. Bind mounts directly map host directories into containers, providing easier access to stored data. This project uses bind mounts to persist MariaDB and WordPress data.

## Instructions

### Build and Start

```bash
make
```

### Stop Containers

```bash
make clean
```

### Remove Containers and Volumes

```bash
make fclean
```

### Rebuild Everything

```bash
make re
```

### Website Access

After startup, open:

https://humontas.42.fr

## Resources

### Documentation

* Docker Documentation
* Nginx Documentation
* MariaDB Documentation
* Grademe Inception Guide

### AI Usage

Artificial intelligence tools were used as learning aids during development. They were mainly used for:

* Understanding Docker concepts.
* Debugging configuration issues.
* Reviewing shell scripts.
* Verifying container communication and service configuration.

All implementation decisions, code integration, testing, and validation were performed manually.
