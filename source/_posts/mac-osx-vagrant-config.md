title: Mac配置Vagrant
date: 2015-08-14 16:12:10
categories: Tools
tags: [Mac, Vagrant]
---
记录Mac配置Vagrant过程,已经遇到的问题解决.

<!-- more -->

## vagrant介绍

## vagrant安装过程

网上有很多详细的教程,跟着步骤一步步走,基本不会错.
但是我在最后一步出了问题,特别记录下来.以备后人.
主要是这个问题,google了一圈,也没找到解答.


## 配置过程:

```bash
1. 下载box文件

2. 切换到box文件目录下. 初始化

vagrant box add "ubuntu_14.04" ubuntu-14.04.box   # 添加box, 指定名字为ubuntu14.04. , 后面的是当前目录下的box文件.


3. 查看已经添加至系统的box:
vagrant box list

4. 初始化某个box:
vagrant init "ubuntu_14.04"   # 指定名称,非base方式.

成功初始化后,在当前目录生成一个 Vagrantfile的文件
  

5. 启动虚拟机.

vagrant up


```

## 问题重现:

当我配置好,执行到 $ vagrant up 之后,一切都是正常的.

然后,再执行 $ vagrant ssh, 就始终报错.

信息如下:

```bash
$ vagrant ssh
ssh: Could not resolve hostname ubuntu: nodename nor servname provided, or not known


```

出现该错误,我第一反应,是vagrant的配置有误.就花了很久来找问题解决办法,而方向是vagrant.
把网上找得到所有相关的解决办法,都尝试一遍,依然无解.
实在是要放弃了.结果想想看看.ssh目录吧.
然后看到有个config文件. cat查看内容.

```bash
$ cd ~/.ssh

Users/XXX/.ssh $ ls
authorizedkeys iKey idboot2docker.pub id_rsa.pub
config idboot2docker idrsa known_hosts

$ cat config
Host 127.0.0.1
hostname ubuntu
user root


```

## 解决办法:

然后,就发现玄机.问题就出在这个config里配置了无效的hostname.
黑线...实在不记得配置这个config的缘由了.

然后,删除该config之后.

再次切换到vagrant的虚拟机目录.执行

```bash
$ vagrant ssh
Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-45-generic x86_64)

Documentation: https://help.ubuntu.com/

Last login: Thu Feb 12 10:37:57 2015 from 10.0.2.2
vagrant@vagrant:~$ ls
setuptools-12.1.zip

```

终于正常了.faint.搞了2天,总算是把这个问题解决了.
以后还真是要特别注意,删掉各种无效的配置文件.
指不定什么时候,就坑你一下.




