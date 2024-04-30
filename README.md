# Mumble Server Docker Setup

This repository contains a Docker setup for running a [Mumble](https://www.mumble.info/) server.

Mumble is an open source, low-latency, high quality voice chat software primarily intended for use while gaming.

## Prerequisites

- Docker
- Docker Compose *(Optional)*

## Usage

1. Clone this repository:

    ```bash
    git clone https://github.com/yourusername/docker-mumble-server.git
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
