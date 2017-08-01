#!/bin/sh

oldIFS=$IFS
IFS=,

for i in $DOMAIN
do
  FOLDER="/etc/letsencrypt/live/$i"
  CHAIN="$FOLDER/chain.pem"
  CRT="$FOLDER/fullchain.pem"
  KEY="$FOLDER/key.pem"
  cp -s $CHAIN $i.chain.pem
  cp -s $CRT $i.crt
  cp -s $KEY $i.key
done
