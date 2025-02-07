FROM alpine

ARG ISSO_VER=0.12.5

ENV GID=1000 UID=1000
RUN apk -U upgrade \
 && apk add -t build-dependencies \
    python3-dev \
    libffi-dev \
    build-base \
 && apk add \
    python3 \
    sqlite \
    openssl \
    ca-certificates \
    su-exec \
    tini
RUN apk add py3-setuptools py3-webencodings py3-pip
RUN pip3 install wheel
RUN pip3 install --no-cache "isso" \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 8080

VOLUME /db /config

CMD ["run.sh"]
