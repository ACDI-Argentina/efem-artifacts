#!/bin/bash

CONTAINER_NAME="efem-rsk"
IMAGE_NAME="efem/rsk-regtest"

docker run -d --name efem-rsk -p 4444:4444 -p 4445:4445 -p 30305:30305 -v C:\dev\acdi\rsk\database\regtest:/var/lib/rsk/database/regtest efem/rsk-regtest
