## docker命令
![](assets/docker.png)
- images 是本地的所有镜像
- containers 是镜像跑起来的容器
- volumes 是数据卷,数据卷就是把容器目录映射到本地目录,改本地目录就是改容器目录

| 说明                                                                                                                                                           | 命令                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| docker --version                                                                                                                                             | 显示 Docker 版本信息                                                                                                                |
| docker info                                                                                                                                                  | 显示 Docker 系统信息                                                                                                                |
|                                                                                                                                                              |                                                                                                                               |
| docker images                                                                                                                                                | 查看本地镜像                                                                                                                        |
| docker pull/push/rmi `镜像名称`                                                                                                                                  | 拉取/推送/删除 镜像                                                                                                                   |
| docker search `关键词`                                                                                                                                          | 搜索镜像                                                                                                                          |
|                                                                                                                                                              |                                                                                                                               |
| docker ps -a                                                                                                                                                 | 查看所有容器                                                                                                                        |
| docker exec -it `容器或ID或名称` /bin/bash                                                                                                                         | 进入容器                                                                                                                          |
| exit                                                                                                                                                         | 退出容器                                                                                                                          |
| docker cp `主机路径` `容器或ID或名称`: `容器内路径`                                                                                                                         | 从主机拷贝文件或目录到容器                                                                                                                 |
| docker cp `容器ID或名称`:`容器内路径` `主机路径`                                                                                                                           | 从容器拷贝文件或目录到主机                                                                                                                 |
| docker create/start/run/restart/rm/stop `容器ID或名称`                                                                                                            | 创建/启动/创建并启动/重启/删除/停止 容器                                                                                                       |
| docker run -p `容器端口`:`主机端口` -v `主机目录`:`容器目录` -d `镜像名:对应的tag`<br><br>docker run -it `镜像名:对应的tag` /bin/bash<br><br>docker run  -e `环境变量1:值` -e `环境变量2:值` `镜像名` | 启动容器,<br>`-p`   映射端口<br>`-v`   隐射目录(数据卷)<br>`-d`   后台运行<br>`-it`  交互模式运行,运行一个脚本,再启动容器<br>`-e`   设置环境变量的值<br>`--name`  重命镜像为xx |
|                                                                                                                                                              |                                                                                                                               |
| docker build `镜像名:对应的tag`                                                                                                                                    | 使用Dockerfile,在当前目录下打包成一个名为name,tag为tag的镜像                                                                                     |

## 容器管理

| 说明                                                                                                                                                           | 命令                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| docker ps -a                                                                                                                                                 | 查看所有容器                                                                                                                        |
| docker exec -it `容器或ID或名称` /bin/bash                                                                                                                         | 进入容器                                                                                                                          |
| exit                                                                                                                                                         | 退出容器                                                                                                                          |
| docker cp `主机路径` `容器或ID或名称`: `容器内路径`                                                                                                                         | 从主机拷贝文件或目录到容器                                                                                                                 |
| docker cp `容器ID或名称`:`容器内路径` `主机路径`                                                                                                                           | 从容器拷贝文件或目录到主机                                                                                                                 |
| docker create/start/run/restart/rm/stop `容器ID或名称`                                                                                                            | 创建/启动/创建并启动/重启/删除/停止 容器                                                                                                       |
| docker run -p `容器端口`:`主机端口` -v `主机目录`:`容器目录` -d `镜像名:对应的tag`<br><br>docker run -it `镜像名:对应的tag` /bin/bash<br><br>docker run  -e `环境变量1:值` -e `环境变量2:值` `镜像名` | 启动容器,<br>`-p`   映射端口<br>`-v`   隐射目录(数据卷)<br>`-d`   后台运行<br>`-it`  交互模式运行,运行一个脚本,再启动容器<br>`-e`   设置环境变量的值<br>`--name`  重命镜像为xx |
|                                                                                                                                                              |                                                                                                                               |

## 镜像管理

| 说明                          | 命令          |
| --------------------------- | ----------- |
| docker images               | 查看本地镜像      |
| docker pull/push/rmi `镜像名称` | 拉取/推送/删除 镜像 |
| docker search `关键词`         | 搜索镜像        |


## 信息查看

| 说明               | 命令             |
| ---------------- | -------------- |
| docker --version | 显示 Docker 版本信息 |
| docker info      | 显示 Docker 系统信息 |

## Dockerfile
`docker build name:tag`   使用Dockerfile,在当前目录下打包成一个名为name,tag为tag的镜像

文件名是固定的,就叫`Dockerfile`

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