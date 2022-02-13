#!/bin/bash
set -Eeuo pipefail
cd $(cd "$(dirname "$0")" && pwd) # cd to where this script is located

docker run --pull always --rm -t                                      \
  -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION \
  -e APP -e IMG -e SLACK_SIGNING_SECRET -e SLACK_BOT_TOKEN            \
  -v /var/run/docker.sock:/var/run/docker.sock                        \
  -v $(pwd):/work -w /work                                            \
  integrational/eks-client /bin/bash -c "
    aws eks update-kubeconfig --name $K8S_CLUSTER_NAME --region $K8S_CLUSTER_REGION
    kubectl cluster-info
    ./deploy-to-k8s.sh
  "
