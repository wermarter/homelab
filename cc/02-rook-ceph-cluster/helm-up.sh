#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PARENT_DIR=$( dirname $SCRIPT_DIR )

helm upgrade --install -n rook-ceph rook-ceph-cluster $SCRIPT_DIR --render-subchart-notes
