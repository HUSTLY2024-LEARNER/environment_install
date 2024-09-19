#!/bin/bash

# 缺少软件包 software-properties-common 需要下载
sudo apt-get install software-properties-common -y

# 安装 apt-fast 加速下载
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt-get update && sudo apt-get install -y apt-fast
# 选择 'apt-get', '8' threads, and 'yes' to suppress output

#!/bin/bash

# 安装基础工具
sudo apt-fast install -y gnupg2 language-pack-zh-hans zip

# 安装版本控制和网络工具
sudo apt-fast install -y git curl wget vim htop ssh net-tools

# 安装构建工具
sudo apt-fast install -y build-essential cmake rsync ninja-build

# 安装 X11 和图形库开发包
sudo apt-fast install -y libx11-dev libxft-dev autoconf libtool \
                        bison gperf libgles2-mesa-dev libxext-dev \
                        libxrandr-dev libxi-dev libxcursor-dev \
                        libxdamage-dev libxinerama-dev

# 安装 C++ 和科学计算库
sudo apt-fast install -y libboost-all-dev libflann-dev libeigen3-dev libopencv-dev
