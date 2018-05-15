FROM python:3.6-alpine3.6 AS builder

RUN apk add --no-cache build-base git
RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing leveldb-dev
RUN pip install aiohttp aiorpcx pylru plyvel irc x11_hash

RUN git clone https://github.com/kyuupichan/electrumx.git /electrumx
WORKDIR /electrumx/
ARG revision=master
RUN git checkout --detach $revision

FROM python:3.6-alpine3.6

ENV DB_DIRECTORY=/var/lib/electrumx ALLOW_ROOT=yes DB_ENGINE=leveldb HOST= BANNER_FILE=banner.txt
VOLUME ["$DB_DIRECTORY"]
WORKDIR $DB_DIRECTORY
ENTRYPOINT ["/usr/local/bin/python3.6", "/electrumx/electrumx_server.py"]

RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing leveldb

COPY --from=builder /electrumx/ /electrumx/
COPY --from=builder /usr/local/lib/python3.6/site-packages/ /usr/local/lib/python3.6/site-packages/
