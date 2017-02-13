#!/usr/bin/env bash

DOCKER_REGISTRY="does-not-exist"
SERVICE_NAME="grpc-hybrid"

if [ $# -eq 0 ]
  then
    echo "missing argument 1 (buildNumber)!"
    exit 1;
fi

echo "running ./Dockerfile"

docker run -it -p 8080:8080 "${DOCKER_REGISTRY}/${SERVICE_NAME}:${1}"