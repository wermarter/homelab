#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# echo -n 'admin' > TEMPO_S3_ACCESS_KEY
# echo -n 'admin' > TEMPO_S3_SECRET_KEY

kubectl -n observability create secret generic tempo-credentials --from-file=$SCRIPT_DIR/TEMPO_S3_ACCESS_KEY --from-file=$SCRIPT_DIR/TEMPO_S3_SECRET_KEY
