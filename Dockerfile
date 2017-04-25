
FROM alpine:3.5
MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

ENTRYPOINT ["/start.sh"]
VOLUME /data

ADD addons/nginx-server.conf /etc/nginx/conf.d/default.conf
ADD addons/start.sh /start.sh

# useable for any git references
ENV HUBZILLAVERSION 2.2

ENV HUBZILLAINTERVAL 10
env SERVERNAME 127.0.0.1


RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add \
        bash \
        curl \
        dcron \
        gd \
        nginx \
        openssl \
        php5 \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-json \
        php5-pdo_mysql \
        php5-pdo_pgsql \
        php5-openssl \
        php5-xml \
    && mkdir -p /run/nginx /hubzilla \
    && curl https://codeload.github.com/redmatrix/hubzilla/tar.gz/${HUBZILLAVERSION} | tar -xz --strip-components=1 -C /hubzilla -f - \
    && chown nginx:nginx -R /hubzilla \
    && chmod 0777 /hubzilla \
    && sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/php.ini \
    && chmod u+x /start.sh \
    && echo "*/###HUBZILLAINTERVAL###    *       *       *       *       cd /hubzilla; /usr/bin/php Zotlabs/Daemon/Master.php Cron" > /hubzilla-cron.txt
