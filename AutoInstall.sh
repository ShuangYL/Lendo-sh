#!/bin/bash

# =============================================
# Ubuntu 自动安装部署
# 作者: LENDO-棱度
# QQ: 2325132172
# 邮箱: psb232@outlook.com
# =============================================

set -e

# 颜色定义（可用 tput 也可用转义字符）
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[97m"
BOLD="\033[1m"
UNDERLINE="\033[4m"
RESET="\033[0m"

function print_banner() {
    echo -e "${MAGENTA}${BOLD}"
    cat << "EOF"
 ___           _______       ________       ________      ________     
|\  \         |\  ___ \     |\   ___  \    |\   ___ \    |\   __  \    
\ \  \        \ \   __/|    \ \  \\ \  \   \ \  \_|\ \   \ \  \|\  \   
 \ \  \        \ \  \_|/__   \ \  \\ \  \   \ \  \ \\ \   \ \  \\\  \  
  \ \  \____    \ \  \_|\ \   \ \  \\ \  \   \ \  \_\\ \   \ \  \\\  \ 
   \ \_______\   \ \_______\   \ \__\\ \__\   \ \_______\   \ \_______\
    \|_______|    \|_______|    \|__| \|__|    \|_______|    \|_______|
                                                                                                                                         
EOF
    echo -e "${CYAN}${BOLD}                 L  E  N  D  O${RESET}"
    echo
}

function show_author_info() {
    echo -e "${YELLOW}${BOLD}==============================================${RESET}"
    echo -e "${GREEN} Ubuntu 自动安装部署"
    echo -e " 作者: ${WHITE}LENDO-棱度${RESET}${GREEN}"
    echo -e " QQ: ${WHITE}2325132172${RESET}${GREEN}"
    echo -e " 邮箱: ${WHITE}psb232@outlook.com${RESET}${GREEN}"
    echo -e "${YELLOW}==============================================${RESET}"
}

function show_menu() {
    echo ""
    echo -e "${BOLD}${UNDERLINE}========= Ubuntu 自动安装部署 =========${RESET}"
    echo -e " ${YELLOW}1${RESET}. 自动选择最快的国内镜像源并切换"
    echo -e " ${YELLOW}2${RESET}. 安装中文语言包"
    echo -e " ${YELLOW}3${RESET}. 更新并升级系统"
    echo -e " ${YELLOW}4${RESET}. 安装常用工具（vim, curl, wget, git, htop）"
    echo -e " ${YELLOW}5${RESET}. 配置并启用 UFW 防火墙"
    echo -e " ${YELLOW}6${RESET}. 安装 Docker"
    echo -e " ${YELLOW}7${RESET}. 设置系统时区为 Asia/Shanghai"
    echo -e " ${YELLOW}8${RESET}. 启用 SSH 服务"
    echo -e " ${YELLOW}9${RESET}. 优化内核参数（文件句柄数）"
    echo -e " ${YELLOW}10${RESET}. 安装 Python3"
    echo -e " ${YELLOW}11${RESET}. 安装 Visual Studio Code"
    echo -e " ${YELLOW}12${RESET}. 安装 Google 拼音输入法"
    echo -e " ${YELLOW}13${RESET}. 安装 VM 增强应用程序（vm虚拟机专用）"
    echo -e " ${YELLOW}0${RESET}. 退出程序"
    echo -e "${BOLD}=======================================${RESET}"
    echo -ne "${CYAN}请输入选项编号（${YELLOW}1-13，输入0退出程序${CYAN}）: ${RESET}"
}

function switch_mirror() {
    echo -e "${GREEN}👉 正在检测系统版本...${RESET}"
    VERSION_CODENAME=$(lsb_release -cs)
    echo -e "${CYAN}✅ 检测到系统版本代号: ${VERSION_CODENAME}${RESET}"

    echo -e "${GREEN}👉 可选镜像源列表：${RESET}"
    echo -e " ${YELLOW}1${RESET}. 阿里云"
    echo -e " ${YELLOW}2${RESET}. 清华大学"
    echo -e " ${YELLOW}3${RESET}. 中科大"
    echo -e " ${YELLOW}4${RESET}. 华为云"
    echo -e " ${YELLOW}5${RESET}. 网易"
    echo -e " ${YELLOW}6${RESET}. 默认（官方）"
    echo -ne "${CYAN}请选择镜像源（1-6，默认1）: ${RESET}"
    read -r mirror_choice
    mirror_choice=${mirror_choice:-1}

    case $mirror_choice in
        1) MIRROR_URL="http://mirrors.aliyun.com/ubuntu/" ;;
        2) MIRROR_URL="https://mirrors.tuna.tsinghua.edu.cn/ubuntu/" ;;
        3) MIRROR_URL="http://mirrors.ustc.edu.cn/ubuntu/" ;;
        4) MIRROR_URL="https://mirrors.huaweicloud.com/repository/ubuntu/" ;;
        5) MIRROR_URL="http://mirrors.163.com/ubuntu/" ;;
        6) MIRROR_URL="http://archive.ubuntu.com/ubuntu/" ;;
        *) MIRROR_URL="http://mirrors.aliyun.com/ubuntu/" ;;
    esac

    echo -e "${GREEN}👉 正在备份原始 sources.list ...${RESET}"
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

    echo -e "${GREEN}👉 写入新的镜像源到 /etc/apt/sources.list ...${RESET}"
    sudo bash -c "cat > /etc/apt/sources.list" <<EOF
