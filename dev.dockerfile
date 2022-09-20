FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y curl git nano wget python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --user-group --uid 1000 node
USER node
WORKDIR /home/node
RUN mkdir -p /home/node/data
RUN chown -R node:node /home/node/data
WORKDIR /home/node/.cache
RUN mkdir -p /home/node/.cache/diplomacy
RUN chown -R node:node /home/node/.cache/diplomacy