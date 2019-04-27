FROM python:3.7-alpine3.9 AS builder

RUN apk add --no-cache build-base git
RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community leveldb-dev
RUN pip install aiohttp>=3.3 aiorpcx=0.15.0 pylru plyvel irc x11_hash

RUN git clone https://github.com/kyuupichan/electrumx.git /electrumx
ARG revision=master
WORKDIR /electrumx/
RUN git fetch origin
RUN git checkout --detach $revision

FROM python:3.7-alpine3.9

ENV DB_DIRECTORY=/var/lib/electrumx ALLOW_ROOT=yes DB_ENGINE=leveldb HOST= BANNER_FILE=banner.txt
VOLUME ["$DB_DIRECTORY"]
WORKDIR $DB_DIRECTORY
ENTRYPOINT ["/usr/local/bin/python3.7", "/electrumx/electrumx_server"]

RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community leveldb

COPY --from=builder /electrumx/ /electrumx/
COPY --from=builder /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/
