#!/bin/bash

if [ $# -ne 2 ] ; then
   echo "Usage: $0 hostname portno"
   exit 1
fi

HN=$1
PORTNO=$2
openssl s_client -showcerts -connect $HN:$PORTNO < /dev/null
openssl s_client -showcerts -connect $HN:$PORTNO < /dev/null | sed -n '/BEGIN C/, /END C/p'
