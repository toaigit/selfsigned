#!/bin/bash
#   Script to generate a self-signed certificate 
#
if [ $# -ne 1 ] ; then
   echo "Usage: $0 sitename"
   echo "i.e., $0 ee.stanford.edu"
   exit 1
fi

sitename=$1
YEARS=10 
#  Modify for your company/organization
country=US
state=California
locality="Palo Alto"
organization="Stanford University"
organizationalunit="Administrative Systems"
 
#  we skip generating the key since we will use one step method
#openssl genrsa -out $sitename.key 2048 -noout
 
#  we skip creating the Certificate request since we will use one step method
#openssl req -new -key $sitename.key -out $sitename.csr -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$sitename"

#  we generate both key and cert in one step
openssl req -new -x509 -sha256 -days $YEARS -nodes -out $sitename.crt -keyout $sitename.key  -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$sitename"

#  Decode the cert to validate
openssl x509 -in $sitename.crt -text -noout

echo "the key is $sitename.key and the cert is $sitename.crt"
