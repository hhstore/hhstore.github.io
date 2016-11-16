title: "Apache Web 服务器配置网站二级域名"
date: 2016-10-11 22:12:10
categories: Tools
tags: [Apache, web]
---
本篇介绍如何配置 Apache, 设置网站二级域名.


<!-- more -->


## 参考:

- [apache 二级域名设置完整步骤](http://www.voidcn.com/blog/u011447828/article/p-6192616.html)


## 设置:

### 1. 域名解析商解析二级域名:

- 阿里云-万网, 解析域名:
- oa.abc.com    指向 服务器 IP (阿里云主机 IP)
- pms.abc.com   指向 服务器 IP (阿里云主机 IP)



### 2. 主机 Apache 配置:
- 修改: httpd.conf
    - Ubuntu 下路径: /opt/lampp/etc/httpd.conf
- 修改: httpd-vhosts.conf
    - Ubuntu 下路径: /opt/lampp/etc/extra/httpd-vhosts.conf
- 




```bash


➜ cat /etc/hosts
127.0.0.1 localhost
127.0.1.1       localhost.localdomain   localhost

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
10.116.112.62 iZ94l9zg66aZ



# /opt/lampp/etc/httpd.conf



<Directory />
    AllowOverride none
    Require all denied
</Directory>



# 改为:
<Directory />
Options FollowSymLinks
AllowOverride All
Order deny,allow
Deny from all
</Directory>








# Virtual hosts
#Include etc/extra/httpd-vhosts.conf



各个参数含义说明
ServerAdmin  管理员邮箱
DocumentRoot 所需指向路径
ServerName   域名名称
ServerAlias  域名别名 可要可不要
ErrorLog     错误日志
CustomLog    访问日志



# restart:

sudo /opt/lampp/lampp restart



```












