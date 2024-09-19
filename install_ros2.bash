#!/bin/bash

# 建议首先安装ros2库
# 安装 ros2 : jazzy
# 添加 ros2 apt 仓库
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt-get update

# 使用 apt-fast 安装 ros2
sudo apt-fast install ros-jazzy-desktop -y
