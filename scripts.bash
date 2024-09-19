
# docker 导入路径的镜像
docker load -i <path>

# docker 为导入的镜像添加 tag 方便识别
docker tag <imageID> <Name>:<otherInfo>

# docker 在已经运行的实例上执行指令
docker exec <额外参数> <实例id> <实例内实际执行的指令>

# docker 查询正在运行的实例，可能要 sudo
docker ps -a

# docker 缺少软件包 software-properties-common 需要下载
sudo apt-get install software-properties-common -y

# 安装 apt-fast 加速下载
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt-get update && sudo apt-get install -y apt-fast
# select 'apt-get', '8' threads, and 'yes' to supress output

# 安装常用工具
# install common ubuntu utils
sudo apt-fast install -y gnupg2 language-pack-zh-hans zip \
 git curl wget vim htop ssh net-tools build-essential cmake \
 rsync ninja-build libx11-dev libxft-dev autoconf libtool \
 bison gperf libgles2-mesa-dev libxext-dev libxrandr-dev \
 libxi-dev libxcursor-dev libxdamage-dev libxinerama-dev \
 libboost-all-dev libflann-dev libeigen3-dev libopencv-dev

# 安装 ros2 : jazzy
# add ros2 apt repository
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt-get update

#use apt-fast to install ros2
sudo apt-fast install ros-jazzy-desktop -y

# 使用中文
# install zh_CN
sudo apt-fast install language-pack-zh-hans -y
sudo locale-gen zh_CN.UTF-8
sudo dpkg-reconfigure locales
# select 'zh_CN.UTF-8' and 'zh_CN.UTF-8' in the two dialog

# 安装 vcpkg
mkdir ~/tools
cd ~/tools
git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install

# vcpkg 安装C++包
./vcpkg install <包名称>

# 安装 boost
BOOST_VERSION=1.86.0
BOOST_DIR="boost_1_86_0"
BOOST_ZIP="boost_1_86_0.zip"
BOOST_LINK="https://archives.boost.io/release/${BOOST_VERSION}/source/${BOOST_ZIP}"

# setup boost
mkdir ~/repos
cd ~/repos
wget ${BOOST_LINK}
unzip ${BOOST_ZIP}
rm ${BOOST_ZIP}
cd ${BOOST_DIR}

#build boost
./bootstrap.sh
./b2 -j8
sudo ./b2 install

# 安装 opencv
OPENCV_VERSION=4.10.0
OPENCV_DIR="opencv-${OPENCV_VERSION}"
OPENCV_ZIP="4.10.0.zip"
OPENCV_LINK="https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip"

# setup opencv
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
