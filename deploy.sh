#!/usr/bin/env bash
env
export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export ENVIRONMENT=${ENVIRONMENT}
export KUBE_SERVER=${KUBE_SERVER}
export KUBE_TOKEN=${KUBE_TOKEN}
export WHITELIST=${WHITELIST:-0.0.0.0/0}
echo "reset vars"
env
echo "KUBE_TOKEN token is $KUBE_TOKEN"
echo "PROD_KUBE_TOKEN token is $PROD_KUBE_TOKEN"

if [ $ENVIRONMENT == "prod" ]
then
    export DNS_PREFIX=
else
    export DNS_PREFIX=${ENVIRONMENT}.
fi

cd kd
kd --debug \
   --insecure-skip-tls-verify --timeout 5m0s \
   --file ingress.yaml \
   --file service.yaml \
   --file deployment.yaml