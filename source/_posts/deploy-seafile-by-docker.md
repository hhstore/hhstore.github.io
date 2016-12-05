title: "使用 Docker 部署 Seafile"
date: 2016-12-05 15:12:10
categories: Docker
tags: [Docker, Seafile]
---
本篇介绍: 通过 Docker 部署 Seafile.

<!-- more -->

## Seafile 简介:

- [Seafile 官网](https://www.seafile.com/home/)
    - [download](https://www.seafile.com/download/)
    - [Mac 客户端](http://download-cn.seafile.com/seafile-client-6.0.0.dmg)
    - [seafile 帮助文档](https://manual-cn.seafile.com/)
- 海文云盘：安全、可靠、快速的企业文件云存储
- Seafile 服务器内核由 C 语言编写。运行起来小巧快速。


## 使用 docker 部署:

### 拉取 docker 镜像:

- [JensErat/docker-seafile](https://github.com/JensErat/docker-seafile)
- [seafile - DockerHub](https://hub.docker.com/r/jenserat/seafile/)


```
docker pull jenserat/seafile

```

### 容器启动:

- 新建容器共享目录: `/iDockerShare/seafile`
- 当前 seafile 官网最新服务器端版本: seafile-server-6.0.6
- 关键细节:
    - 此容器本身并未打包 seafile 代码.
    - 容器启动后, 需手动执行命令, 去 seafile 官网拉取最新代码.
    - 容器中, 执行安装命令, 配置服务器.
    - 容器中, 手动添加 admin 用户帐号, 密码.
    - 当前版本, 8082 端口, 不可随便映射, 否则上传时会出错.


```
#
# -v : 目录映射:
# -p 8000:8000 服务访问端口
# -p 8082:8082 此端口, 不可随便映射, 因为代码写死的, 映射成其他端口, 无法上传文件
# 建议都使用默认的端口映射, 防止出错.
docker run -d \
  --name seafile-server \
  -p 10001:10001 \
  -p 12001:12001 \
  -p 8900:8000 \
  -p 8980:8080 \
  -p 8082:8082 \
  -v /iDockerShare/seafile:/opt/seafile \
  -e autostart=true \
  jenserat/seafile


# 登录容器配置:
docker exec -it seafile-server /bin/bash

################################################
#         如下部分, 在 docker 容器中操作
################################################

# 下载最新代码:
docker >: download-seafile

# 执行安装:
docker >: /opt/seafile/seafile-server-5.*/setup-seafile.sh
docker >: /opt/seafile/seafile-server-6.*/setup-seafile.sh

# 安装日志:
root@11f5e9ad841a:/opt/seafile/seafile-server-6.0.6#  ./setup-seafile.sh
-----------------------------------------------------------------
This script will guide you to config and setup your seafile server.

Make sure you have read seafile server manual at

	https://github.com/haiwen/seafile/wiki

Note: This script will guide your to setup seafile server using sqlite3,
which may have problems if your disk is on a NFS/CIFS/USB.
In these cases, we sugguest you setup seafile server using MySQL.

Press [ENTER] to continue
-----------------------------------------------------------------


Checking packages needed by seafile ...

Checking python on this machine ...
Find python: python2.7

  Checking python module: setuptools ... Done.
  Checking python module: python-imaging ... Done.
  Checking python module: python-sqlite3 ... Done.

Checking for sqlite3 ...Done.

Checking Done.


What would you like to use as the name of this seafile server?
Your seafile users will be able to see the name in their seafile client.
You can use a-z, A-Z, 0-9, _ and -, and the length should be 3 ~ 15
[server name]: jolly-seafile

What is the ip or domain of this server?
For example, www.mycompany.com, or, 192.168.1.101

[This server's ip or domain]: 192.168.0.100

Where would you like to store your seafile data?
Note: Please use a volume with enough free space.
[default: /opt/seafile/seafile-data ]

What tcp port do you want to use for seafile fileserver?
8082 is the recommended port.
[default: 8082 ]


This is your config information:

server name:        jolly-seafile
server ip/domain:   192.168.0.100
seafile data dir:   /opt/seafile/seafile-data
fileserver port:    8082

If you are OK with the configuration, press [ENTER] to continue.

Generating ccnet configuration in /opt/seafile/ccnet...

done
Successly create configuration dir /opt/seafile/ccnet.

Generating seafile configuration in /opt/seafile/seafile-data ...

Done.

-----------------------------------------------------------------
Seahub is the web interface for seafile server.
Now let's setup seahub configuration. Press [ENTER] to continue
-----------------------------------------------------------------

Creating seahub database now, it may take one minute, please wait...

Done.

creating seafile-server-latest symbolic link ... done


-----------------------------------------------------------------
Your seafile server configuration has been completed successfully.
-----------------------------------------------------------------

run seafile server:     ./seafile.sh { start | stop | restart }
run seahub  server:     ./seahub.sh  { start <port> | stop | restart <port> }

-----------------------------------------------------------------
If the server is behind a firewall, remember to open these tcp ports:
-----------------------------------------------------------------

port of seafile fileserver:   8082
port of seahub:               8000

When problems occur, refer to

      https://github.com/haiwen/seafile/wiki

for more information.


# 容器中启动服务: start the seafile controller process.
docker >: /opt/seafile/seafile-server-6.*/seafile.sh start

root@11f5e9ad841a:/opt/seafile/seafile-server-6.0.6# /opt/seafile/seafile-server-6.*/seafile.sh start

Seafile controller is already running, pid 1935


# 容器中启动服务: for configuring the web UI.
docker >: /opt/seafile/seafile-server-6.*/seahub.sh start

root@11f5e9ad841a:/opt/seafile/seafile-server-6.0.6# /opt/seafile/seafile-server-6.*/seahub.sh start

LANG is not set in ENV, set to en_US.UTF-8
LC_ALL is not set in ENV, set to en_US.UTF-8
Seahub is already running.


# 设置管理员帐号:(重置用户)
docker >: /opt/seafile/seafile-server-6.*/reset-admin.sh

root@11f5e9ad841a:/opt/seafile/seafile-server-6.0.6# ./reset-admin.sh
E-mail address: admin@admin.com
Password:
Password (again):
Superuser created successfully.


# 配置完成, 退出容器:
docker >: exit

# 浏览器访问:
# localhost:8900


```

### 浏览器登录访问:

- [0.0.0.0:8900](http://0.0.0.0:8900/accounts/login/?next=/)

```
# 查看容器状态:
-> % docker ps
CONTAINER ID        IMAGE                           COMMAND                  CREATED             STATUS              PORTS                                                                                                                        NAMES
11f5e9ad841a        jenserat/seafile                "/sbin/my_init"          3 hours ago         Up 3 hours          0.0.0.0:10001->10001/tcp, 0.0.0.0:12001->12001/tcp, 0.0.0.0:8900->8000/tcp, 0.0.0.0:8980->8080/tcp, 0.0.0.0:8982->8082/tcp   seafile-server

# 关闭容器:
-> % docker stop seafile-server

# 启动容器:
-> % docker start seafile-server


```


### 常用配置参数修改:

- [seafile.conf 配置 ](https://manual-cn.seafile.com/config/seafile-conf.html)
- /opt/seafile/conf/seafile.conf


- 上传/下载大小限制：

```
[fileserver]
port=8082
#port=10062

###################################

[history]
# 文件修改历史保存期限（单位为“天”）
keep_days = 150


[quota]
# 用户默认空间上限
# 单位为 GB
default = 20


[fileserver]
# 上传文件最大为2000M.
max_upload_size=2000

# 最大下载目录限制为2000M.
max_download_dir_size=2000


```

- 邮件通知配置:
- [发送邮件提醒](https://manual-cn.seafile.com/config/sending_email.html)

```

# QQ 邮箱示例:

EMAIL_USE_TLS = False
EMAIL_HOST = 'smtp.exmail.qq.com'
EMAIL_HOST_USER = 'username@domain.com'
EMAIL_HOST_PASSWORD = 'password'
EMAIL_PORT = '25'
DEFAULT_FROM_EMAIL = EMAIL_HOST_USER
SERVER_EMAIL = EMAIL_HOST_USER

```





## 参考:

- [云服务器之个人云存储的搭建(docker+seafile)](http://www.jianshu.com/p/bd4b55b6d0cd)















