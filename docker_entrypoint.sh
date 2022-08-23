#! /bin/bash

pip install -e /workspaces/third_party/diplomacy
cd /home/node
python -m diplomacy.server.run --port=8799