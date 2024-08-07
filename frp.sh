#!/bin/bash

wget https://chmlfrp.cn/dw/ChmlFrp-0.51.2_linux_amd64.tar.gz
tar xzf ChmlFrp-0.51.2_linux_amd64.tar.gz && rm -rf ChmlFrp-0.51.2_linux_amd64.tar.gz

cd frp_ChmlFrp-0.51.2_linux_amd64 && rm -rf frpc.ini

tee frpc.ini << EOF
[common]
server_addr = $IP
server_port = 7000
tls_enable = false
user = YPKKTELKHIpy23ZIVKOLrhVt
token = ChmlFrpToken

[6r7iMisH]
type = tcp
local_ip = 127.0.0.1
local_port = 443
remote_port = $PORT
EOF

chmod +x frpc && ./frpc &
