#!/bin/bash

# Location of acme.sh directory
ACME="
# FQDN server name
DOMAIN=""
# Password of the JKS
PASSWORD_STORE="changeit"

CERT_P12="/etc/jitsi/videobridge/$DOMAIN.p12"
CERT_JKS="/etc/jitsi/videobridge/$DOMAIN.jks"

CERT_CRT="$ACME/$DOMAIN/fullchain.cer"
CERT_KEY="$ACME/$DOMAIN/$DOMAIN.key"

openssl pkcs12 -export \
	-in $CERT_CRT \
	-inkey $CERT_KEY \
	-passout pass:$PASSWORD_STORE > $CERT_P12
	
keytool -importkeystore \
	-destkeystore $CERT_JKS \
	-srckeystore $CERT_P12 \
	-srcstoretype pkcs12 \
	-noprompt \
	-storepass $PASSWORD_STORE \
	-srcstorepass $PASSWORD_STORE
	
