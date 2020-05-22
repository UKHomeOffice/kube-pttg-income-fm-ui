#!/bin/bash

export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export KUBE_SERVER=${KUBE_SERVER}
export WHITELIST=${WHITELIST:-0.0.0.0/0}
export DEPLOYMENT_NAME=${DEPLOYMENT_NAME:-pttg-ip-fm-ui}

if [[ -z ${VERSION} ]] ; then
    export VERSION=${IMAGE_VERSION}
fi

if [[ ${ENVIRONMENT} == "pr" ]] ; then
    export KUBE_TOKEN=${PTTG_IP_PR}
    export DNS_PREFIX=
    export KC_REALM=pttg-production
    export CERT_ISSUER=letsencrypt-prod
else
    export KUBE_TOKEN=${PTTG_IP_DEV}
    export DNS_PREFIX=${ENVIRONMENT}.notprod.
    export KC_REALM=pttg-qa
    export CERT_ISSUER=letsencrypt-staging
fi

export DOMAIN_NAME=ip.${DNS_PREFIX}pttg.homeoffice.gov.uk

echo "deploy ${VERSION} to ${ENVIRONMENT} namespace - using Kube token stored as drone secret"
echo "KC_REALM is $KC_REALM"
echo "CERT_ISSUER is $CERT_ISSUER"
echo "DOMAIN_NAME is $DOMAIN_NAME"
echo "DEPLOYMENT_NAME is $DEPLOYMENT_NAME"

cd kd || exit

kd --insecure-skip-tls-verify \
    -f ingress-certificate.yaml \
    -f pod-to-pod-server-certificate.yaml \
    -f networkPolicy.yaml \
    -f ingress.yaml \
    -f deployment.yaml \
    -f service.yaml
