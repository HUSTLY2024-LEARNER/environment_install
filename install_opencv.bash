#!/bin/bash


#建议在ros2安装 之后 安装


# 安装 opencv
OPENCV_VERSION=4.10.0
OPENCV_DIR="opencv-${OPENCV_VERSION}"
OPENCV_ZIP="4.10.0.zip"
OPENCV_LINK="https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip"

# 设置 opencv
mkdir ~/repos
cd ~/repos
wget ${OPENCV_LINK}
unzip ${OPENCV_ZIP}
rm ${OPENCV_ZIP}
cd ${OPENCV_DIR}

# build opencv
mkdir build
cd build
cmake ..
make -j8
sudo make install
