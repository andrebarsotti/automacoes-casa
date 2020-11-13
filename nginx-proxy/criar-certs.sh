#!/bin/bash

if [ "$#" -ne 1 ]
then
  echo "Usage: Must supply a domain"
  exit 1
fi

ROOTCERT="rootCA"
DOMAIN=$1

openssl genrsa -out certs/$DOMAIN.key 2048
openssl req -new -key certs/$DOMAIN.key -out certs/$DOMAIN.csr -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=Andre Salvadeo/CN=$ROOTCERT"

cat > certs/$DOMAIN.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in certs/$DOMAIN.csr -CA certs/$ROOTCERT.crt -CAkey certs/$ROOTCERT.key -CAcreateserial \
-out certs/$DOMAIN.crt -days 825 -sha256 -extfile certs/$DOMAIN.ext

docker-compose restart
