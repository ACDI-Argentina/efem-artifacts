#!/bin/bash
IMAGE_NAME="efem/regtest"

docker build . -f Dockerfile.RegTest -t ${IMAGE_NAME}
