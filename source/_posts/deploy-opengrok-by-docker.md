title: "使用 Docker 部署 opengrok"
date: 2016-11-21 15:12:10
categories: Docker
tags: [Docker, opengrok, code-reading]
---
本篇介绍: 通过 Docker 部署 opengrok.

<!-- more -->

## OpenGrok 简介:

- OpenGrok特点:
    - OpenGrok 是 一套开源的源码阅读工具, B/S 架构.
    - 需要搭建服务器, 通过浏览器方式访问.
- 部署方式:
    - 鉴于部署过程略繁琐, 且在 Mac/Windows 平台下, 不如 Linux 方便
    - 很自然想到使用 docker 来解决.
- [OpenGrok](http://opengrok.github.io/OpenGrok/)
- 其他源码阅读工具:
    - IDE:
        - VS (win, 近期有 Mac 版本要放出)
        - JB 家全家桶 (跨平台)
        - eclipse (跨平台)
    - source insight (win)
- [有没有好的大型项目代码浏览工具？- 知乎](https://www.zhihu.com/question/33505693/answer/132224974)
    - 此回答, `韦大`安利.
    - 顺手来测试一下效果.


## docker 镜像拉取:

- [docker-opengrok 镜像地址:](https://store.docker.com/community/images/scue/docker-opengrok)
    - [docker-opengrok - github](https://github.com/scue/docker-opengrok)
    - 参考说明文档
- 国内直接拉取 docker 官方 store 的镜像非常慢.使用国内加速器. 
    - [daocloud - 配置 Docker 加速器](https://www.daocloud.io/mirror#accelerator-doc)
        - 本文使用 daocloud 加速拉取, 仅保证当前 daocloud 服务是 OK 的.
        - 如不可用, 可尝试国内其他几家代理加速.
    - [网易-DockerHub镜像加速](https://c.163.com/wiki/index.php?title=DockerHub%E9%95%9C%E5%83%8F%E5%8A%A0%E9%80%9F)
    - [阿里云加速](http://blog.csdn.net/bwlab/article/details/50542261)

```bash

# 镜像拉取:
docker pull scue/docker-opengrok:latest

# 使用 daocloud 代理加速拉取, 比想象的快.
# 查看拉取结果:
-> % docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
scue/docker-opengrok        latest              93c3cb01d8cb        15 months ago       387 MB


```

## 部署:

### 启动容器:


```bash

# 运行一次, 退出时,自动删除容器:
#   - 此容器, 默认挂载了源码目录, 自动建索引
#   - 注意:
#       - 此镜像构建的容器, 当挂载了源码目录, 会自动建索引
#       - 故不要挂载太大的目录, 不然建索引很慢.
#       - 非常耗 CPU.
sudo docker run --rm \
    -v /path/to/source:/src \
    -v /path/to/opengrok_data:/data \
    -p 8888:8080 \
    scue/docker-opengrok


###################################################
#          容器启动方式 1: 运行完, 自动删除
# 适合:
#   - 单个项目阅读
#
# 挂载目录:
#   - 项目源码目录: /Users/hhstore/iGit/iGitRepoRead
#   - 索引目录: /Users/hhstore/iGit/iSpace/iDocker/shareDir/opengrok
#
###################################################
sudo docker run --rm \
    -v /Users/hhstore/iGit/iGitRepoRead/iPython/Libs/aiohttp:/src \
    -v /Users/hhstore/iGit/iSpace/iDocker/shareDir/opengrok:/data \
    -p 8889:8080 \
    scue/docker-opengrok


docker run  --name opengrok-server \
    -v /Users/hhstore/iGit/iGitRepoRead:/src \
    -v /Users/hhstore/iGit/iSpace/iDocker/shareDir/opengrok:/data \
    -p 8888:8080 \
    -d scue/docker-opengrok 


###################################################
#          容器启动方式 2: 长期保持
# 适合:
#   - 批量项目阅读
#   - 建索引非常耗时, 耗 CPU
#
# 挂载目录:
#   - 项目源码目录: /Users/hhstore/iGit/iGitRepoRead
#   - 索引目录: /Users/hhstore/iGit/iSpace/iDocker/shareDir/opengrok
###################################################

# 后台进程方式启动:
docker run  --name opengrok-server \
    -v /Users/hhstore/iGit/iGitRepoRead:/src \
    -v /Users/hhstore/iGit/iSpace/iDocker/shareDir/opengrok:/data \
    -p 8888:8080 \
    -d scue/docker-opengrok 

# 浏览器查看是否正常启动

###################################################
#               容器中处理:
###################################################
# 登录到已创建容器:
docker exec -it opengrok-server bash

# 容器中操作:
root@0a75d4fe98d1:/usr/local/tomcat# pwd
/usr/local/tomcat

# 切换到 opengrok 目录:
cd /opengrok*
root@0a75d4fe98d1:/opengrok-0.12.1.5#

# 容器中源码目录为:
#   - /src 下
#   - 示例目录: /src/iPython/Libs/aiohttp

# 源码初始化索引:
/opengrok-0.12.1.5/bin/OpenGrok index /src

# 单个具体项目源码:
/opengrok-0.12.1.5/bin/OpenGrok index /src/iPython/Libs/aiohttp

```

### 浏览器访问:

```
# 浏览器:
http://localhost:8888/.

#
http://localhost:8888/source/

```

- docker 容器启动成功
![效果图](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/11/20161121-001.png?raw=true)

- 项目源码阅读目录:

![效果图](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/11/20161121-002.png?raw=true)

- 代码阅读效果:

![效果图](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/11/20161121-004.png?raw=true)


### 容器关闭/清理:

```bash

# 查看:
-> % docker ps
CONTAINER ID        IMAGE                  COMMAND               CREATED             STATUS              PORTS                    NAMES
0a75d4fe98d1        scue/docker-opengrok   "/scripts/start.sh"   5 hours ago         Up 5 hours          0.0.0.0:8888->8080/tcp   opengrok-server

# 退出:
-> % docker stop opengrok-server
opengrok-server

# 删除容器:
#   - 并不会删除源代码挂载目录
-> % docker rm -v opengrok-server
opengrok-server

```



## 示例访问项目:

- [aiohttp - github](https://github.com/KeepSafe/aiohttp/)
    - [aiohttp - 官方文档](http://aiohttp.readthedocs.io/en/stable/)
    - python 项目
    - git clone 方式获取.
    - docker 中对应路径: `/src/iPython/Libs/aiohttp`
    - 注意`opengrok` 建立好索引之后的目录结构, 与此对应
- 原本以为需要单独在容器中启动建索引命令, 后发现该 image 会自动执行.

- 示例项目目录截图:
![效果图](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/11/20161121-003.png?raw=true)



## 总结:

- 使用体验并没有比 source insight / understand / pycharm 等JB 全家桶更好.
- 优点:
    - 浏览器打开, 似乎是可以iPad, 手机等阅读? (意义不大)
    - 搜索功能比较完善, 不过还不是 语义分析, 跟 pycharm 比, 弱爆
    - 对 PHP, Ruby 等支持较好
- 缺点:
    - 当前版本, 对 Python 支持并不好, 对 Golang 不支持(计划在下一版本中)
    - Python, Nodejs 等项目, 需要从项目根目录开始建索引.(不友好)
    - 索引资源, 几百 MB 吧. 并不比 pycharm 等好到哪里去.
- 对于新工具, 要去了解, 尝试.
    - 只有使用之后, 才有发言权.
    - 究竟是更好, 还是没那么好. 用过才知道.
    - 探索的过程, 哪怕并没有预期那么好, 也仍然是有收获的.
- 综合评价:
    - 当前的版本, 仍然不值得用.
    - 对比: pycharm 等, 无明显亮点.

## 参考:
- [Ubuntu下OpenGrok的安装配置](http://www.voidcn.com/blog/u013656962/article/p-6131858.html)






