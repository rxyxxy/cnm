#!/bin/bash


curl  https://raw.githubusercontent.com/rxyxxy/cnm/main/main.sh | bash

cat config.yml

chmod 777 XrayR

./XrayR --config config.yml
