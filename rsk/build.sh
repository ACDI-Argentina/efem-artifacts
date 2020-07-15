#!/bin/bash
IMAGE_NAME="efem/rsk-regtest"

docker build . -f Dockerfile.RegTest -t ${IMAGE_NAME}
