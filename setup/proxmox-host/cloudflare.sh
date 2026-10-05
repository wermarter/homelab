#!/bin/bash

# crontab -e
# */15 * * * * /root/cloudflare.sh

# Cloudflare API token with DNS read/edit permission for this zone.
# CHANGE THESE VALUES
auth_token="xxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Domain and DNS record for synchronization
zone_identifier="f1nd7h3fuck1n6z0n31d3n71f13r4l50"
record_name="ipv4.example.org"

set -uo pipefail

if [[ -z "$auth_token" || "$auth_token" == xxxx-* ]]; then
  echo "Set auth_token near the top of this script before running it." >&2
  exit 1
fi
if [[ ! "$record_name" =~ ^[A-Za-z0-9.-]+$ ]]; then
  echo "record_name must be a valid hostname." >&2
  exit 1
fi

is_ipv4() {
  local candidate="$1" octet
  local -a octets

  [[ "$candidate" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]] || return 1
  IFS='.' read -r -a octets <<< "$candidate"
  for octet in "${octets[@]}"; do
    (( 10#$octet <= 255 )) || return 1
  done
}

# Extract simple, unescaped JSON string values without external parsers.
json_string() {
  local json="$1" key="$2" regex
  regex="\"${key}\"[[:space:]]*:[[:space:]]*\"([^\"]*)\""
  if [[ "$json" =~ $regex ]]; then
    printf '%s' "${BASH_REMATCH[1]}"
  else
    return 1
  fi
}

json_success() {
  local regex='"success"[[:space:]]*:[[:space:]]*true([^a-zA-Z0-9_]|$)'
  [[ "$1" =~ $regex ]]
}

report_api_error() {
  local status="$1" body="$2" message
  if message=$(json_string "$body" message) && [[ -n "$message" ]]; then
    printf 'Cloudflare API request failed (HTTP %s): %s\n' "$status" "$message" >&2
  else
    printf 'Cloudflare API request failed (HTTP %s); response was not a recognized success.\n' "$status" >&2
  fi
}

api_request() {
  local method="$1" url="$2" payload="${3:-}"
  local response status body
  local -a curl_args=(
    --silent --show-error --ipv4 --max-time 30
    --request "$method"
    --header "Authorization: Bearer ${auth_token}"
    --header 'Content-Type: application/json'
  )

  if [[ -n "$payload" ]]; then
    curl_args+=(--data "$payload")
  fi
  if ! response=$(curl "${curl_args[@]}" --write-out $'\n%{http_code}' "$url"); then
    echo "Network error while calling the Cloudflare API." >&2
    return 1
  fi

  status="${response##*$'\n'}"
  body="${response%$'\n'*}"
  if [[ ! "$status" =~ ^2[0-9][0-9]$ ]]; then
    report_api_error "$status" "$body"
    return 1
  fi
  printf '%s' "$body"
}

echo "Check initiated"

if ! ip=$(curl --silent --show-error --fail --ipv4 --max-time 15 https://icanhazip.com/); then
  echo "Network error: cannot fetch external IP." >&2
  exit 1
fi
ip=${ip//$'\r'/}
ip=${ip//$'\n'/}
if ! is_ipv4 "$ip"; then
  echo "Invalid IPv4 address returned by the IP service." >&2
  exit 1
fi
echo "  > Fetched current external network IP: ${ip}"

records_json=$(api_request GET "https://api.cloudflare.com/client/v4/zones/${zone_identifier}/dns_records?name=${record_name}&type=A") || exit 1
if ! json_success "$records_json"; then
  report_api_error "200" "$records_json"
  exit 1
fi

empty_result_regex='"result"[[:space:]]*:[[:space:]]*\[[[:space:]]*\]'
if [[ "$records_json" =~ $empty_result_regex ]]; then
  echo "DNS record does not exist; create it first." >&2
  exit 1
fi

# Refuse ambiguous responses rather than updating an arbitrary matching record.
remaining="$records_json"
id_regex='"id"[[:space:]]*:[[:space:]]*"[^"]+"'
record_count=0
while [[ "$remaining" =~ $id_regex ]]; do
  ((record_count += 1))
  match="${BASH_REMATCH[0]}"
  remaining="${remaining#*"$match"}"
done
if (( record_count != 1 )); then
  printf 'Expected exactly one matching A record; found %s.\n' "$record_count" >&2
  exit 1
fi

if ! record_identifier=$(json_string "$records_json" id) || [[ -z "$record_identifier" ]]; then
  echo "Could not parse the DNS record ID from Cloudflare's response." >&2
  exit 1
fi
if ! old_ip=$(json_string "$records_json" content) || ! is_ipv4 "$old_ip"; then
  echo "Could not parse a valid IPv4 address from Cloudflare's DNS record." >&2
  exit 1
fi
echo "  > Fetched current DNS record value: ${old_ip}"

if [[ "$ip" == "$old_ip" ]]; then
  echo "Update for A record '${record_name} (${record_identifier})' cancelled: IP has not changed."
  exit 0
fi

echo "  > Different IP addresses detected, synchronizing..."
printf -v payload '{"type":"A","name":"%s","content":"%s","ttl":120,"proxied":false}' "$record_name" "$ip"
update_json=$(api_request PUT "https://api.cloudflare.com/client/v4/zones/${zone_identifier}/dns_records/${record_identifier}" "$payload") || exit 1
if ! json_success "$update_json"; then
  report_api_error "200" "$update_json"
  exit 1
fi
if ! updated_ip=$(json_string "$update_json" content) || [[ "$updated_ip" != "$ip" ]]; then
  echo "Cloudflare did not confirm the requested DNS value in its response." >&2
  exit 1
fi

echo "Update for A record '${record_name} (${record_identifier})' succeeded."
echo "  - Old value: ${old_ip}"
echo "  + New value: ${ip}"
