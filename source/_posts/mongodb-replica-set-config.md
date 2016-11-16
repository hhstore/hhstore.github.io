title: MongoDB 开发笔记
date: 2016-06-25 22:12:10
categories:  DB
tags: [mongodb, NoSQL, 高可用]
---
本篇介绍MongoDB 高可用配置和一些重要特性.

<!-- more -->


## MongoDB 高可用配置

- 使用pymongo


参考文档:

官方文档,必看, 看完,就可以配置.

- [High Availability and PyMongo](https://api.mongodb.org/python/current/examples/high_availability.html)


- [MongoClient](https://api.mongodb.org/python/current/api/pymongo/mongo_client.html)


下面这个API可能要废弃, 因为MongoClient 已经包含 MongoReplicaSetClient() 全部功能
- [mongo_replica_set_client](https://api.mongodb.org/python/current/api/pymongo/mongo_replica_set_client.html)




## 两阶段提交2PC


四、缺陷
算法执行过程中，所有节点都处于阻塞状态，所有节点所持有的资源（例如数据库数据，本地文件等）都处于封锁状态。

六、结论
2PC效率很低，分布式事务很难做。


http://chuansong.me/n/1928604



## pool

- [How does connection pooling work in PyMongo?](http://api.mongodb.org/python/current/faq.html#how-does-connection-pooling-work-in-pymongo)



## mongodb 不支持 事务, 解决:

- [五个解决方案让MongoDB拥有RDBMS的鲁棒性事务](http://www.uml.org.cn/sjjm/2014081111.asp?artid=10313)


- [实现事务支持: 源码 - py](https://coding.net/u/tuxpy/p/tmongo/git/blob/master/tmongo.py)


- [MongoDB两阶段提交实现事务](http://www.tuicool.com/articles/f6ZBjm)
