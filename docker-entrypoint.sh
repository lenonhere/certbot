#!/bin/sh

oldIFS=$IFS
IFS=,

for i in $DOMAIN
do
  FOLDER="/etc/letsencrypt/live/$i"
  if [ ! -d "$FOLDER" ]; then
    SUBDOMAIN="$SUBDOMAIN -d $i"
  else
    RENEW=$i
  fi
done

echo 'Generating SSL for domains ' $DOMAIN

IFS=$oldIFS

if [ -n "$RENEW" ];then
  certbot renew
  certbot certonly --standalone --preferred-challenges $PORT -d $DOMAIN --agree-tos -m $EMAIL --no-eff-email
else
  certbot certonly --standalone --preferred-challenges $PORT -d $DOMAIN --agree-tos -m $EMAIL --no-eff-email
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
