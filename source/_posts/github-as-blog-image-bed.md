title: "Github + Hexo 搭建博客教程: 使用 Github 本身做图床"
date: 2016-08-12 10:12:10
categories: Tools
tags: [Github, Hexo, Blog]
---
本篇介绍如何使用 github 做博客图床.

<!-- more -->


## 1. 参考文档:
- [hexo使用github作为图片链接源](http://pein0119.github.io/2014/08/03/hexo%E4%BD%BF%E7%94%A8github%E4%BD%9C%E4%B8%BA%E5%9B%BE%E7%89%87%E9%93%BE%E6%8E%A5%E6%BA%90/)


## 2. 图床常规选择:

- 微博
- 七牛
- github 本身


## 3. 使用 github 本身做图床:

- 考虑不喜欢用微博, 用七牛又嫌麻烦.
- 博客配图比较少, 索性研究一下如何用 github 本身做图床.
- 如下操作前提: 假定是用 github + hexo 搭建的博客.


### 3.1 创建图片目录:

```

# 博客目录, 终端命令行:
hexo new page image

```

### 3.2 并在此目录下, 新建: 2016/08 目录, 并添加测试图片.

- 图片目录: images/2016/08
- 图片引用 URL 头: https://github.com/hhstore/hhstore.github.io/blob/master/your-images-dir
    - 注意必须拼接: /blob/master, 至于为何是 blob, 暂时不明. 
- 图片引用 URL 尾: ?raw=true  
- 必须拼接 URL 尾巴, 否则无法正常显示


示例图片 URL: 

```
https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/08/20160812-001.jpg

```


### 3.3 测试引用效果:


- 有效引用:
![测试图片](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/08/20160812-001.jpg?raw=true)


- 无效引用(缺少 ?raw=true 拼接):
![测试图片](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/08/20160812-001.jpg)

