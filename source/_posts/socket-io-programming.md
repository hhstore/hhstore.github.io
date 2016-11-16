title: "网络编程socket IO核心概念对比: 阻塞,非阻塞,同步,异步, select, epoll"
date: 2016-08-24 22:12:10
categories: Tools
tags: [socket, select, epoll]
---
本篇介绍 socket 编程最核心的概念区别.

<!-- more -->

## 高质量参考:

- [Unix 网络编程 - 第6章]()
    - 权威参考,网上各种博客,大都摘抄自此.
- [Linux/Unix 系统编程手册-  第63章]()
- [IO - 同步，异步，阻塞，非阻塞 （亡羊补牢篇）](http://blog.csdn.net/historyasamirror/article/details/5778378)
- [Linux IO模式及 select、poll、epoll详解](https://segmentfault.com/a/1190000003063859)
    - 写的比较通俗
- [tornado源码解析之IOLoop](http://python.jobbole.com/86097/)



## socket 编程几个核心概念:

- 阻塞: blocking
- 非阻塞: non-blocking
- 同步: synchronous
- 异步: asynchronous


## IO模式:

- IO 读两阶段:
    - 1. 等待数据准备 (Waiting for the data to be ready)
    - 2. 将数据从内核拷贝到进程中 (Copying the data from the kernel to the process)
- 由此产生的5种网络模式:
    - 阻塞 I/O（blocking IO）
    - 非阻塞 I/O（nonblocking IO）
    - I/O 多路复用（ IO multiplexing）
    - 信号驱动 I/O（ signal driven IO）: 不常用,略过.
    - 异步 I/O（asynchronous IO）


## 核心总结:

- 阻塞 I/O（blocking IO）: IO 两阶段都阻塞
- 非阻塞 I/O（nonblocking IO）: 
    - 命名不精确, 精确定义应为: 部分阻塞,部分非阻塞
- I/O 多路复用（ IO multiplexing）: 
    - 常说的 select，poll，epoll，有些地方也称这种IO方式为event driven IO
    - 关于 select:
        - select 相当于一个`代理中介`, 进程在调用 select()函数时,被 block, 
        - 而之后 select(poll, epoll 等)函数 会不断的轮询所负责的所有socket，当某个socket有数据到达了，就通知用户进程。
    - select/epoll的优势并不是对于单个连接能处理得更快，而是在于能处理更多的连接。
    - 如果处理的连接数不是很高的话，使用select/epoll的web server不一定比使用multi-threading + blocking IO的web server性能更好，可能延迟还更大。
- 异步 I/O（asynchronous IO）:
    - linux下的asynchronous IO其实用得很少
    

## 区别:

- 同步 IO(synchronous IO):
    - blocking IO，non-blocking IO，IO multiplexing都属于synchronous IO。
    - 关于non-blocking IO:
        - non-blocking IO 在执行recvfrom这个system call的时候，如果kernel的数据没有准备好，这时候不会block进程。
        - 但是，当kernel中数据准备好的时候，recvfrom会将数据从kernel拷贝到用户内存中，这个时候进程是被block了，在这段时间内，进程是被block的。
    - 同步: 都是阻塞的,只是阻塞的阶段不同(部分阻塞 vs 完全阻塞)
- 异步 IO (AIO):
    - 当进程发起IO 操作之后，就直接返回再也不理睬了，直到kernel发送一个信号，告诉进程说IO完成。
    - 在这整个过程中，进程完全没有被block。
    - 异步: 才是真正的非阻塞





