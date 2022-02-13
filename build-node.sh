#!/bin/bash
set -Eeuo pipefail
cd $(cd "$(dirname "$0")" && pwd) # cd to where this script is located

echo img2 $IMG
npm install
echo img3 $IMG
