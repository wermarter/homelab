#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# echo -n 'community-crawler' > rabbitmq-password

kubectl -n rabbitmq create secret generic rabbitmq-setup-secret --from-file=$SCRIPT_DIR/rabbitmq-password