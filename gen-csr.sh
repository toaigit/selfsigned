#!/bin/bash
#  this script generate a Certificate Signing Request (CSR).

if [ $# -ne 1 ] ; then
   echo "Usage: $0 CN"
   echo "  $0 login.resourceonline.org"
   exit 1
fi

ST=Calinforna
CITY="Palo Alto"
ORG="Stanford University"
OU="University IT"

CERTNAME=$1

openssl req -new -newkey rsa:2048 -nodes -keyout ${CERTNAME}.key -out ${CERTNAME}.csr -subj "/C=US/ST=$ST/L=$CITY/O=$ORG/OU=$OU/CN=$CERTNAME"

ls -l $CERTNAME.*
