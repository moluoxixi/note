## docker命令

- images 是本地的所有镜像

- containers 是镜像跑起来的容器

- volumes 是数据卷,数据卷就是把容器目录映射到本地目录,改本地目录就是改容器目录


![[docker.png]]

| 命令                                                                                                      | 说明                     | 对应desktop的操作                               |
| ------------------------------------------------------------------------------------------------------- | ---------------------- | ------------------------------------------ |
| docker                                                                                                  | 一个容器查看日志/查看详情/启动/删除/停止 | containers指定容器点击 Logs界面/Inspect界面/启动/删除/停止 |
| docker pull nginx:latest                                                                                | 拉一个镜像                  | 在images中pull一个镜像(这里pull的nginx),            |
| docker run --name nginx-test2 -p 80:80 -v /tmp/aaa:/usr/share/nginx/html -e KEY1=VALUE1 -d nginx:latest | 运行容器,                  | 在images中点击run,填Optional settings的表单后run    |
| docker ps -a                                                                                            | 列出容器列表                 | 获取                                         |
| docker images                                                                                           |                        | 获取images界面                                 |
| docker volume command                                                                                   | 用于管理                   | 对应                                         |
| docker build                                                                                            |                        | 打包,                                        |
| docker build name:tag                                                                                   |                        | 在当前目录下打包成一个名为name,tag为tag的镜像               |


容器的 terminal 里执行命令，对应的是 docker exec ,
## Dockerfile

文件名是固定的,就叫

```shell
# 使用官方的 node 运行时作为父镜像  
FROM node:latest
  
# 设置工作目录为 /app  
WORKDIR /app
  
# 将当前目录内容复制到容器的 /app 内  
COPY . /app  
  
# 容器内执行的命令
RUN npm config set registry https://registry.npmmirror.com/
RUN npm install -g http-server

#声明当前容器访问的端口
EXPOSE 8080

# 用于设指定一个或多个默认卷,当未指定卷的时候,会使用默认卷,避免删掉容器导致数据丢失
VOLUME ["/data"] 

# 容器启动时运行的命令  
CMD ["http-server", "-p", "8080"]
```