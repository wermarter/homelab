#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kubectl=/snap/bin/kubectl

helm uninstall -n cert-manager cert-manager
# $kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.5/cert-manager.crds.yaml


