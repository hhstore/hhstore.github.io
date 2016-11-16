title: ubuntu安装配置软件
date: 2015-06-26 21:59:03
categories: Ubuntu
tags: [Ubuntu, Linux]
---
本篇介绍重装Ubuntu后所需要作的完整配置过程,非常详尽,并持续更新.

<!-- more -->

## 0. 初始化设置
```bash
1. 设置语言
2. 设置分辨率
3. 设置输入法
4. 设置内存,磁盘,CPU等
```
### 0.1 更改root密码
```bash
默认root密码是随机的，即每次开机,都有一个新的root密码。

修改方式:
sudo passwd  # 提示输入当前用户密码.
enter后,提示我们输入新的密码并确认,此密码即为root密码.
su root  # 切换root用户


```


## 1. 更改下载源

+ [源列表](http://wiki.ubuntu.org.cn/%E6%BA%90%E5%88%97%E8%A1%A8)


### 1. 更改源列表
```bash

1. 首先备份源列表(for sure):
sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup

2. 而后用gedit或其他编辑器打开:
sudo gedit /etc/apt/sources.list


```
### 2. 源列表内容

- 补充: 香港的源,速度也挺快(广东这边可选)

- 1.阿里云更新服务器（北京万网/浙江杭州阿里云服务器双线接入）

```bash

deb http://mirrors.aliyun.com/ubuntu/ utopic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ utopic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ utopic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ utopic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ utopic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ utopic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ utopic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ utopic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ utopic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ utopic-backports main restricted universe multiverse


```
- 2.网易163更新服务器（广东广州电信/联通千兆双线接入）

```bash

deb http://mirrors.163.com/ubuntu/ utopic main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ utopic-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ utopic-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ utopic-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ utopic-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ utopic main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ utopic-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ utopic-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ utopic-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ utopic-backports main restricted universe multiverse

```


## 2. 安装常用软件
### 2.1 安装deb包
+ [搜狗输入法]()

### 2.1 apt-get安装

```bash

    sudo apt-get update
    sudo apt-get install -y vim zsh git curl wget nginx

 
    sudo apt-get install -y docky    # 类似Mac的dock效果
    sudo apt-get install -y python-pip


    # java8, pycharm
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install -y oracle-java8-installer


3. ab
```

### 2.3 删除unity,安装Mate Desktop(Gnome x2分支)

+ [参考文档](http://www.tecmint.com/remove-unity-and-install-cinnamon-and-mate-desktop-in-ubuntu-14-10/)

```bash

1. 删除unity(可以不删除,只执行安装步骤)

sudo apt-get remove unity unity-asset-pool unity-control-center unity-control-center-signon unity-gtk-module-common unity-lens* unity-services unity-settings-daemon unity-webapps* unity-voice-service

2. 安装Mate 

sudo apt-get update
sudo apt-get install mate-desktop-environment-core


3. 安装Mate插件
sudo apt-get install mate-desktop-environment-extra    # 安装插件


4. 安装结束后,"注销"系统,在登录窗口,注意"选择登录GUI",选择mate,输入密码登录即可.

```





## 3. 配置开发环境

### 3.1安装配置zsh,替换系统bash

```bash
1.安装zsh,git,wget
sudo apt-get install zsh git wget

2.获取并自动安装oh-my-zsh
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

3.替换bash为zsh
chsh -s /bin/zsh

4.修改zsh配置文件.(略)

5.重启系统后,更改默认shell为zsh
sudo reboot

6.显示当前使用的shell版本,确认已启用.
echo $SHELL

```
- 切换到用户根目录下。

```bash
cd ~
vim .zshrc

```
- .zshrc文件内容修改：

```bash
# 修改 zsh 主题
ZSH_THEME="maran"

# 插件高亮效果
plugins=(python pep8 pip ruby docker brew brew-cask bundler git git-flow gnu-utils osx gem perl rails rvm mercurial svn macports osx virtualenvwrapper django)

```





### 3.2配置由宿主Mac机通过SSH登录VMware中的ubuntu

+ [参考文档](https://www.daydreamqian.cc/macosx%E4%B8%8B%E9%80%9A%E8%BF%87ssh%E8%BF%9E%E6%8E%A5vmware%E4%B8%ADlinux%E7%9A%84%E8%99%9A%E6%8B%9F%E6%9C%BA/)

#### 1.ubuntu下配置
```bash
1. 确认ubuntu下已安装openssh-server
sudo apt-get install openssh-server

2.查看SSH服务是否打开.
ps -e | grep ssh    # 如果看到sshd说明ssh服务已经打开

3.如无sshd服务,输入如下命令启动服务.再次输入上述命令查看.
sudo /etc/init.d/ssh start

4.输入ifconfig命令,查看虚拟机IP.
ifconfig  # 回车显示: eth0 中 inet地址:172.16.2.132 即为虚拟机IP.

```
#### 2.Mac下配置

```bash

1.在Mac的终端下.PING此虚拟机IP.
ping 172.16.2.132  # Mac终端中,提示ping的通.即为OK.

2.在Mac终端下,通过ssh访问linux虚拟机，输入如下命令:
ssh ubuntu-username@172.16.2.132    # ubuntu-username 替换为:虚拟机用户名.

如果用户名和IP无误,首次会提示"是否确认要连接该IP主机",输入"y".
确认后,提示输入ubuntu主机密码.密码正确,就可以登录ubuntu的主机,进行操作.
(只有第一次要确认,以后只需输入虚拟机ubuntu账号密码.)

```



### 3.3更新 Python 的pip 源

- 安装 pip
```
apt-get install python-pip
```

- 更改 pip 源镜像为阿里云。

```
# 阿里云,添加pip阿里云镜像pypi.
mkdir -p ~/.pip
touch ~/.pip/pip.conf
```

在pip.conf文件中,添加如下配置:

```
[global]
trusted-host = mirrors.aliyun.com
index-url = http://mirrors.aliyun.com/pypi/simple/

```


### 3.4配置python开发环境

```bash

    sudo pip install flask
    sudo pip install tornado

```



## 4. 查看并kill进程

+ [命令收藏,全面](http://blog.csdn.net/wojiaopanpan/article/details/7286430)

```bash

ps -e                # 查看所有进程
pgrep  firefox       # 查看僵死进程ID

sudo kill PID         # 杀死进程
sudo kill APP_NAME    # 采用软件名称,杀死
sudo kill -9 PID      # 强力杀死



1、ps                                             
显示进程信息，参数可省略 
-aux    以BSD风格显示进程 常用
-efH    以System V风格显示进程
-e , -A 显示所有进程
a         显示终端上所有用户的进程
x         显示无终端进程
u         显示详细信息
f          树状显示
w        完整显示信息
l          显示长列表



```



## 5. 添加 Linux 用户,并赋予管理员权限


- 添加用户:

```bash

sudo adduser hhstore

提示输入用户密码:
输入后,回车

提示输入用户资料: 一路回车即可.

这个信息是否正确？ [Y/n] y




```


- 给用户添加管理员权限:

修改文件如下：
sudo vim /etc/sudoers



```
# User privilege specification
root    ALL=(ALL) ALL
hhstore ALL=(ALL) ALL    # 新增用户


```


