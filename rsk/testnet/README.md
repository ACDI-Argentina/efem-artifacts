# RSK Testnet

Configuración de nodo local conectado a la red RSK Testnet.

*Especificaciones*

- Nombre: RSK Testnet
- Nodo público: https://public-node.testnet.rsk.co
- Explorer: https://explorer.testnet.rsk.co
- ID de red: 31
- Sínbolo: RBTC

[Más información](https://developers.rsk.co/rsk/node/install/docker)

## Build

```
docker build -t testnet -f Dockerfile.TestNet .
```

## Run

```
docker run -d --name testnet-node-01  -p 4444:4444 -p 4445:4445 -p 50505:50505 -v C:\dev\acdi\project\efem-artifacts\rsk\testnet\testnet.conf:/etc/rsk/testnet.conf testnet
```

## Test

```
curl http://localhost:4444/ \
  -s \
  -X POST \
  -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
```

