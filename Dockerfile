# Development stage: Assumes the code folder will be mounted in for development purposes.
FROM ubuntu:latest AS diplomacy-dev
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y curl git nano wget python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*



# Deploy stage - for packaging everything up into a self-contained container for pushing to ACR.
FROM diplomacy-dev AS diplomacy-deploy

USER root
RUN useradd --create-home --user-group --uid 1000 node

USER node
WORKDIR /home/node
RUN mkdir -p /home/node/data
RUN chown -R node:node /home/node/data
WORKDIR /home/node/.cache
RUN mkdir -p /home/node/.cache/diplomacy
RUN chown -R node:node /home/node/.cache/diplomacy

RUN mkdir -p /workspaces/third_party/diplomacy
RUN chown -R node:node /workspaces/third_party/diplomacy

USER node
ADD . /workspaces/third_party/diplomacy

CMD ["/workspaces/third_party/diplomacy/docker_entrypoint.sh"]