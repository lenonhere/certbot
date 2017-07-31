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
else
  certbot certonly --standalone --preferred-challenges $PORT $SUBDOMIAN --agree-tos -m $EMAIL --eff-email
fi
