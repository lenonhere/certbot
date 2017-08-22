#!/bin/sh

RENEWED=false
oldIFS=$IFS
IFS=,

echo 'Generating SSL for domains ' $DOMAIN

for i in $DOMAIN
do
  FOLDER="/etc/letsencrypt/live/$i"

  if [ -d "$FOLDER" ]; then
    if [ "$RENEWED" = "false" ]; then
      echo "Renew old certs ..."
      certbot renew
      RENEWED=true
    else
      echo "Skip domain $i"
    fi

  else
    if [ "$USE_SAN" = "true" ]; then
      SAN_DOMAINS="$SAN_DOMAINS -d $i"
    else
      echo "Obtain cert for $i"
      certbot certonly --standalone -n --preferred-challenges $PORT -d $i --agree-tos -m $EMAIL --no-eff-email
    fi
  fi
done


IFS=$oldIFS

if [ -n "$SAN_DOMAINS" ];then
  certbot certonly --standalone -n --preferred-challenges $PORT -d $SAN_DOMAINS --agree-tos -m $EMAIL --no-eff-email
fi


for dir in /etc/letsencrypt/live/*
 do
   if [ -d $dir ]
   then
    CHAIN="${dir}/chain.pem"
    CRT="${dir}/fullchain.pem"
    KEY="${dir}/privkey.pem"
    cp $CHAIN /etc/letsencrypt/${dir##*/}.chain.pem
    cp $CRT /etc/letsencrypt/${dir##*/}.crt
    cp $KEY /etc/letsencrypt/${dir##*/}.key
  fi
done
