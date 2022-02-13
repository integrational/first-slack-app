#!/bin/bash
set -Eeuo pipefail
cd $(cd "$(dirname "$0")" && pwd) # cd to where this script is located

echo img1 $IMG
./build-node.sh
echo img4 $IMG
docker build -t $IMG .
echo img5 $IMG
