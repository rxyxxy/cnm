#!/bin/bash
  
wget https://github.com/rxyxxy/cnm/releases/download/XrayR/XrayR.zip
unzip -o  XrayR.zip && rm -rf XrayR.zip && ls

sed -i "s/SSpanel/$JCNAME/g" config.yml
sed -i "s|http://127.0.0.1:667|$JCAPIHOST|g" config.yml
sed -i "s/123/$JCAPIKEY/g" config.yml
sed -i "s/41/$JCNODEID/g" config.yml


