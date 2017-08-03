FROM certbot/certbot
MAINTAINER DylanWu

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
