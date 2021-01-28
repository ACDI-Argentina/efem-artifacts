#!/bin/bash

IMG_TAG=v1.0.0-beta.1

SERVICE_NAME=efem-feathers
IMAGE_NAME=acdi/give4forests-feathers

docker-compose -f docker-compose.yml -f docker-compose.development.yml build ${SERVICE_NAME}

docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${IMG_TAG}

docker push ${IMAGE_NAME}:${IMG_TAG}
docker push ${IMAGE_NAME}:latest

