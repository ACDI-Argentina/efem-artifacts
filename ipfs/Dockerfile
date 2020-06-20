FROM ipfs/go-ipfs:latest
RUN ipfs init
RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
RUN ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST", "OPTIONS"]'
RUN ipfs config --json Gateway.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
RUN ipfs config --json Gateway.HTTPHeaders.Access-Control-Expose-Headers '["Ipfs-Hash"]'
RUN ipfs config --json Gateway.Writable true

