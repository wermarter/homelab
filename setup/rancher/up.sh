#!/bin/bash

# Generate a private key
openssl genpkey -algorithm RSA -out PRIVATE_KEY.pem -pkeyopt rsa_keygen_bits:2048

# Create the OpenSSL configuration file
cat > openssl.cnf <<EOL
[ req ]
default_bits       = 2048
default_md         = sha256
distinguished_name = req_distinguished_name
req_extensions     = req_ext
prompt             = no

[ req_distinguished_name ]
C  = US
ST = California
L  = San Francisco
O  = Example Company
OU = IT Department
CN = rancher.haminhchien.id.vn

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = rancher.haminhchien.id.vn
DNS.2 = gintoki
DNS.3 = gintoki.local
IP.1 = 192.168.1.10
EOL

# Generate the CSR using the private key and configuration file
openssl req -new -key PRIVATE_KEY.pem -out server.csr -config openssl.cnf

# Generate the full chain certificate (self-signed in this case)
openssl x509 -req -days 3650 -in server.csr -signkey PRIVATE_KEY.pem -out FULL_CHAIN.pem -extfile openssl.cnf -extensions req_ext

# Copy the full chain certificate to CA_CERTS.pem (if self-signed, they are the same)
cp FULL_CHAIN.pem CA_CERTS.pem

# Clean up the CSR and configuration file
rm server.csr openssl.cnf

docker run -d --restart=unless-stopped \
  -p 8443:443 \
  -v ./FULL_CHAIN.pem:/etc/rancher/ssl/cert.pem \
  -v ./PRIVATE_KEY.pem:/etc/rancher/ssl/key.pem \
  -v ./CA_CERTS.pem:/etc/rancher/ssl/cacerts.pem \
  --privileged \
  rancher/rancher:latest