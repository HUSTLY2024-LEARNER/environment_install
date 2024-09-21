cd ~

apt-get update
apt-get install software-properties-common -y
# select 5. Asia and 69. Shanghai

# apt-fast 
add-apt-repository ppa:apt-fast/stable -y
apt-get update && apt-get install -y apt-fast
# select 'apt-get', '8' threads, and 'yes' to supress output

# install common ubuntu utils
apt-fast install -y gnupg2 language-pack-zh-hans zip \
 git curl wget vim htop ssh net-tools build-essential cmake \
 rsync ninja-build libx11-dev libxft-dev autoconf libtool \
 bison gperf libgles2-mesa-dev libxext-dev libxrandr-dev \
 libxi-dev libxcursor-dev libxdamage-dev libxinerama-dev \
 libboost-all-dev libflann-dev libeigen3-dev libopencv-dev sudo gdb rsync

# install zh_CN
apt-fast install -y language-pack-zh-hans
locale-gen zh_CN.UTF-8
dpkg-reconfigure locales
# select '323 zh_CN.UTF-8' and '3 zh_CN.UTF-8' in the two dialog

# add ros2 apt repository and install ros2
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
apt-get update
apt-fast install -y ros-jazzy-desktop-full ros-jazzy-foxglove*

# create user: hustlyrm with password 'hustlyrm' and add to sudo group, set no password when sudo
useradd -r -m -s /bin/bash hustlyrm
echo "hustlyrm:hustlyrm" | chpasswd
usermod -aG sudo hustlyrm
echo "hustlyrm ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# set ssh allow password login
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# change to user hustlyrm
su hustlyrm
cd /home/hustlyrm

# begin to setup development environment
mkdir ~/repos
mkdir ~/tools
mkdir ~/drivers

# setup vcpkg
cd ~/tools
git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install 
./vcpkg install fmt spdlog sol2 imgui lua eigen3 sophus ceres taskflow matchit sqlite3 yaml-cpp tomlplusplus xapian xbyak frozen

# BOOST

BOOST_VERSION=1.86.0
BOOST_DIR="boost_1_86_0"
BOOST_ZIP="boost_1_86_0.zip"
BOOST_LINK="https://archives.boost.io/release/${BOOST_VERSION}/source/${BOOST_ZIP}"

# setup boost
cd ~/repos
wget ${BOOST_LINK}
unzip ${BOOST_ZIP}
rm ${BOOST_ZIP}
cd ${BOOST_DIR}

#build boost
./bootstrap.sh
./b2 -j8
sudo ./b2 install

# OPENCV

OPENCV_VERSION=4.10.0
OPENCV_DIR="opencv-${OPENCV_VERSION}"
OPENCV_ZIP="4.10.0.zip"
OPENCV_LINK="https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip"

# setup opencv
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

# install GalaxySDK
GXSDK_FILE="Galaxy_Linux-x86_Gige-U3_32bits-64bits_1.5.2303.9221"
GXSDK_FILE_NAME="${GXSDK_FILE}.zip"
SHARED_DIR_PATH="/home/shared"
GXSDK_INSTALLER_FILE="Galaxy_camera.run"

cd ~/drivers
cp ${SHARED_DIR_PATH}/${GXSDK_FILE_NAME} ./
unzip ${GXSDK_FILE_NAME}
mv ${GXSDK_FILE}/${GXSDK_INSTALLER_FILE} ./
rm -rf ${GXSDK_FILE}
rm -rf ${GXSDK_FILE_NAME}
chmod +x ${GXSDK_INSTALLER_FILE}
sudo ./${GXSDK_INSTALLER_FILE}
# press enter and input 'Y'  'Cn' 

# install openvino
cd ~/drivers
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
echo "deb https://apt.repos.intel.com/openvino/2024 ubuntu24 main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2024.list
rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-get update
sudo apt-fast install openvino -y
