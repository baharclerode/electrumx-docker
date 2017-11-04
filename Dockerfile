FROM ubuntu:zesty

RUN apt-get update && \
    apt-get -y install python3.6 \
                       python3.6-dev \
                       python3.6-venv \
                       libleveldb-dev \
                       python3-pip && \
   python3.6 -m pip install aiohttp \
                            pylru \
                            plyvel \
                            irc \
                            x11_hash

VOLUME ["/var/lib/electrumx"]
ENV DB_DIRECTORY=/var/lib/electrumx
ENV ALLOW_ROOT=
ENV DB_ENGINE=leveldb
ENV HOST=
ENV BANNER_FILE=banner.txt

COPY electrumx/* /usr/local/electrumx/

WORKDIR /var/lib/electrumx

ENTRYPOINT ["/usr/bin/python3.6", "/usr/local/electrumx/electrumx_server.py"]
