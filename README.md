# Building your own RootCA

## Table of Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Startup and Shutdown](#startupShutdown)

## Introduction

During the development, you may need to run a webserver in SSL/https mode.   This will require a certificate.  You can obtain an SSL certificate signed by Let's encrypt valid for 3 months and it is free.  However, there is an easy way to create a self-signed certificate with your own RootCA.

This repo will guide you through the process to create your own rootCA and create your own SSL cert signed by you.

## Installation

To start using this repo, follow the following steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/toaigit/selfsigned
   ```

3. Navigate to the project directory:

   ```bash
   cd selfsign
   ```

4. Create your own rootCA.
 
- Before running the script create.RootCA, please update the create.RootCA according to your preference.
  ```bash
     #!/bin/bash
     #  this script create your own RootCA (self-signed).  This will be used
     #  to a self-signed certificate.
     #

     PASSPHRASE=your-screte-passpharse
     DAYS=7300
     CERT=rootCACert.pem
     KEY=rootCAkey.pem

     openssl genrsa -des -out $KEY -passout pass:$PASSPHRASE 2048
     openssl req -x509 -sha256 -new -nodes -key $KEY \
        -days $DAYS -passin pass:$PASSPHRASE \
         -subj "/C=US/ST=CA/O=Stanford University/OU=Enterprise Technology/CN=stanford.edu" \
        -out $CERT

     echo "Validating the Cert....."
     openssl x509 -in $CERT -text -noout | egrep 'Validity|Not Before|Not After|Subject:'
   ```
- Run the following script to generate the RootCA files (key and cert)
   ```bash
   ./create.RootCA
   ```

5. Create a self-signed cert
-  Creating a cert with single sub-domain name (i.e., stories.resourceonline.org)
   ```bash
   ./cert-gen.sh
   ```
6. Creating a self-signed cert with a multi sub-domains (SAN)
   ```bash
   ./gen-scancert.sh
   ```

## Validate Cert and Key
-  You want to valide the certificate file with the certificate key file, all you need is to run the validate-key.sh cripts. 
   ```bash
   ./validate-key.sh
   ```
## Extract the Cert from the website URL.
   ```bash
   ./getCertFromURL.sh
   ```
