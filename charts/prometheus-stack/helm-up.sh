#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm upgrade --install --create-namespace -n observability prometheus-stack $SCRIPT_DIR --render-subchart-notes
