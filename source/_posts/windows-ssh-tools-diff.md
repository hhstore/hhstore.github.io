title: "Windows-SSH远程登录软件对比"
date: 2015-08-05 22:12:10
categories: Tools
tags: [Windows, SSH]
---
本篇介绍windows下的SSH远程登录软件.

<!-- more -->

## 1. SSH登录软件

经常需要在windows下,远程连接 虚拟机里的(ubuntu),或者阿里云的云主机(Linux系统).
把主流SSH软件都测试一遍,效果对比如下.


| 软件|类型|特点|推荐度|
|:---|:---|:---|:---|
|Putty|商业|太简陋,而且网上各种破解版有病毒,慎用.| 1星|
|WinSCP|免费|搭配Putty使用,自带功能太弱.| 1星
|Xshell|开源|在某些配置vim下,会出现光标定位不准确的问题.极难使用| 2星|
|SecureCRT|商业|功能蛮强大,只是配色太丑.| 3星|
|[MobaXterm](http://mobaxterm.mobatek.net/download.html)| 个人版免费|功能强大,各种酷炫的功能,下面详细介绍| 5星推荐|
|[Bitvise](http://www.bitvise.com/download-area#)| 个人版免费|带FTP功能| 4星推荐
|Cygwin|--| 知乎讨论,有些人用,有点像bitvise的窗口风格| 3星|



## 2. 初步筛选MobaXterm和MobaXterm值得推荐.

- MobaXterm: 非常推荐,测试效果非常满意.
- Bitvise: 自带FTP功能,非常实用,除了终端窗口是windows默认风格,不太满意.其他都挺好.


## 3. 重点介绍MobaXterm

### 说明:
通过MobaXterm进行远程终端链接，你可以创建 SSH, Telnet, Rlogin, RDP, VNC, XDMCP, FTP, SFTP or 串口等链接。你的每次链接都会自动保存并且出现在左侧链接窗口中。


### 亮点:

- 自动保存SSH账号,密码.
- 可以打开N个登陆窗口.
- 窗口高亮,代码高亮.UI配色漂亮.
- 自带SFTP服务,甚至可以跟踪命令窗口,随时切换显示当前目录下文件列表.支持拖放上传文件.
- 分屏显示,方便管理多台服务器，并且你可以仅输入一次，让一条命令同时在这些不同的服务器终端执行
- 内置文本编辑器,可以打开 远程主机的 文件,进行编辑,修改,保存.强大到不能忍.
- 通过 RDP 协议,远程链接,并控制你的windows电脑.(类似QQ远程连接,方便)
- 在Windows 电脑上，通过XDMCP协议，远程控制Solaris 桌面系统。
- 有很多免费的插件

### 总结:
说了这么多,强力推荐这个软件.非常非常好用.



## 参考

- [Windows 下的免费 SSH 客户端工具](https://linux.cn/article-5468-1.html)
- [全能型开源远程终端MobaXterm](http://jingxuan.io/?p=182)
- [MobaXterm下载](http://www.xdowns.com/soft/6/99/2012/Soft_84973.html)
