title: "使用Travis CI自动部署你的Hexo博客到Github"
date: 2016-11-16 14:15:31
categories: Hexo
tags: [Hexo, Next, github, blog, TravisCI]

---

本篇详细介绍使用 Travis CI 自动部署 Hexo 博客到 Github.

<!-- more -->

## 部署说明:

- 本博客, 当前已成功使用 `Travis CI` 配合 `github` 多分支, 实现自动部署.
- 详细参考我博客仓库: 
    - [blog_source 分支](https://github.com/hhstore/hhstore.github.io/tree/blog_source) 
    - 本分支, 包含博客全部资源文件, 配置文件.

### 博客仓库结构:

- `hhstore.github.io` 仓库:
    - `master` 分支: 自动发布分支, `Travis CI` 自动生成.
    - `blog_source` 分支: 博客源文件.

### 博客发布流程:
    - 本地 git 仓库, 拉取 `blog_source` 分支
    - 在此分支, 编辑博客文档.
    - 推送本地文档, 到 github.
    - `Travis CI` 通过钩子, 自动触发`发布流程`.
    - `Travis CI` 自动把最新博客发布到 `master` 分支.


```bash
# 执行推送, 其他全自动:
git push blog_source blog_source

```

## 部署参考:

- 具体部署过程, 请参考此篇, 步骤非常详细, 没有问题.
    - [手把手教你使用Travis CI自动部署你的Hexo博客到Github上](http://www.jianshu.com/p/e22c13d85659)
- 可参考我博客的 `blog_source` 分支配置文件.

## 部署提醒:

- 个人博客, 对 博客分支的 `token 环境变量`, 作了修改.
- 小坑: 
    - .travis.yml 文件里最后的 git 仓库访问配置是 HTTTPS 方式, 不是 GIT 方式.
