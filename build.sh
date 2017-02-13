#!/usr/bin/env bash

DOCKER_REGISTRY="does-not-exist"
SERVICE_NAME="grpc-hybrid"

if [ $# -eq 0 ]
  then
    echo "missing argument 1 (buildNumber)!"
    exit 1;
fi

echo "building (and pushing) ./Dockerfile"

docker build -t "${DOCKER_REGISTRY}/${SERVICE_NAME}:${1}" --no-cache --pull .