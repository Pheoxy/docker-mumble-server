# pheoxy/docker-mumble-server

[![GitHub Stars](https://img.shields.io/github/stars/pheoxy/docker-mumble-server.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/pheoxy/docker-mumble-server)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/pheoxy/docker-mumble-server/docker-publish.yml?style=for-the-badge&logo=github&logoColor=ffffff&label=pheoxy&labelColor=555555)](https://github.com/Pheoxy/docker-mumble-server/actions)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pheoxy&message=GitHub%20Package&logo=github)](https://github.com/pheoxy/docker-mumble-server/packages)

![Mumble](https://avatars.githubusercontent.com/u/639008?s=200&v=4)

This repository contains a Docker setup for running a [Mumble](https://www.mumble.info/) server.

Mumble is an open source, low-latency, high quality voice chat software primarily intended for use while gaming.

## Prerequisites

- Docker
- Docker Compose *(Optional)*

## Usage

### docker run

1. Run:

  ```bash
    docker run \
      --name=mumble-server \
      --hostname=mumble-server \
      --publish 64738/tcp \
      --publish 64738/udp \
      --volume config:/config \
      ghcr.io/pheoxy/docker-mumble-server:main
  ```

### Dockerfile

1. Clone this repository:

    ```bash
    git clone https://github.com/Pheoxy/docker-mumble-server.git
    cd docker-mumble-server
    ```

2. Build and start the Docker container using `docker-compose`:

    Create a `docker-compose.yml` file and paste the below and edit to your needs.

    ```yaml
    services:
    mumble-server:
        build:
            context: .
            dockerfile: Dockerfile
        container_name: mumble-server
        hostname: mumble-server
        restart: on-failure
        ports:
            - 64738:64738
            - 64738:64738/udp
            # - 6502:6502
        volumes:
            - ./config:/config

    ```

    ```bash
    docker-compose up -d
    ```

The Mumble server will be accessible at `localhost:64738`.

## Configuration

The Mumble server configuration can be modified by editing the `mumble-server.ini` file in the `config` directory.

The `entrypoint.sh` script will download the latest version of `mumble-server.ini` if none is found for you on starting of the Docker container.

## Volumes

The `config` directory is mounted as a volume in the Docker container. This allows the Mumble server configuration to persist across container restarts and rebuilds.

## Ports

The following ports are exposed:

- `64738/tcp`: Mumble server TCP port
- `64738/udp`: Mumble server UDP port

## Contributing

Please open an issue or submit a pull request if you have any issues or improvements.
