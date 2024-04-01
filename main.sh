#!/bin/bash

# 设置 nginx 伪装站
rm -rf /usr/share/nginx/*
wget https://gitlab.com/Misaka-blog/xray-paas/-/raw/main/mikutap.zip -O /usr/share/nginx/mikutap.zip
unzip -o "/usr/share/nginx/mikutap.zip" -d /usr/share/nginx/html
rm -f /usr/share/nginx/mikutap.zip

wget -O nginx.conf https://raw.githubusercontent.com/rxyxxy/cnm/main/nginx.conf
mv nginx.conf /etc/nginx/nginx.conf
service nginx start


# wget https://github.com/rxyxxy/cnm/releases/download/XrayR/XrayR.zip
# unzip -o  XrayR.zip && rm -rf XrayR.zip && ls

# sed -i "s/SSpanel/$JCNAME/g" config.yml
# sed -i "s|http://127.0.0.1:667|$JCAPIHOST|g" config.yml
# sed -i "s/123/$JCAPIKEY/g" config.yml
# sed -i "s/41/$JCNODEID/g" config.yml
