docker run --pull always --rm -it                                     \
  -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION \
  -v /var/run/docker.sock:/var/run/docker.sock                        \
  -v $(pwd):/work -w /work                                            \
  integrational/eks-client /bin/bash -c '
    echo Connecting to EKS cluster
    aws eks update-kubeconfig --name gerald-research --region eu-central-1
    echo Using this EKS cluster
    kubectl cluster-info
    exec $SHELL -l
  '