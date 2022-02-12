#!/bin/bash
set -Eeuo pipefail

# these env vars must be set
if [ -z "$SLACK_SIGNING_SECRET" ]; then
    echo "Must set SLACK_SIGNING_SECRET environment variable" 1>&2
    exit 1
fi
if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "Must set SLACK_BOT_TOKEN environment variable" 1>&2
    exit 1
fi
if [ -z "$IMG" ]; then
    echo "Must set IMG environment variable" 1>&2
    exit 1
fi

scriptdir="$(cd "$(dirname "$0")" && pwd)"

cd $scriptdir

echo $'\nDeploying via plain Kubernetes resources to Kubernetes cluster\n'
# don't kubectl-apply the resources file directly, but instead
# first use sed to replace placeholder template vars {{var}} with actual secret values from env vars,
# only then kubectl-apply
cat k8s-resources.yaml                                              \
  | sed -e 's,{{SLACK_SIGNING_SECRET}},'"$SLACK_SIGNING_SECRET"',g' \
        -e 's,{{SLACK_BOT_TOKEN}},'"$SLACK_BOT_TOKEN"',g'           \
        -e 's,{{IMG}},'"$IMG"',g'                                   \
  | kubectl apply -f -
# trigger rollout (necessary because using image tag "latest" in Deployment's pod template, so the above apply only triggers a rollout upon creation but not upon update)
kubectl rollout restart -n first-slack-app deployment/first-slack-app
