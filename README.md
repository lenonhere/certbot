Simple-Certbot for HyperAPP
======

Simple-Certbot is a application to simplify the process of applying for a certificate based on docker.

## docker-compose.yml

```yaml
ocserv:
  image: hyperapp/certbot
  ports:
    - "80:80/tcp"
    - "443:443/tcp"
  environment:
    - DOMAIN=easypi.info,blog.easypi.info
    - EMAIL=admin@easypi.info
    - PORT=http
    #- PORT=tls-sni
```

> - :warning: Please choose the port 80 or 443 in order to perform domain validation.
> - For multiple domains you should use a comma separated list of domains as a parameter.
> - If you choose "tls-sni" in $PORT, you should expose port 443, Corresponding, if you choose "http" in $PORT, you should expose port 80.
