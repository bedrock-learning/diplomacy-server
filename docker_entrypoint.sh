#! /bin/bash

pip install -e /workspaces/third_party/diplomacy
cd ~
python -m diplomacy.server.run --port=8799