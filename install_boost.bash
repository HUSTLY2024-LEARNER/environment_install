#!/bin/bash

#建议在ros2安装 之后 安装


# 安装 boost
BOOST_VERSION=1.86.0
BOOST_DIR="boost_1_86_0"
BOOST_ZIP="boost_1_86_0.zip"
BOOST_LINK="https://archives.boost.io/release/${BOOST_VERSION}/source/${BOOST_ZIP}"

# 设置 boost
mkdir ~/repos
cd ~/repos
wget ${BOOST_LINK}
unzip ${BOOST_ZIP}
rm ${BOOST_ZIP}
cd ${BOOST_DIR}

# build boost
./bootstrap.sh
./b2 -j8
sudo ./b2 install
