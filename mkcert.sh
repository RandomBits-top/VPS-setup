#!/bin/sh
### EDIT THESE NEXT COUPLE LINES ###
ROOTDOMAIN="domain.example.com"
SUBJ="/C=US/ST=CA/L=NA/O=NA/OU=NA"


### SHOULD NOT NEEd TO EDIT ###
#USAGE
DOMAIN=$1
if [ -z $DOMAIN ]
then
  echo Usage: $0 [domain]
  exit
fi

#ADD CN TO SUBJ
ROOTSUBJ="$SUBJ/CN=$ROOTDOMAIN"
CERTSUBJ=""$SUBJ/CN=$DOMAIN"

#CHECK FOR STORED PASSWORD
if [ ! -f .password ]
then
        PASSWORD=$(openssl rand -base64 16)
        echo $PASSWORD > .password
fi

#CHECK IF ROOT CA CERT EXISTS AND CREATE IF IT DOES NOT
if [ ! -f myCA.key ]
then
  openssl genrsa -des3 -passout file:.password -out myCA.key 2048
  openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem -subj "$ROOTSUBJ" -passin file:.password
fi

### Create and Sign CERT ###
openssl genrsa -out $DOMAIN.key 2048
openssl req -new -key $DOMAIN.key -out $DOMAIN.csr -subj "$CERTSUBJ"

cat << EOF > $DOMAIN.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in $DOMAIN.csr -CA myCA.pem -CAkey myCA.key -passin file:.password -CAcreateserial -out $DOMAIN.crt -days 825 -sha256 -extfile $DOMAIN.ext

openssl x509 -in $DOMAIN.crt -text -noout

ls -l $DOMAIN.*

