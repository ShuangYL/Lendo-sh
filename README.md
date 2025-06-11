# 🧰 Ubuntu 自动安装部署脚本 | Ubuntu Auto Setup Script

**作者 / Author:** LENDO-棱度  
📧 Email: psb232@outlook.com  
💬 QQ: 2325132172  
🔗 GitHub: [https://github.com/ShuangYL](https://github.com/ShuangYL)

---

## 🗂️ 简介 | Introduction

`ubuntu-lendo.sh` 是一个一键式 Ubuntu 系统环境部署脚本，集成了基础设置、开发环境、网络配置、安全策略等常用功能模块，适用于新装系统的初始配置场景。

`ubuntu-lendo.sh` is an all-in-one automation script for Ubuntu, providing essential setup tasks like mirror optimization, development tools installation, firewall config, and more. Perfect for newly installed Ubuntu systems.

---

## 📋 功能列表 | Feature List

| 编号 | 中文功能项                  | English Feature Description                       |
| ---- | --------------------------- | ------------------------------------------------ |
| 1    | 切换国内镜像源（阿里、清华等）      | Switch to Chinese APT mirrors (Aliyun, Tsinghua) |
| 2    | 安装中文语言包（简体/繁体）         | Install Chinese language packs (Simplified/Trad.)|
| 3    | 更新并升级系统软件包               | Update & upgrade system packages                 |
| 4    | 安装常用工具（vim, curl, git 等）   | Install common CLI tools (vim, curl, git, etc.)  |
| 5    | 启用并配置防火墙（UFW）            | Enable and configure UFW firewall                |
| 6    | 安装 Docker 引擎                  | Install Docker Engine                            |
| 7    | 设置系统时区为 Asia/Shanghai       | Set system timezone to Asia/Shanghai             |
| 8    | 启用 SSH 服务                      | Enable SSH service                               |
| 9    | 优化内核参数（文件句柄数）          | Optimize kernel parameters (e.g., file handles)  |
| 10   | 安装 Python3 & pip                | Install Python3 and pip                          |
| 11   | 安装 Visual Studio Code           | Install Visual Studio Code                       |
| 12   | 安装 Google 拼音输入法             | Install Google Pinyin input method (via Fcitx)   |
| 13   | 安装 VMware 增强工具               | Install VMware Guest Additions                   |
| 0    | 退出脚本程序                       | Exit the script                                  |


---

## 💻 使用方法 | Usage

### 📥 下载与运行脚本 | Download & Run

```bash
wget https://yourdomain.com/ubuntu-lendo.sh
chmod +x ubuntu-lendo.sh
sudo ./ubuntu-lendo.sh
```

> 建议使用 root 权限运行，确保一切配置能顺利完成。  
> It is recommended to run the script with root privileges.

---

## ⚙️ 系统要求 | System Requirements

- **操作系统 / OS:** Ubuntu 18.04 / 20.04 / 22.04 及以上
- **网络连接 / Network:** 需要联网以下载安装依赖
- **权限要求 / Privilege:** 建议使用 root 或 sudo 权限运行

---

## 📸 示例截图 | Sample Screenshots

（此处可插入若干运行过程截图，增强可信度和引导效果）

---

## 🧩 附加说明 | Additional Notes

- 自动备份原始 `sources.list` 文件为 `/etc/apt/sources.list.bak`
- 更换语言或安装输入法后，建议 **重启系统** 生效
- 安装 VSCode 时使用官方仓库，默认信任 Microsoft GPG Key
- 在 VMware 虚拟机中运行时，建议安装增强工具以获得更佳体验（如拖放、分辨率调整）

---

## 📜 开源协议 | License

该脚本采用 MIT License 开源协议，允许自由使用、修改与传播，但请保留作者署名信息。

This script is licensed under the MIT License — feel free to use, modify, and distribute with proper attribution.

---

## 🙋 联系方式 | Contact

如有建议、反馈或 bug 报告，欢迎通过以下方式联系我：

- 💬 QQ: 2325132172
- 📧 Email: psb232@outlook.com
- 🧑‍💻 GitHub: [https://github.com/ShuangYL](https://github.com/ShuangYL)
