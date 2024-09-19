#!/bin/bash


#在自己的电脑上准备好压缩包文件
# 导入路径的镜像
docker load -i <path>


# 为导入的镜像添加 tag 方便识别
docker tag <imageID> <Name>:<otherInfo>


# 使用新导入的镜像
docker run [OPTIONS] <Name>:<otherInfo>


# 在已经运行的实例上执行指令
docker exec <额外参数> <实例id> <实例内实际执行的指令>

# 需要在 Docker 主机的终端中执行，查询正在运行的实例
docker ps -a
