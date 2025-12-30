#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# echo -n 'minioadmin' > LOKI_S3_ACCESS_KEY
# echo -n 'minioadmin' > LOKI_S3_SECRET_KEY

kubectl -n observability create secret generic loki-credentials --from-file=$SCRIPT_DIR/LOKI_S3_ACCESS_KEY --from-file=$SCRIPT_DIR/LOKI_S3_SECRET_KEY
