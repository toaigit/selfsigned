#!/bin/bash
#  this script validate if the key and cert matching
#
export cert=`openssl x509 -noout -modulus -in cert.crt | openssl md5`
export key=`openssl rsa -noout -modulus -in privkey.txt | openssl md5`

if [ "$cert" == "$key" ] then
	echo "Cert and Key - Match"
else
	echo "Cert and Key - NOT match"
fi

