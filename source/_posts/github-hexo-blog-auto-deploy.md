title: "使用Travis CI自动部署你的Hexo博客到Github"
date: 2016-11-15 21:15:31
categories: Hexo
tags: [Hexo, Next, github, blog, TravisCI]

---

本篇详细介绍使用 Travis CI 自动部署 Hexo 博客到 Github.

<!-- more -->

## 部署提醒:

- 参考下面那篇博客部署, 基本没问题.
- 需要注意, 有个小坑:
- .travis.yml 文件里最后的 git 仓库访问配置是 HTTTPS 方式, 不是 GIT 方式.
- 详细的可参考我博客仓库: [blog_source](https://github.com/hhstore/hhstore.github.io/tree/blog_source) 分支里的配置文件.


## 参考:

- [手把手教你使用Travis CI自动部署你的Hexo博客到Github上](http://www.jianshu.com/p/e22c13d85659)
    - 参考此博客配置, 没有任何问题.
- 对 博客分支, token 环境变量, 修改了下.

