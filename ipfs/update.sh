#!/bin/bash
docker exec efem-ipfs ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
docker exec efem-ipfs ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
docker exec efem-ipfs ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
docker exec efem-ipfs ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
docker exec efem-ipfs ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
docker exec efem-ipfs ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST", "OPTIONS"]'
docker exec efem-ipfs ipfs config --json Gateway.HTTPHeaders.Access-Control-Expose-Headers '["Ipfs-Hash"]'
docker exec efem-ipfs ipfs config --json Gateway.Writable true
docker restart efem-ipfs
docker exec efem-ipfs ipfs config show
