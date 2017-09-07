#!/usr/bin/env bash
env
export WHITELIST=${WHITELIST:-0.0.0.0/0}
export KUBE_TOKEN=${PTTG_KUBE_TOKEN}

env
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