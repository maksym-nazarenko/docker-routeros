Mikrotik RouterOS in container
==============================

The goal of this repository is to provide [RouterOS](https://mikrotik.com/software) installation to be available inside a Docker container.

The necessity originally was dictated by [terraform-provider-mikrotik](https://github.com/ddelnano/terraform-provider-mikrotik) to test code changes against real system.

## Quick start

To use the image, you can either pull it from DockerHub:
```sh
$ docker pull mnazarenko/docker-routeros:latest
```

or build locally with
```sh
$ docker build -t routeros:local .
```

To acces the container via network, run it as:
```sh
$ docker run -d --name routeros -p 127.0.0.1:2222:22 routeros:local
$ ssh -o Port=2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no admin@localhost
```
The credentials in fresh container are: `admin / <empty password>`

## Custom build

Any [available version](https://mikrotik.com/download/archive) of RouterOS can be built locally by providing the version as [build argument](https://docs.docker.com/reference/dockerfile/#arg) to `docker build` command:
```sh
$ docker build --build-arg ROUTEROS_VERSION=7.15.2 -t routeros:local .
```

The default version to build is defined by `ROUTEROS_VERSION` [argument in Dockerfile](./Dockerfile).

## Release process

Releases are fully automated and based on `Git tags`.

Once new `pep440` tag (without `v` prefix) is created, new image is built with RouterOS version equals to the tag value.
