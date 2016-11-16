title: Mac搭建Docker开发环境
date: 2015-08-06 16:12:10
categories: Tools
tags: [Mac, Docker]
---
记录Mac搭建Docker开发环境过程.

<!-- more -->


## Docker简介

## Mac搭建Docker环境

- 之前不太想在Mac上部署Docker,后来发现实在影响开发效率.索性还是配置一下吧.
- Mac配置Docker开发环境,需要安装Boot2Docker.详细步骤如下.
- [参考:官方文档](https://docs.docker.com/installation/mac/)

### 1. 下载 Boot2Docker 安装包

- [下载地址](http://get.daocloud.io/#install-boot2docker)
- 下载 Boot2Docker-1.7.1.pkg 并安装.
- 安装完成,会在Launchpad里添加Boot2Docker图标.


### 2. 初始化.

- 第一次,在Launchpad中,打开Boot2Docker软件,会自动打开终端,显示如下信息.

```bash
bash
Last login: Thu Aug  6 16:47:00 on ttys012
unset DYLD_LIBRARY_PATH ; unset LD_LIBRARY_PATH
mkdir -p ~/.boot2docker
if [ ! -f ~/.boot2docker/boot2docker.iso ]; then cp /usr/local/share/boot2docker/boot2docker.iso ~/.boot2docker/ ; fi
/usr/local/bin/boot2docker init
/usr/local/bin/boot2docker up
$(/usr/local/bin/boot2docker shellinit)
docker version
hhstore@hhstore-rMBP15.local:/Users/hhstore  $ bash
bash-3.2$ unset DYLD_LIBRARY_PATH ; unset LD_LIBRARY_PATH
bash-3.2$ mkdir -p ~/.boot2docker
bash-3.2$ if [ ! -f ~/.boot2docker/boot2docker.iso ]; then cp /usr/local/share/boot2docker/boot2docker.iso ~/.boot2docker/ ; fi
bash-3.2$ /usr/local/bin/boot2docker init
Generating public/private rsa key pair.
Your identification has been saved in /Users/hhstore/.ssh/id_boot2docker.
Your public key has been saved in /Users/hhstore/.ssh/id_boot2docker.pub.
The key fingerprint is:
43:0d:3c:7a:02:dc:6c:2a:21:02:26:81:f0:f7:ae:61 hhstore@hhstore-rMBP15.local
The key's randomart image is:
+--[ RSA 2048]----+
|Oo . o ..        |
|*.. o + oo       |
|.....+ ....      |
|  ....o..        |
|   .  .oS        |
|     .   .       |
|    E .          |
|   . o           |
|    .            |
+-----------------+
Initialization of virtual machine "boot2docker-vm" complete.
Use `boot2docker up` to start it.
bash-3.2$ /usr/local/bin/boot2docker up
$(/usr/local/bin/boot2docker shellinit)
docker version

Waiting for VM and Docker daemon to start...
........................oooooooooooooooo
Started.
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/ca.pem
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/cert.pem
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/key.pem

To connect the Docker client to the Docker daemon, please set:
    export DOCKER_CERT_PATH=/Users/hhstore/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1
    export DOCKER_HOST=tcp://192.168.59.103:2376

Or run: `eval "$(boot2docker shellinit)"`

bash-3.2$ $(/usr/local/bin/boot2docker shellinit)
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/ca.pem
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/cert.pem
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/key.pem
bash-3.2$ docker version
Client version: 1.7.1
Client API version: 1.19
Go version (client): go1.4.2
Git commit (client): 786b29d
OS/Arch (client): darwin/amd64
Server version: 1.7.1
Server API version: 1.19
Go version (server): go1.4.2
Git commit (server): 786b29d
OS/Arch (server): linux/amd64
bash-3.2$
bash-3.2$

```


### 3. 配置Docker加速器(Docker 1.3.2版本以上支持加速器)

- [参考:加速器](https://dashboard.daocloud.io/mirror)

```
echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://e73f9bcf.m.daocloud.io\"" | sudo tee -a /etc/default/docker
sudo service docker restart
```

### 4. 下载image,测试正常.

```bash
# 无需再添加 mirror源地址.正常执行时,会开始下载image.耐心等待.
sudo docker pull ubuntu:14.04  
docker pull hello-world
```

- 完整提示信息:

```bash
bash-3.2$ docker pull ubuntu:14.04
14.04: Pulling from ubuntu
2eaf0096818b: Pull complete
dac7bccb8ac3: Pull complete
389028aa9e91: Pull complete
63e3c10217b8: Already exists
ubuntu:14.04: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:44beefbcad1eb02996bf8eca28817cce4acfb16abf3736bf7040cb34244bf56f
Status: Downloaded newer image for ubuntu:14.04

```

### 5. 查看已经下载的image

- 启动Docker服务.

```bash
boot2docker init   # 初始化.
boot2docker up     # 启动.第一次,可能弹出如下报错提示,后提供解决办法.

```

- 第一次执行上述命令,弹出如下报错信息:

```bash
$ boot2docker up
Waiting for VM and Docker daemon to start...
.o
Started.
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/ca.pem
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/cert.pem
Writing /Users/hhstore/.boot2docker/certs/boot2docker-vm/key.pem

To connect the Docker client to the Docker daemon, please set:
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/hhstore/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1

Or run: `eval "$(boot2docker shellinit)"`

```

- 根据报错提示,最后一句要求执行:$(boot2docker shellinit)命令:
- 执行该命令,只是当次有效,下次关闭终端,需要重新设置.

```bash
# 注意,含$符号.
$(boot2docker shellinit)

```

- 查看已安装的image.

```bash
docker images

# 当前返回结果如下:
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu              14.04               63e3c10217b8        41 hours ago        188.4 MB
hello-world         latest              91c95931e552        3 months ago        910 B

```

- 使用Docker-image.

```bash
# 输入如下命令,正常输出提示信息:
$ docker run hello-world

Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (Assuming it was not already locally available.)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

For more examples and ideas, visit:
 http://docs.docker.com/userguide/



```





### 2. 配置 Boot2Docker

```bash
mkdir ~/.boot2docker
echo ISOURL = \"https://get.daocloud.io/boot2docker/boot2docker-lastest.iso\" > ~/.boot2docker/profile

```

### 3. 初始化并启动虚拟机

```bash
boot2docker init
boot2docker up
```
