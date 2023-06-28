# 使用 Node.js 镜像作为基础镜像
FROM node:16

# 设置工作目录并拷贝前端相关文件
WORKDIR .
COPY package.json .
COPY src/ .

# 安装依赖并构建前端项目
RUN npm install
RUN npm run build

# 使用 Nginx 作为静态文件服务器
FROM nginx:stable-alpine-slim:latest
COPY --from=0 dist /usr/share/nginx/html

# 暴露端口 80
EXPOSE 80

# 启动 Nginx 服务器
CMD ["nginx", "-g", "daemon off;"]
