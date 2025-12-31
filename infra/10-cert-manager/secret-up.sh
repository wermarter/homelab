#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Create secret for Cloudflare API Token in cert-manager namespace
# This secret is used by the ClusterIssuer for DNS-01 challenges
kubectl -n cert-manager create secret generic cloudflare-api-token-secret \
  --from-literal=api-token=$(cat $SCRIPT_DIR/CLOUDFLARE_API_TOKEN)
