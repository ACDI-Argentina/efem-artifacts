#!/bin/bash
IMAGE_NAME="efem/regtest"

cd ./build
docker build . -f Dockerfile.RegTest -t ${IMAGE_NAME}
