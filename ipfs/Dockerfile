FROM ipfs/go-ipfs:latest

RUN ipfs init \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]' \
    && ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Origin '["*"]' \
    && ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST", "OPTIONS"]' \
    && ipfs config --json Gateway.HTTPHeaders.Access-Control-Expose-Headers '["Ipfs-Hash"]' \
    && ipfs config --json Gateway.Writable true 
