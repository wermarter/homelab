#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# echo -n 'admin' > HARBOR_ADMIN_PASSWORD

kubectl -n infra create secret generic harbor-credentials --from-file=$SCRIPT_DIR/HARBOR_ADMIN_PASSWORD
