## About
[Dozzle](https://github.com/amir20/dozzle) is a (3rd-party OSS) Docker container that streams logs from all running containers into a web interface.\
This repository contains a ready-made configuration for Dozzle.

> [!IMPORTANT]
> Dozzle only shows logs from running containers, and has no way of preserving the logs once a container is rebuilt or deleted.

## Installation
Clone this repository, copy the `.env.sample` file, rename to `.env` and specify the password.\
Run with `docker compose up -d`\
Changes to the .env file require a re-build: `docker compose up -d --build`

## Usage
The dashboard is available publicly on port 9999, unless hidden behind a firewall.\
Authenticate using the username `admin` and password that you specified earlier.

## Making changes to the configuration
To specify a new user, add a new block in the `dozzle/users.yml` file, add a new password variable in `.env` and `.env.sample`, expose that variable as a build argument through `services.dozzle.build.args` in the compose file, and finally write another `RUN` command in the Dockerfile to calculate the hash of the new password.

> [!WARNING]
> Take care not to expose passwords by making sure not to reference them in the build stage / Dockerfile, or by utilising a multi-stage build. [More info](https://tsukiyo.io/posts/leaking-docker-secrets/)
