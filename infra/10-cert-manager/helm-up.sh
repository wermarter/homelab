#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm upgrade --wait --install -n cert-manager --create-namespace cert-manager $SCRIPT_DIR --render-subchart-notes

kubectl apply -f $SCRIPT_DIR/cluster-issuer.yaml\
