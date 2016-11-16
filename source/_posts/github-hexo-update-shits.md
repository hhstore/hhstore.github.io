title: "Hexo 部署博客踩坑记录"
date: 2016-11-15 21:15:31
categories: Hexo
tags: [Hexo, Next, github, blog]

---

本篇详细介绍 Hexo 部署博客, 踩坑记录.

<!-- more -->


## 前言:

- 使用 github + hexo 部署的博客1年多, 稳定运行很久.
- 博客访问量也有 5000 +.
- 结果最近本地电脑的目录, 不明原因的被误删除很多文件.
- 部分项目的 lib 出问题, 包括这个博客.
- 结果, hexo 不能用, 想都没想, 就重装了下 hexo, 然后, 像往常一样 `hexo -g d`, 推博客, 推上去, 发现博客挂了.
- 妈蛋, 用 chrome 看了下, 怀疑是 ES6 语法不认的问题.
- 考虑回滚, 结果默默奇妙的发现, 某次 push 之后, github 本参考的 commit 提交记录变成 2条. 之前的 几十条 commit 被吃了!
- what a fuck !

## 问题根源:

- github 自己的 bug.GitHub Pages 更新 Jekyll 3.3
- [What's new in GitHub Pages with Jekyll 3.3](https://github.com/blog/2277-what-s-new-in-github-pages-with-jekyll-3-3)
- 导致 hexo 的 `Next 主题` 插件目录: `venders目录` 被屏蔽, 目录资源变404


## 解决办法:

- `Next 主题`插件, issue 里, 有小伙伴给 github 官方去邮件, 回复解决办法: [issue 1220](https://github.com/iissnan/hexo-theme-next/issues/1220)
- 回顾:[hexo-theme-next : issue1214](https://github.com/iissnan/hexo-theme-next/issues/1214#issuecomment-260843583)
- 看 issue 快爆炸了, 被坑的人不再少数. 莫名喜感.
- [Hexo博客部署到主页只显示部分内容](https://jetyu.github.io/2016/11/04/20161104/)
    - 这哥们是 11-04 号踩坑, 我是15号. ==!
- 折腾这一番, 顺便把 hexo 和 Next 主题等都升级到最新版本了. 增加了些新功能.

## Next v5.0.1 主题配置:

### 配置统计:

- 如下配置, 都可以在新版本通过配置选项开启.
- [不蒜子统计](http://theme-next.iissnan.com/third-party-services.html#analytics-busuanzi)
    - 开启配置选项
- [设置「侧栏」](http://theme-next.iissnan.com/getting-started.html#sidebar-settings)
    - 永久开启侧栏
- [多说评论](http://theme-next.iissnan.com/getting-started.html#comment-system-duoshuo)
- [多说评论显示 UA](http://theme-next.iissnan.com/theme-settings.html#duoshuo-ua)
- [打赏功能](http://theme-next.iissnan.com/theme-settings.html#reward)
    - 微信打赏
- [Swiftype 搜索](http://theme-next.iissnan.com/getting-started.html#search-system-swiftype)
- [腾讯公益404页面](http://theme-next.iissnan.com/theme-settings.html#volunteer-404)


## 参考:

- [Hexo - Next 主题官方文档](http://theme-next.iissnan.com/getting-started.html)





