# rime-docker

[![Build Status](https://travis-ci.org/blue-jam/rime-docker.svg?branch=master)](https://travis-ci.org/blue-jam/rime-docker)

A docker image including [rime](https://github.com/icpc-jag/rime), C++, Java, Kotlin, and Python.

[Docker Hub](https://hub.docker.com/r/bluejamkmy/rime-docker)

## Usage

You may have to run `docker` commands as a super user.

1. Pull `rime-docker` image from Docker Hub.

   ```
   $ docker pull bluejamkmy/rime-docker
   ```

1. Save [`Dockerfile`](Dockerfile.example) in your rime project directory.

   ```Dockerfile
   FROM bluejamkmy/rime-docker

   COPY . /rime_project

   WORKDIR /rime_project
   ```

1. Build a docker image for your project.

   ```
   $ docker build -t myrime .
   ```

1. Run rime command in your container.

   ```
   $ docker run -it --rm myrime rime test
   ```
