#!/bin/bash
PROGRAM_NAME="jige"
PROGRAM_PATH="/usr/local/bin/$PROGRAM_NAME"
SERVICE_NAME="$PROGRAM_NAME.service"
SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME"
DOWNLOAD_URL="https://proxy.166660.xyz/https/raw.githubusercontent.com/rxyxxv/cnm/refs/heads/main/jige"

if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 用户运行此脚本"
  exit 1
fi

# 安装功能
install() {
function exit_script() {
  echo "$1"
  exit 1
}
if ! command -v docker &> /dev/null; then
  exit_script "Docker 未安装。请先安装 Docker 再运行此脚本。"
fi
echo -e "\033[32mDocker 已安装，继续进行安装配置。\033[0m"
echo "SSpanel, NewV2board, PMpanel, Proxypanel, V2RaySocks, GoV2Panel, BunPanel"
read -p "请输入鸡场面板类型: " JCNAME
read -p "请输入鸡场API地址: " JCAPIHOST
read -p "请输入鸡场API KEY: " JCAPIKEY
read -p "请输入节点ID: " JCNODEID
echo -e "\033[33m请输入有效的订阅，否则无法启动服务。列如：http://127.0.0.1:667/api/v1/client/subscribe?token=123\033[0m"
read -p "请输入订阅地址: " sub

if [[ -z "$JCNAME" || -z "$JCAPIHOST" || -z "$JCAPIKEY" || -z "$JCNODEID" || -z "$sub" ]]; then
  exit_script "所有变量都必须提供。请重新运行脚本并提供所有变量。"
fi
docker rm -f Clash_XrayR && \
  docker run -dit --restart=always  --privileged=true -p 1088:2333 \
    -e JCNAME="$JCNAME" \
    -e JCAPIHOST="$JCAPIHOST" \
    -e JCAPIKEY="$JCAPIKEY" \
    -e JCNODEID="$JCNODEID" \
    -e sub="$sub" \
    --name Clash_XrayR rxyxxy/ch:clash_XrayR

echo "Clash_XrayR 容器已启动并运行。"
  wget -q -O "$PROGRAM_PATH" "$DOWNLOAD_URL"

  if [ $? -ne 0 ]; then
    echo "下载失败，退出脚本"
    exit 1
  fi
  chmod +x "$PROGRAM_PATH"
  cat > "$SERVICE_PATH" <<EOF
[Unit]
Description=Jige Program
After=network.target

[Service]
ExecStart=$PROGRAM_PATH
Type=simple
TimeoutSec=30
StandardOutput=journal
StandardError=journal
Environment=ENV_VAR=value

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  systemctl enable "$SERVICE_NAME"
  echo "$PROGRAM_NAME 安装完成，使用$PROGRAM_NAME命令启动"
}

# 卸载功能
uninstall() {
  docker rm -f Clash_XrayR
  systemctl stop "$SERVICE_NAME"
  systemctl disable "$SERVICE_NAME"
  rm -f "$SERVICE_PATH"
  rm -f "$PROGRAM_PATH"
  systemctl daemon-reload

  echo "$PROGRAM_NAME 卸载完成"
}

case "$1" in
  i)
    install
    ;;
  u)
    uninstall
    ;;
  *)
    echo "用法：$0 {i|u}"
    exit 1
    ;;
esac

