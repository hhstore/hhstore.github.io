title: Python拾遗 - WSGI规范
date: 2015-09-01 17:12:10
categories: Python
tags: [Python]
---

本篇介绍Python的 WSGI 规范.

<!-- more -->

## 1. 关于 WSGI 规范.

### WSGI定义:
- WSGI 全称是Web Server Gateway Interface，翻译是Python Web服务器网关接口。
- 是一个描述Web服务器和Web应用之间如何通信的规范。
- 定义了Web服务器如何与Python应用程序进行交互，使得使用Python写的Web应用程序可以和Web服务器对接起来。
- WSGI一开始是在PEP-0333中定义的，最新版本是在Python的PEP-3333定义的。

### WSGI 和 CGI(FastCGI,SCGI) 区别和联系:
- WSGI 是 Python Web 服务器网关接口，完成不同协议之间的转换工作。
- CGI（Common Gateway Interface）是Web应用程序和Web Server的底层通信协议，是Web开发过程中需要遵守的标准和规范，不同语言如PHP、Java、Python等完成的Web应用程序均依据此通信协议完成与Web Server的交互。
- CGI的设计存在性能缺陷，因为每次Web Server接受请求的时候总要重新开启一个CGI进程，进程的初始化既费时间又耗资源，对于少量请求的情况，可以容忍此开销，但是若遇到了大量的请求，服务器的性能则会非常低下。
- 为了解决CGI的性能缺陷问题，后来出现了 FastCGI 和 SCGI，它们能够有效地解决服务器性能问题，FastCGI不同于CGI的设计之处在于FastCGI要求CGI处理进程常驻内存中，有请求时处理，没有请求时等待，免去了进程初始化带来的开销。SCGI即Simple  CGI，相对FastCGI来说是一种更加简单的实现。目前的Web底层通信机制已经被FastCGI和SCGI所取代。
- WSGI也是为了解决Web应用程序和Web Server之间的交互而提出的一种规范，不过这种规范是以CGI为基础（因为CGI是底层通信协议），位于CGI的上一层更好地去解决应用程序和服务器之间的配合问题。

## 2. WSGI 的用途:
- WSGI相当于是Web服务器和Python应用程序之间的桥梁。
- 让Web服务器,知道如何调用Python应用程序，并且把用户的请求,告诉应用程序。
- 让Python应用程序,知道用户的具体请求是什么，以及如何返回结果,给Web服务器。


## 3. WSGI 的结构:

### 3个角色:
- Web服务器端 称为server或者gateway，
- WSGI Middleware（中间件）
- 应用程序端 称为application或者framework

### 3者关系:
- Server认为middleware是一个application。
- Application认为middleware是一个server。
- Middleware可以有多层。

### 3层解耦:
- Application/Framework层 只需要实现一个callable就可以了；
- Server/Gateway层，只需要把客户端的请求处理成environ，然后传给Application/Framework就可以了；
- Middleware 层，基本上相当于是一个装饰器，同样也是高内聚低耦合的。
- 三个部分之间几乎没有依赖，使得使用Python开发和部署Web应用变得十分灵活。

### WSGI的实现:

- Application端:
    - 实现一般是由Python的各种框架来实现的，比如Django, web.py等，
    - 一般开发者不需要关心WSGI的实现，框架会提供接口，让开发者获取HTTP请求的内容以及发送HTTP响应。

- Server端:
    - 实现会比较复杂一点，这个主要是因为软件架构的原因。
    - 一般常用的Web服务器，如Apache和nginx，都不会内置WSGI的支持，而是通过扩展来完成。
    - Apache服务器，会通过扩展模块mod_wsgi来支持WSGI。Apache和mod_wsgi之间通过程序内部接口传递信息，mod_wsgi会实现WSGI的server端、进程管理以及对application的调用。
    - Nginx上一般是用proxy的方式，用nginx的协议将请求封装好，发送给应用服务器，比如uWSGI，应用服务器会实现WSGI的服务端、进程管理以及对application的调用。


## 4. 扩展阅读.
- 需要完整看完.[WSGI 规范 - PEP333 翻译](https://github.com/mainframer/PEP333-zh-CN)
- [PEP 0333 -- Python Web Server Gateway Interface v1.0](https://www.python.org/dev/peps/pep-0333/)
- [Python Web 服务器网关接口](https://pep-3333-wsgi.readthedocs.org/en/latest/)
- [WSGI - EN](http://wsgi.readthedocs.org/en/latest/)
- 推荐[WSGI简介](http://segmentfault.com/a/1190000003069785)
- [WSGI规范笔记](http://segmentfault.com/a/1190000002717571)
- [廖雪峰 - WSGI接口](http://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386832689740b04430a98f614b6da89da2157ea3efe2000)
- [Python WSGI学习笔记](https://skyline75489.github.io/post/2014-9-8_python-wsgi-learning.html)
- [Python中的WSGI](https://jasonlvhit.github.io/articles/wsgi/)
