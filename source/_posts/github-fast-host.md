title: "Github 国内加速访问"
date: 2016-11-01 17:12:10
categories: Tools
tags: [github, vpn, host]
---
本篇介绍如何通过修改本机 host, 提升 github 访问速度.

<!-- more -->


## 前述:

- 最近发现 github 访问非常慢.
- 办公网络: 
    - 100M 电信共享, 测试 VPN 访问很慢. git clone 没法用.
    - 100M 联通独享, 测试 VPN 访问很慢. git clone 较快.
- 猜测是 github 的 部分 CDN 被墙了.
- 搜索找到解决办法, 记录如下, 备复查.


## Mac 修改方法:

### 修改 /etc/hosts:

- 特别提醒:
    - 网上找到的 host, 不要轻易添加.
    - 先通过 ping 查看一下. 是否 ping 的通, 且速度是否够快.
    - 添加了 不同的 host IP, 反而会使访问速度更慢.
    - 上述 IP, 是在联通网络下, 访问非常快. 使用前, 请自行测试.
- 添加如下内容:

```

###################################
#       Github:
###################################
103.245.222.249 github.global.ssl.fastly.net

103.245.222.133 assets-cdn.github.com
23.235.47.133   assets-cdn.github.com

185.31.19.133   avatars1.githubusercontent.com

```



### 修改 /etc/resolv.conf

- 添加如下内容:

```

# add for github:
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 114.114.114.114


```

### 刷新 NDS, 使之生效:

```bash
sudo dscacheutil -flushcache
```


## Linux 修改方法:

- 同样修改:
    - /etc/hosts
    - /etc/resolv.conf

- 刷新启动命令:

```bash
sudo /etc/init.d/networking restart
```


## 参考:
- [GitHub加速访问](http://chenxuhua.com/technology/githubjia-su-fang-wen)
- [Github访问很慢的解决方法](http://www.jianshu.com/p/a578963f10f0)
- [GtiHub访问慢解决办法](https://segmentfault.com/a/1190000004171536)

