FROM thebedrock.azurecr.io/diplomacy-dev

USER root

RUN mkdir -p /workspaces/third_party/diplomacy
RUN chown -R node:node /workspaces/third_party/diplomacy

USER node
ADD . /workspaces/third_party/diplomacy

CMD ["/workspaces/third_party/diplomacy/docker_entrypoint.sh"]