deb ${MIRROR_URL} ${VERSION_CODENAME} main restricted universe multiverse
deb ${MIRROR_URL} ${VERSION_CODENAME}-security main restricted universe multiverse
deb ${MIRROR_URL} ${VERSION_CODENAME}-updates main restricted universe multiverse
deb ${MIRROR_URL} ${VERSION_CODENAME}-backports main restricted universe multiverse
deb-src ${MIRROR_URL} ${VERSION_CODENAME} main restricted universe multiverse
deb-src ${MIRROR_URL} ${VERSION_CODENAME}-security main restricted universe multiverse
deb-src ${MIRROR_URL} ${VERSION_CODENAME}-updates main restricted universe multiverse
deb-src ${MIRROR_URL} ${VERSION_CODENAME}-backports main restricted universe multiverse
EOF

    echo -e "${GREEN}👉 正在更新软件包列表...${RESET}"
    sudo apt update

    echo -e "${GREEN}✅ 镜像源已成功切换为: ${MIRROR_URL}${RESET}"
}


function install_chinese() {
    echo -e "${GREEN}请选择中文语言包类型：${RESET}"
    echo -e " 1) 简体中文 (zh_CN.UTF-8)"
    echo -e " 2) 繁体中文 (zh_TW.UTF-8)"
    echo -ne "请输入选项（1或2，默认1）: "
    read -r lang_choice
    case "$lang_choice" in
        2)
            lang_code="zh_TW.UTF-8"
            pkg="language-pack-zh-hant"
            ;;
        *)
            lang_code="zh_CN.UTF-8"
            pkg="language-pack-zh-hans"
            ;;
    esac
    echo -e "${GREEN}👉 安装语言包 ${pkg} ...${RESET}"
    sudo apt update
    sudo apt install -y $pkg
    echo -e "${GREEN}👉 设置系统语言为 ${lang_code} ...${RESET}"
    sudo update-locale LANG=$lang_code LANGUAGE=$lang_code
    echo -e "${GREEN}✅ 中文语言包安装完成！请重新登录或重启以生效。${RESET}"
}

function update_upgrade() {
    echo -e "${GREEN}👉 更新软件包列表和升级系统...${RESET}"
    sudo apt update && sudo apt upgrade -y
    echo -e "${GREEN}✅ 系统已更新升级完成！${RESET}"
}

function install_common_tools() {
    echo -e "${GREEN}👉 安装常用工具: vim, curl, wget, git, htop ...${RESET}"
    sudo apt install -y vim curl wget git htop
    echo -e "${GREEN}✅ 常用工具安装完成！${RESET}"
}

function setup_firewall() {
    echo -e "${GREEN}👉 配置并启用 UFW 防火墙...${RESET}"
    sudo apt install -y ufw
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw enable
    echo -e "${GREEN}✅ 防火墙已启用并允许 SSH 连接。${RESET}"
}

function install_docker() {
    echo -e "${GREEN}👉 安装 Docker...${RESET}"
    sudo apt update
    sudo apt install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable docker
    sudo systemctl start docker
    echo -e "${GREEN}✅ Docker 安装并启动完成！${RESET}"
}

function set_timezone() {
    echo -e "${GREEN}👉 设置系统时区为 Asia/Shanghai ...${RESET}"
    sudo timedatectl set-timezone Asia/Shanghai
    echo -e "${GREEN}✅ 时区设置完成！${RESET}"
}

function enable_ssh() {
    echo -e "${GREEN}👉 安装并启用 SSH 服务...${RESET}"
    sudo apt install -y openssh-server
    sudo systemctl enable ssh
    sudo systemctl start ssh
    echo -e "${GREEN}✅ SSH 服务已启用！${RESET}"
}

function optimize_kernel() {
    echo -e "${GREEN}👉 优化内核参数，增加文件句柄数...${RESET}"
    sudo bash -c "cat >> /etc/sysctl.conf <<EOF

# 文件句柄数优化
fs.file-max = 100000
EOF"
    sudo sysctl -p
    echo -e "${GREEN}✅ 内核参数优化完成！${RESET}"
}

function install_python3() {
    echo -e "${GREEN}👉 安装 Python3...${RESET}"
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv
    echo -e "${GREEN}✅ Python3 安装完成！${RESET}"
}

function install_vscode() {
    echo -e "${GREEN}👉 安装 Visual Studio Code...${RESET}"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
    rm packages.microsoft.gpg
    echo -e "${GREEN}✅ VS Code 安装完成！${RESET}"
}

function install_google_pinyin() {
    echo -e "${GREEN}👉 安装 Google 拼音输入法...${RESET}"
    sudo apt update
    sudo apt install -y fcitx fcitx-googlepinyin fcitx-config-gtk
    echo -e "${GREEN}✅ Google 拼音输入法安装完成！请在系统设置中切换输入法框架为 fcitx 并重启。${RESET}"
}

function install_vm_tools() {
    echo -e "${GREEN}👉 安装 VM 增强应用程序...${RESET}"
    sudo apt update
    sudo apt install -y open-vm-tools open-vm-tools-desktop
    echo -e "${GREEN}✅ VM 增强应用程序安装完成！重启系统后使用全部功能。${RESET}"
}

print_banner
show_author_info

while true; do
    show_menu
    read -r choice
    case $choice in
        1) switch_mirror ;;
        2) install_chinese ;;
        3) update_upgrade ;;
        4) install_common_tools ;;
        5) setup_firewall ;;
        6) install_docker ;;
        7) set_timezone ;;
        8) enable_ssh ;;
        9) optimize_kernel ;;
        10) install_python3 ;;
        11) install_vscode ;;
        12) install_google_pinyin ;;
        13) install_vm_tool ;;
        0)
            echo -e "${GREEN}👋 再见！感谢使用 LENDO-棱度 脚本${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ 无效输入，请输入 ${YELLOW}1~13${RED} 之间的数字。${RESET}"
            ;;
    esac
done

