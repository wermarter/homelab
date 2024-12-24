#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kubectl=/snap/bin/kubectl

helm upgrade --install --create-namespace -n infra minio $SCRIPT_DIR --render-subchart-notes