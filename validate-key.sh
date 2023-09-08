#!/bin/bash
#  Occationally, you have to give the key and cert to someone.  You want to
#  make sure the key is matching the cert.  Otherwise, it is very embarrassed.
#  This script will validate if the key and cert are matching.
#
CERT=$1
KEY=$2

export certmd5=`openssl x509 -noout -modulus -in $CERT | openssl md5`
export keymd5=`openssl rsa -noout -modulus -in $KEY | openssl md5`

set -xv
if [ "$certmd5" == "$keymd5" ] ; then
   echo "Match"
else
   echo "NOT match"
fi
