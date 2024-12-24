#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PARENT_DIR=$( dirname $SCRIPT_DIR )


kubectl=/snap/bin/kubectl

helm upgrade --install -n longhorn-system --create-namespace longhorn $SCRIPT_DIR --render-subchart-notes