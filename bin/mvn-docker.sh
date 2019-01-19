#!/bin/bash
set -v
docker run -it --rm \
-v "$HOME/.m2":/root/.m2 \
-v "$(pwd)":/usr/src/build \
-v /var/run/docker.sock:/var/run/docker.sock \
-w /usr/src/build \
maven:3.6.0-jdk-8-alpine \
mvn "$@"

