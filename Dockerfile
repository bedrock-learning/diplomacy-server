# Development stage: Assumes the code folder will be mounted in for development purposes.
FROM python:3.7 AS diplomacy-dev
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y curl git nano wget 

# The host machine must have a user with the uid used here, therefore the uid should be
# provided as an arg.  Default is uid 1000.
ARG hostUserId=1000
RUN useradd --create-home --user-group --uid ${hostUserId} node

USER node
RUN mkdir -p /home/node/.cache
RUN chown -R node:node /home/node/.cache
WORKDIR /home/node
RUN mkdir -p /home/node/data
RUN chown -R node:node /home/node/data
WORKDIR /home/node/.cache
RUN mkdir -p /home/node/.cache/diplomacy
RUN chown -R node:node /home/node/.cache/diplomacy
WORKDIR /home/node

USER root
RUN mkdir -p /workspaces/third_party/diplomacy
RUN chown -R node:node /workspaces/third_party/diplomacy
USER node

# Deploy stage - for packaging everything up into a self-contained container for pushing to ACR.
FROM diplomacy-dev AS diplomacy-deploy

USER root

RUN mkdir -p /workspaces/third_party/diplomacy
RUN chown -R node:node /workspaces/third_party/diplomacy

USER node
ADD . /workspaces/third_party/diplomacy

CMD ["/workspaces/third_party/diplomacy/docker_entrypoint.sh"]