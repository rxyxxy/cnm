#!/bin/bash

PROGRAM_NAME="jige"
PROGRAM_PATH="/usr/local/bin/$PROGRAM_NAME"
SERVICE_NAME="$PROGRAM_NAME.service"
SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME"
DOWNLOAD_URL="https://proxy.166660.xyz/https/raw.githubusercontent.com/rxyxxv/cnm/refs/heads/main/jige"  # 替换为实际下载链接

# 确保脚本以 root 权限运行
if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 用户运行此脚本"
  exit 1
fi

# 安装功能
install() {

# 退出脚本的错误处理函数
function exit_script() {
  echo "$1"
  exit 1
}

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
  exit_script "Docker 未安装。请先安装 Docker 再运行此脚本。"
fi

echo -e "\033[32mDocker 已安装，继续进行安装配置。\033[0m"

# 提示用户输入环境变量
echo "SSpanel, NewV2board, PMpanel, Proxypanel, V2RaySocks, GoV2Panel, BunPanel"
read -p "请输入鸡场面板类型: " JCNAME
read -p "请输入鸡场API地址: " JCAPIHOST
read -p "请输入鸡场API KEY: " JCAPIKEY
read -p "请输入节点ID: " JCNODEID
echo -e "\033[33m请输入有效的订阅，否则无法启动服务。列如：http://127.0.0.1:667/api/v1/client/subscribe?token=123\033[0m"
read -p "请输入订阅地址: " sub

# 检查用户是否输入了必需的变量
if [[ -z "$JCNAME" || -z "$JCAPIHOST" || -z "$JCAPIKEY" || -z "$JCNODEID" || -z "$sub" ]]; then
  exit_script "所有变量都必须提供。请重新运行脚本并提供所有变量。"
fi

# 运行 Docker 容器
docker run -dit --restart=always  --privileged=true -p 1088:2333 \
  -e JCNAME="$JCNAME" \
  -e JCAPIHOST="$JCAPIHOST" \
  -e JCAPIKEY="$JCAPIKEY" \
  -e JCNODEID="$JCNODEID" \
  -e sub="$sub" \
  --name Clash_XrayR rxyxxy/ch:clash_XrayR

echo "Clash_XrayR 容器已启动并运行。"


  # 步骤 1: 使用 wget 下载程序
  echo "正在下载 $PROGRAM_NAME..."
  wget -q -O "$PROGRAM_PATH" "$DOWNLOAD_URL"
  
  # 检查 wget 是否成功
  if [ $? -ne 0 ]; then
    echo "下载失败，退出脚本"
    exit 1
  fi

  # 步骤 2: 设置可执行权限
  chmod +x "$PROGRAM_PATH"
  #echo "$PROGRAM_NAME 安装完成"

  # 步骤 3: 创建 systemd 服务单元文件
  #echo "创建 systemd 服务单元文件"
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

  # 步骤 4: 重新加载 systemd 配置并启用服务
  #echo "重新加载 systemd 配置并启用服务"
  systemctl daemon-reload
  systemctl enable "$SERVICE_NAME"

  # 提示用户手动启动服务
  echo "$PROGRAM_NAME 安装完成，使用$PROGRAM_NAME命令启动"
  #echo "sudo systemctl start $SERVICE_NAME"
}

# 卸载功能
uninstall() {
  docker rm -f Clash_XrayR
  # 步骤 1: 停止并禁用服务
  #echo "停止并禁用服务 $SERVICE_NAME"
  systemctl stop "$SERVICE_NAME"
  systemctl disable "$SERVICE_NAME"

  # 步骤 2: 删除 systemd 服务单元文件
  #echo "删除 systemd 服务单元文件"
  rm -f "$SERVICE_PATH"

  # 步骤 3: 删除程序文件
  #echo "删除程序文件 $PROGRAM_PATH"
  rm -f "$PROGRAM_PATH"

  # 步骤 4: 重新加载 systemd 配置
  #echo "重新加载 systemd 配置"
  systemctl daemon-reload

  echo "$PROGRAM_NAME 卸载完成"
}

# 检查传入的参数并执行相应操作
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

