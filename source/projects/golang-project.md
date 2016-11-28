title: Golang Projects
date: 2016-11-28 11:17:10
---


- golang 标准库和第三方库资源, 非常丰富. 代码质量很高.
- 有很多值得学习的项目.
- 读标准库, 读源码.


## 标准库:

- [bytes]()


## 第三方库:

### 数据库:

- [cache2go](https://github.com/muesli/cache2go)
    - 比较简单的一个缓存库，代码量很少，适合新手学习，可以学习到锁、goroutines等。
- [groupcache](https://github.com/golang/groupcache)
    - 与memcached同一作者，相当于是memcached的go语言实现。
- [codis](https://github.com/CodisLabs/codis)
    - 类 redis, 豌豆荚开源
- [LedisDB](https://github.com/siddontang/ledisdb)
    - 类 redis


### orm:

- [xorm](https://github.com/go-xorm/xorm)
  - 作者: 国人
  - 应用: gogs 项目

### 消息队列:

- [nsq](https://github.com/nsqio/nsq)
    - 热门项目
    - 学习一下goroutine和channel的各种使用，消息队列

### 分布式存储方案:

- [minio](https://github.com/minio/minio)
  - 支持 docker 部署
  - [osc-介绍](https://www.oschina.net/p/minio)
  - Minio可以做为云存储的解决方案用来保存海量的图片，视频，文档。
  - 由于采用Golang实现，服务端可以工作在Windows,Linux, OS X和FreeBSD上。
  - 配置简单，基本是复制可执行程序，单行命令可以运行起来。


### 微信, 支付宝 SDK:

- [go-alipay](https://github.com/lunny/alipay)
- [go-wxpay](https://github.com/lunny/weixinpay)



## Web 框架:
- [gin](https://github.com/gin-gonic/gin)
- [macaron](https://github.com/go-macaron/macaron)
    - 作者: 无闻(国人), 文档完善
    - 参考: martini
    - 推荐阅读
- [echo](http://go-echo.org/)
    - 高性能 go web 框架.
    - [echo - github](https://github.com/labstack/echo)
- [revel](https://github.com/revel/revel)
- [martini](https://github.com/go-martini/martini)
  - 设计比较优雅
- [iris-go](https://github.com/kataras/iris)
  - 老外
  
  



## 应用型项目:
- [peach](https://github.com/peachdocs/peach)
    - macaron
    - 学习点:
        - 无数据库
        - 学习如何应用 macaron 框架
        - 熟悉常用包
- [gogs]()
    - 类 gitlab 项目, 完善的代码托管服务器
    - 学习点:
        - ORM 使用
        - macaron 框架应用
        - 模板应用
        - 路由应用
        - 前端框架应用
        - js 等.        
- [leanote](https://github.com/leanote/leanote)
    - 蚂蚁笔记: 高仿印象笔记
    - reverl + mongodb
    - APP 源码:
        - [leanote-android](https://github.com/leanote/leanote-android)
        - [desktop-app](https://github.com/leanote/desktop-app)
    - 官网:http://leanote.com/


## 参考:

- [go语言值得学习的开源项目推荐](http://www.cnblogs.com/baiyuxiong/p/4309934.html)




```bash
# -u 参数: 升级+安装
go get -u gopkg.in/macaron.v1

go get -u github.com/gogits/gogs
go get -u github.com/peachdocs/peach

go get gopkg.in/macaron.v1
go get gopkg.in/gin-gonic/gin.v1


```


