#!/bin/bash
#  Script to create a self-signed certficate with your own ROOT CA 
#  get the passphrase for the cert's key and RootCA's key

#  the dot.password should have two variables PASSPHRASE and CA_PASSPHRASE.
#  THE PASSPHRASE is the passphrase for the certificate private key
#  The CA_PASSPHRASE is the passphrase of the RootCA.

. ./dot.password

#  these are the files that will be created.  Please update the following
#  variables to fit your environment

export OUTDIR=output
export PKEY=$OUTDIR/dsPrivateKey.key
export CERT=$OUTDIR/dsCert.pem
export CERTNP=$OUTDIR/dsCertNP.pem
export CSR=$OUTDIR/dsCert.csr
export CHAINFILE=$OUTDIR/dsChain.pem

#  these are the files that should be exist already.  Please update the
#  following variables to fit your environment. 
#  See create.RootCA to create RootCA if you don't have one yet
export CAKEY=myCAPrivateKey.key
export CACERT=myCACertificate.pem

#  Please update this SAN.cnf file to fit your environment
export SANSCONF=SAN.cnf

mkdir -p $OUTDIR

if [ ! -f $SANSCONF ] ; then
   echo "The openssl configuration file $SANSCONF doesn't exist."
   exit 1
fi

echo "Generate Private Key..."
openssl genrsa -des -out $PKEY -passout pass:$PASSPHRASE 2048
echo "Generate Private Key - DONE"
sleep 2

echo "Generate CSR ..."
openssl req -new -key $PKEY -out $CSR -passin pass:$PASSPHRASE -config SAN.cnf
echo "Generate CSR - DONE"
sleep 2

echo "Generate Self-Sign Cert..."
openssl x509 -req -in $CSR -sha256 -passin pass:$CA_PASSPHRASE \
        -CA $CACERT -CAkey $CAKEY \
        -extensions v3_req -extfile SAN.cnf \
        -CAcreateserial \
        -out $CERT -days 730
echo "Generate CSR $CSR - DONE"
sleep 2

echo "Remove the certificate's key passphrase $CERTNP..."
openssl rsa -in $PKEY -out $CERTNP -passin pass:$PASSPHRASE
echo "Remove the certificate's key passphrase $CERTNP... - DONE"
sleep 2

echo "Create the chain file ..."
cat $CERT $CACERT > $CHAINFILE
echo "Create the chain file $CHAINFILE - DONE"
sleep 2

#  These are options steps
#  echo "Copy files to $OSERVER server ..."
#export SUCERT_DIR=dest-dir-path
#export OSERVER=otherServersName
#scp -p $PKEY $OSERVER:$SUCERT_DIR
#scp -p $CERT $OSERVER:$SUCERT_DIR
#scp -p $CACERT $OSERVER:$SUCERT_DIR

echo "DONE. DONE. DONE"
