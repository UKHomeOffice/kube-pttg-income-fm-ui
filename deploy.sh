#!/usr/bin/env bash
export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export ENVIRONMENT=${ENVIRONMENT}
export APP=pttg-ip-fm-ui
export KUBE_SERVER=${KUBE_SERVER_DEV}
export KUBE_TOKEN=${KUBE_TOKEN}

cd kd
kd --debug \
   --insecure-skip-tls-verify --timeout 5m0s \
   --file ${ENVIRONMENT}/pttg-ip-fm-ui-deployment.yaml \
   --file ${ENVIRONMENT}/pttg-ip-fm-ui-ingress.yaml \
   --file ${ENVIRONMENT}/pttg-ip-fm-ui-svc.yaml