#!/bin/bash

# 从上一级目录的 package.json 文件中提取版本号
VERSION=$(grep -oP '(?<="version": ")[^"]*' ../package.json)

cd ../ && npm run build
cd docker/
# 显示版本号并获取用户确认
read -p "版本号是 ${VERSION}，是否确认？(y/n)" -n 1 -r
echo # 移到新行
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # 如果用户确认，给 Docker 容器打上版本号标签
    # 编译前端界面
    echo "-------------------- Build chatgpt-web --------------------------"
    sudo docker build -t renwofei423/chatgpt-web:latest -t renwofei423/chatgpt-web:${VERSION} -f Dockerfile.fontend ../.

    # 编译后端
    echo "-------------------- Build chatgpt-web-backend --------------------------"
    sudo docker build -t renwofei423/chatgpt-web-backend:latest -t renwofei423/chatgpt-web-backend:${VERSION} -f Dockerfile.backend ../.
else
    echo "操作已取消."
fi

# 提示用户确认上传
read -p "是否确认上传 ${IMAGE_NAME}:${TAG} 到 Docker Hub？(y/n)" -n 1 -r
echo # 移到新行
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # 登录 Docker Hub
    sudo docker login

    # 推送镜像到 Docker Hub
    sudo docker push renwofei423/chatgpt-web:latest
    sudo docker push renwofei423/chatgpt-web:${VERSION}
    sudo docker push renwofei423/chatgpt-web-backend:latest
    sudo docker push renwofei423/chatgpt-web-backend:${VERSION}
else
    echo "操作已取消."
fi