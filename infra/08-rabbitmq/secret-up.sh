#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# echo -n 'password' > rabbitmq-password

kubectl -n infra create secret generic rabbitmq-setup-secret --from-file=$SCRIPT_DIR/rabbitmq-password

