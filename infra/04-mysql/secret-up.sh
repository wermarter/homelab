#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# echo -n 'random-password' > mysql-root-password
# echo -n 'random-password' > mysql-password

kubectl -n infra create secret generic mysql-setup-secret --from-file=$SCRIPT_DIR/mysql-root-password --from-file=$SCRIPT_DIR/mysql-password