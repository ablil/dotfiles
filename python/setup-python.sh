#!/bin/bash

set -e

sudo apt-get install -y python3
sudo apt-get install -y python3-dev
sudo apt-get install -y python3-pip

pip3 install protonvpn-cli --user
pip3 install howdoi --user
pip3 install requests --user
pip3 install bs4 --user

update-alternatives --install /usr/bin/python python $(which python3) 1
update-alternatives --install /usr/bin/pip pip $(which pip3) 1
