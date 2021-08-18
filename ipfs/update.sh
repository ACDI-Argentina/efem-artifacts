#!/bin/bash
CONTAINER_NAME=ipfs

docker exec ${CONTAINER_NAME} ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
docker exec ${CONTAINER_NAME} ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
docker exec ${CONTAINER_NAME} ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
docker exec ${CONTAINER_NAME} ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
docker exec ${CONTAINER_NAME} ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
docker exec ${CONTAINER_NAME} ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST", "OPTIONS"]'
docker exec ${CONTAINER_NAME} ipfs config --json Gateway.HTTPHeaders.Access-Control-Expose-Headers '["Ipfs-Hash"]'
docker exec ${CONTAINER_NAME} ipfs config --json Gateway.Writable true

docker exec ${CONTAINER_NAME} ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://localhost:3000", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
docker exec ${CONTAINER_NAME} ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'

docker restart ${CONTAINER_NAME}
docker exec ${CONTAINER_NAME} ipfs config show
