#!/bin/sh

locale-gen en_US.UTF-8

DEBIAN_FRONTEND=noninteractive
apt-get install -y --no-install-recommends \
python3 python3-dev python3-pip python3-lxml \
build-essential libffi-dev git \
libtiff5-dev libjpeg8-dev zlib1g-dev \
libfreetype6-dev liblcms2-dev libwebp-dev \
curl libfontconfig npm daemon
apt-get clean

npm install -g n npm grunt-cli && n lts

#superdesk server
mkdir /opt/superdesk/
cp -r /mnt/superdesk/server/. /opt/superdesk/
cd /opt/superdesk/
pip3 install virtualenv
virtualenv env
. env/bin/activate
pip3 install -U -r /opt/superdesk/requirements.txt

#superdesk client
cp -r /mnt/superdesk/client/ /opt/superdesk/
cd /opt/superdesk/client
npm install && grunt build

#superdesk-content-api
mkdir /opt/superdesk-content-api
cp -r /mnt/superdesk-content-api/. /opt/superdesk-content-api/
cd /opt/superdesk-content-api/
virtualenv env
. env/bin/activate
pip3 install -U -r /opt/superdesk-content-api/requirements.txt
