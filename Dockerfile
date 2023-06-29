# 设置基础镜像
# FROM node:16

# 定义工作目录
# WORKDIR /app

# 复制package.json 和 package-lock.json 到工作目录
# COPY package*.json ./
# COPY yarn.lock ./

# 安装依赖
# RUN npm config set registry http://172.20.188.110/
# RUN yarn install

# 复制源码到工作目录
# COPY . .

# 构建项目
# RUN npm run build

# 使用nginx镜像作为基础镜像
FROM nginx:alpine-slim
WORKDIR /app

# 将构建好的文件复制到nginx容器的默认静态资源目录
# COPY --from=0 /app/dist /usr/share/nginx/html
COPY dist /usr/share/nginx/html

# 暴露端口：80
EXPOSE 80

# 运行nginx
CMD ["nginx", "-g", "daemon off;"]
