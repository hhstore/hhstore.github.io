title: MongoDB学习笔记
date: 2015-06-27 22:03:41
categories: DB
tags: [MongoDB, SQL, NoSQL]
---
本篇介绍MongoDB学习笔记,会持续更新.

<!-- more -->

+ MongoDB是一种文件导向数据库管理系统，由C++撰写而成，以此来解决应用程序开发社区中的大量现实问题。
+ MongoDB可以从开放源代码来建构与安装，更常见的是安装binary文件，目前有Windows, Linux, OS X和Solaris版本。
+ 官方驱动: [PyMongo](https://github.com/mongodb/mongo-python-driver) 
+ 官方文档,写的非常好.详细全面.不需要再查二手资料.

# 第一部分 安装运行MongoDB

## 1.安装(Mac OS X)

+ [官方文档: Mac OS X安装](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)

```bash
方式1: homebrew方式
brew update
brew install mongodb
brew install mongodb --with-openssl   # 安装TLS/SSL支持
brew install mongodb --devel          # 安装最新开发版

方式2: 安装2进制包
curl -O https://fastdl.mongodb.org/osx/mongodb-osx-x86_64-3.0.4.tgz
tar -zxvf mongodb-osx-x86_64-3.0.4.tgz
mkdir -p mongodb
cp -R -n mongodb-osx-x86_64-3.0.4/ mongodb
export PATH=<mongodb-install-directory>/bin:$PATH
```

## 2.运行

### 1.创建数据库路径.

```bash
mkdir -p /data/db  # 默认mongod进程使用 /data/db 作默认路径

```

### 2.设置权限,允许mongod访问该路径.
+ 在运行mongod之前,确保用户对该数据库路径有读写权限.

```bash
cd /
sudo chmod 755 /data/

```

### 3.运行MongoDB

#### 1) 执行

+ 若已添加至系统环境变量PATH中,运行如下命令:

```bash
sudo mongod # 默认MongoDB存储路径
sudo mongod --dbpath <path to data directory>  # 指定自定义路径
```

+ 若未添加至系统环境变量PATH,需要执行:

```bash
sudo <path to binary>/mongod  # 完整的MongoDB安装路径

```

#### 2) 正常运行,显示提示信息:

+ 含端口号等信息

```bash
2015-06-19T11:17:00.463+0800 I JOURNAL  [initandlisten] journal dir=/data/db/journal
2015-06-19T11:17:00.464+0800 I JOURNAL  [initandlisten] recover : no journal files present, no recovery needed
2015-06-19T11:17:00.480+0800 I JOURNAL  [durability] Durability thread started
2015-06-19T11:17:00.480+0800 I JOURNAL  [journal writer] Journal writer thread started
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten] MongoDB starting : pid=918 port=27017 dbpath=/data/db 64-bit host=hhstore-rMBP15.local
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten] ** WARNING: You are running this process as the root user, which is not recommended.
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten]
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten]
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten] ** WARNING: soft rlimits too low. Number of files is 256, should be at least 1000
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten] db version v3.0.3
2015-06-19T11:17:00.480+0800 I CONTROL  [initandlisten] git version: nogitversion
2015-06-19T11:17:00.481+0800 I CONTROL  [initandlisten] build info: Darwin yosemitevm.local 14.3.0 Darwin Kernel Version 14.3.0: Mon Mar 23 11:59:05 PDT 2015; root:xnu-2782.20.48~5/RELEASE_X86_64 x86_64 BOOST_LIB_VERSION=1_49
2015-06-19T11:17:00.481+0800 I CONTROL  [initandlisten] allocator: system
2015-06-19T11:17:00.481+0800 I CONTROL  [initandlisten] options: {}
2015-06-19T11:17:00.661+0800 I NETWORK  [initandlisten] waiting for connections on port 27017

```

### 4.结束运行.
+ 部署生成环境 [参考](http://docs.mongodb.org/manual/administration/production-notes/)

```bash

终端输入快捷键:
Control+C, 结束运行.

```

# 第二部分 CRUD(增删改查)
+ [参考](http://docs.mongodb.org/manual/core/crud-introduction/)
+ [python版参考](http://docs.mongodb.org/getting-started/python/)


## 1.导入数据
```bash
mongoimport --db test --collection restaurants --drop --file primer-dataset.json

```

## 2.安装python版本的驱动(PyMongo)

```bash
sudo pip install pymongo
```

## 3.python示例

```python

from pymongo import MongoClient  # 导包

client = MongoClient()          # 创建连接
client = MongoClient("mongodb://mongodb0.example.net:27019")  # 带 MongoDB URI参数

db = client.primer
db = client['primer']


db.dataset
db['dataset']

coll = db.dataset
coll = db['dataset']



```
## 4.Insert 插入数据
+ [参考](http://docs.mongodb.org/getting-started/python/insert/)


+ 连接测试数据库

```python

from pymongo import MongoClient

client = MongoClient()
db = client.test


```
+ 插入一个文档数据

```python
from datetime import datetime
result = db.restaurants.insert_one(
    {
        "address": {
            "street": "2 Avenue",
            "zipcode": "10075",
            "building": "1480",
            "coord": [-73.9557413, 40.7720266]
        },
        "borough": "Manhattan",
        "cuisine": "Italian",
        "grades": [
            {
                "date": datetime.strptime("2014-10-01", "%Y-%m-%d"),
                "grade": "A",
                "score": 11
            },
            {
                "date": datetime.strptime("2014-01-16", "%Y-%m-%d"),
                "grade": "B",
                "score": 17
            }
        ],
        "name": "Vella",
        "restaurant_id": "41704620"
    }
)
```
+ 属性

```bash
result.inserted_id
ObjectId("54c1478ec2341ddf130f62b7")
```

# 5.Find,Query查询数据

+ [参考:示例非常详尽](http://docs.mongodb.org/getting-started/python/query/)


```python
from pymongo import MongoClient

client = MongoClient()
db = client.test


cursor = db.restaurants.find()
for document in cursor:
    print(document)
    
{ <field1>: <value1>, <field2>: <value2>, ... }

cursor = db.restaurants.find({"borough": "Manhattan"})
for document in cursor:
    print(document)


```

+ 对结果排序

```python
import pymongo
cursor = db.restaurants.find().sort([
    ("borough", pymongo.ASCENDING),
    ("address.zipcode", pymongo.DESCENDING)
])

for document in cursor:
    print(document)

```


```python
```

```python
```


```bash
```
