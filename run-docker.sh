#!/bin/bash
set -Eeuo pipefail
cd $(cd "$(dirname "$0")" && pwd) # cd to where this script is located

docker run --pull always -it --rm --name $APP -e SLACK_SIGNING_SECRET -e SLACK_APP_TOKEN -e SLACK_BOT_TOKEN $IMG
