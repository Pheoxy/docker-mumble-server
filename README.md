# pheoxy/docker-mumble-server

[![GitHub Stars](https://img.shields.io/github/stars/pheoxy/docker-mumble-server.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/pheoxy/docker-mumble-server)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/pheoxy/docker-mumble-server/docker-publish.yml?style=for-the-badge&logo=github&logoColor=ffffff&label=pheoxy&labelColor=555555)](https://github.com/Pheoxy/docker-mumble-server/actions)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pheoxy&message=GitHub%20Package&logo=github)](https://github.com/pheoxy/docker-mumble-server/packages)

![Mumble](https://avatars.githubusercontent.com/u/639008?s=200&v=4)

## Overview

This repository provides a Docker setup for running a [Mumble](https://www.mumble.info/) server. Mumble is an open-source, low-latency, high-quality voice chat software primarily intended for use while gaming.

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/) *(Optional but recommended)*

## Getting Started

### Using `docker run`

1. **Run the Mumble Server Container:**

    ```bash
    docker run \
      --name=mumble-server \
      --hostname=mumble-server \
      --publish 64738:64738/tcp \
      --publish 64738:64738/udp \
      --publish 6502:6502/tcp \ # Optional: Enable Ice on port 6502
      --volume config:/config \
      ghcr.io/pheoxy/docker-mumble-server:main
    ```

### Using Docker Compose

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/Pheoxy/docker-mumble-server.git
    cd docker-mumble-server
    ```

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
            - 64738:64738/tcp
            - 64738:64738/udp
            - 6502:6502/tcp # Optional: Enable Ice on port 6502
        volumes:
            - ./config:/config

    ```

2. **Create a `docker-compose.yml` File:**

    If you haven't cloned the repository, you can create a `docker-compose.yml` file with the following content:

    ```yaml
    services:
      mumble-server:
        image: ghcr.io/pheoxy/docker-mumble-server:main
        container_name: mumble-server
        hostname: mumble-server
        restart: unless-stopped
        ports:
          - 64738:64738/tcp
          - 64738:64738/udp
          - 6502:6502/tcp # Optional: Enable Ice on port 6502
        volumes:
          - ./config:/config
    ```

3. **Start the Container:**

    ```bash
    docker-compose up -d
    ```

4. **Verify the Setup:**

    Ensure the container is running:

    ```bash
    docker-compose ps
    ```

    You should see the `mumble-server` service listed and running.

## Access the Server

The Mumble server will be accessible at `localhost:64738`.

## Configuration

- **Configuration File:**

  The Mumble server configuration is managed via the `mumble-server.ini` file located in the `config` directory.

- **Initial Setup:**

  On the first run, the `entrypoint.sh` script will download the latest version of `mumble-server.ini` if none is found in the `config` directory.

- **Customizing Settings:**

  Edit the `config/mumble-server.ini` file to customize server settings such as server name, password, and other preferences.

## Volumes

The `config` directory is mounted as a volume in the Docker container. This allows the Mumble server configuration to persist across container restarts and rebuilds.

## Ports

The following ports are exposed:

- `64738/tcp`: Mumble server TCP port
- `64738/udp`: Mumble server UDP port
- `6502/tcp`: (Optional) Used for Ice (Interactive Connectivity Establishment) services.

## Ice for Mumble

Ice (Interactive Connectivity Establishment) is used in Mumble for remote administration and monitoring. Enabling Ice allows administrators to manage the Mumble server remotely using compatible clients or scripts.

## Contributing

Please open an issue or submit a pull request if you have any issues or improvements.
