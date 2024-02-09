## About
[Dozzle](https://github.com/amir20/dozzle) is a (3rd-party OSS) Docker container that streams logs from all running containers into a web interface.\
This repository contains a ready-made configuration for Dozzle.

> [!IMPORTANT]
> Dozzle only shows logs from running containers, and has no way of preserving the logs once a container is rebuilt or deleted.

## Installation
Clone this repository, copy the `.secrets.sample` directory, rename to `.secrets` and specify the password for admin in the file inside.\
Run with `docker compose up -d`\
Changes to the password file only require re-running the compose: `docker compose down && docker compose up -d`

## Usage
The dashboard is available publicly on port 9999, unless hidden behind a firewall.\
Authenticate using the username `admin` and the password that you specified earlier.

## Making changes to the configuration
### Specify a new user
1) Add a new block in the `dozzle/users.yml` file
2) Create a new txt password file in `.secrets` and `.secrets.sample`
3) In the compose file, define a new `secret`
4) In the compose file, add a new environment variable pointing the path of the password file **inside** the container (`/run/secrets/secret-name`)
5) In the compose file, edit the `command` by duplicating the two lines that hash and insert the password into users.yml

> [!NOTE]
> If variable substitution inside `command` is meant to happen inside the container, a double `&` must be used instead of a single one. Otherwise, it will use the host env variable. Use `docker container inspect` to see the parsed command.

Injection of the secrets works by using `cat` to read from the password file, followed by hashing it, using sed to replace the placeholder hash in `users.yml` and finally running `/dozzle` because the Dozzle image requires it to be called at start. More information about secrets in Docker can found in the [official documentation]([url](https://docs.docker.com/compose/use-secrets/)https://docs.docker.com/compose/use-secrets/).

### Edit the Dockerfile
It shouldn't be necessary to edit the Dockerfile, but information is included for context.\
The Dockerfile uses a [multi-stage build](https://docs.docker.com/build/building/multi-stage/). The official Dozzle image lacks a shell, so its binaries are copied into an Alpine image. This enables the use of `sed` and `cat` in the `command` in the compose file.\
It has the side effect of overriding Dozzle image's entrypoint (a binary called `/dozzle`), which is why the compose `command` must end by invoking `/dozzle`. [Dozzle's repository](https://github.com/amir20/dozzle/blob/master/Dockerfile) was useful in reverse-engineering the entrypoint.
