title: Ubuntu14.04安装Docker详细教程
date: 2015-07-07 21:21:50
categories: Docker
tags: [Docker, Ubuntu, Linode, EC2]
---

本篇介绍ubuntu环境安装Docker详细配置过程.

<!-- more -->


- [官方文档](https://docs.docker.com/installation/ubuntulinux/)

## 前言
- 最近项目重新部署,要重新安装docker,发现docker官网更新版本,添加一些新的功能.故写此文档,以备复查.
- 安装docker推荐ubuntu环境,包括centos,Mac 我都尝试过,还是ubuntu最不容易出错.
- 这里只记录ubuntu的安装配置过程.其他版本,请参考官方文档.


## 1.推荐安装环境:
### 1. 云服务器安装Docker.(推荐)

- 1.推荐使用亚马逊云,Linode,阿里云等方式安装.
- 2.之前Docker的image源被墙,国内要采用镜像站点更新,很不稳定.
- 3.先在云主机上,安装ubuntu14.04.(要求如下)

### 1.2 宿主机要求:

- 1.Linux系统: 64位版本的ubuntu14.04 LTS系统.(64位,为必要条件)
- 2.Linux内核版本号: 3.10以上.(内核版本号,为必要条件)


## 2.安装Docker:

### 2.1 查看内核版本号:

```bash
uname -r   # 返回: 3.11.0-15-generic
```

### 2.2 准备工作:

```bash

1. 更新apt-get
    sudo apt-get update
    
2. 更新依赖
    sudo apt-get install linux-image-generic-lts-trusty

3. 重启
    sudo reboot

4. 系统重启后,开始安装docker

```

### 2.3 安装

```bash
1. 查看是否已安装wget.(这是一个下载工具)
    which wget  

2. 安装wget.
    sudo apt-get update
    sudo apt-get install wget

3. 下载并安装docker.
    wget -qO- https://get.docker.com/ | sh

4. 确认docker安装成功.
    sudo docker run hello-world


```

## 3.配置Docker

### 3.1 创建Docker用户组.
- 为避免每次操作,都加上sudo提权.故创建docker用户组.

```bash
1. 以具有sudo权限的用户账号,登录.

2. 创建docker用户组,并添加该用户账号至docker用户组.
    sudo usermod -aG docker ubuntu

    示例:
    sudo usermod -aG docker bingwei   # 登录用户为bingwei
    > sent invalidate(passwd) request, exiting
    > sent invalidate(group) request, exiting
    > sent invalidate(passwd) request, exiting
    > sent invalidate(group) request, exiting

3. 退出登录,再次重新登录该用户账号.

4. 测试用户组,生效.
    docker run hello-world  # 不带sudo前缀.若成功,则说明OK.

```

### 3.2 重启Docker
```bash
sudo restart docker
```


## 4. 升级Docker
- 与安装一样.

```bash
wget -qO- https://get.docker.com/ | sh  
```


## 5. 卸载Docker

### 5.1 卸载docker软件包
```bash
sudo apt-get autoremove --purge lxc-docker
```

### 5.2 删除docker已安装的images
```bash
rm -rf /var/lib/docker
```


## 6. 常用操作命令

- [参考](https://docs.docker.com/userguide/dockerimages/)

```bash

sudo docker images          # 查看已安装image
sudo docker search sinatra  # 搜索某image
sudo docker pull XXXX       # 下载安装image

```


## 7. 创建自己的image

- [参考](https://docs.docker.com/userguide/dockerimages/)
- 待补充更新.


1. We can update a container created from an image and commit the results to an image.
2. We can use a Dockerfile to specify instructions to create an image.
