title: "Docker: 利用Dockerfile制作Image"
date: 2015-08-06 16:12:10
categories: Tools
tags: [Mac, Docker]
---
记录利用Dockerfile制作Docker Image的过程.

<!-- more -->

### 更新 docker 版本

```bash

# 卸载docker：
apt-get purge lxc-docker
apt-get autoremove


# 更新docker,单纯更新，可以不用卸载:
apt-get update
apt-get install lxc-docker

```




### 利用Dockerfile制作image.

依赖源ubuntu14.04大小为200M.

```bash
dl.dockerpool.com:5000/ubuntu   14.04   5506de2b643b   9 months ago     199.3 MB
```

Dockerfile 文件内容:

```bash
# *******************************************************
# VERSION 0.0.1
# date: 2015-02-03
#
# note:
# install gcc, g++, python, ruby, go, perl, java.
#
# build_image:
# docker build --rm -t codebox:dev201508 .
# docker build -t codebox:dev201508 .
# -t : 添加tag
# –rm: 完成image构建后,删除临时Container，
# Dockerfile的每一行指令都会创建一个临时的Container，一般不需要这些临时生成的Container.
# *******************************************************

#FROM base
FROM dl.dockerpool.com:5000/ubuntu:14.04

# 添加作者签名
MAINTAINER hhstore

# install compile environment.
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y gcc-4.8
RUN apt-get install -y g++-4.8
RUN apt-get install -y python
RUN apt-get install -y ruby
RUN apt-get install -y perl
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y golang


```




### 本地分发Docker-image

```bash
# 打包image, 如果比较大,要耐心等一会.
docker save codebox > ~/codebox.tar.gz

# 解压并装载image
docker load < ~/codebox.tar.gz

# 查看导入成功
docker images

# 运行image
sudo docker run -i -t codebox /bin/bash


```


### 删除image

```
# 一次性删除所有的镜像
sudo docker rmi -f $(docker images -q)

```



- [参考1: 这篇很详细](http://tech.uc.cn/?p=2726)
