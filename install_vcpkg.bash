#!/bin/bash

# 安装 vcpkg
mkdir ~/tools
cd ~/tools
git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install

# vcpkg 安装C++包
./vcpkg install <包名称>
