#!/bin/sh

oldIFS=$IFS
IFS=,

for i in $DOMAIN
do
  FOLDER="/etc/letsencrypt/live/$i"
  if [ ! -d "$FOLDER" ]; then
    SUBDOMIAN="$SUBDOMIAN -d $i"
  else
    RENEW=$i
  fi
done

echo $RENEW
echo $DOMIAN
echo $SUBDOMIAN

IFS=$oldIFS

if [ -n "$RENEW" ];then
  certbot renew
  certbot certonly --standalone --preferred-challenges $PORT $SUBDOMIAN --agree-tos -m $EMAIL --eff-email
else
  certbot certonly --standalone --preferred-challenges $PORT $SUBDOMIAN --agree-tos -m $EMAIL --eff-email
fi


for dir in /etc/letsencrypt/archive/*
 do
   if [ -d $dir ]
   then
    CHAIN="${dir}/chain1.pem"
    CRT="${dir}/fullchain1.pem"
    KEY="${dir}/privkey1.pem"
    cp -s $CHAIN ${dir}.chain.pem
    cp -s $CRT ${dir}.crt
    cp -s $KEY ${dir}.key
  fi
done

