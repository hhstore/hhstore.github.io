title: Hexo博客优化 - Next主题个性化定制
date: 2015-06-24 21:15:31
categories: Hexo
tags: [Hexo, Next]

---

本篇详细介绍Hexo-Next主题的一些个性化定制.

<!-- more -->



## 1. 添加自定义导航分类(以Next主题为例,其他主题类似)
### 需求:
- 默认自带分类:首页,归档,分类,标签,关于.不够用.
- 想增加一些自定义的分类.
- 本文以添加 `工具(tools)` 分类为例.
- 摸索了半天,修改并不复杂.只需要修改3处地方.

### 修改点:
- iBlog/source/tools/index.md
- iBlog/themes/next/_config.yml
- iBlog/themes/next/languages/zh-Hans.yml

### 步骤:

#### 1. 新建source/tools/index.md文件.
> 在/source/ 文件夹,新建 tools目录,并添加一个index.md文件.可以拷贝其他目录(如tags)中的index.md文件.

#### 2. 修改themes/next/_config.yml文件参数.
> 找到menu标签项, 添加子项:  tools: /tools

- 配置修改:
 
```bash

# when running hexo in a subdirectory (e.g. domain.tld/blog), remove leading slashes ( "/archives" -> "archives" )
menu:
  home: /
  archives: /archives
  categories: /categories
  tags: /tags
  tools: /tools      # 添加位置
  about: /about
  #commonweal: /404.html

```

#### 3. 修改themes/next/languages/zh-Hans.yml
> 该文件,就对应中英文替换.如果漏修改此次.导航栏,就显示英文,很丑.

- 配置修改:
 
```bash
title:
  archive: 归档
  category: 分类
  tag: 标签

menu:
  home: 首页
  archives: 归档
  categories: 分类
  tags: 标签
  tools: 工具       # 添加位置
  about: 关于
  commonweal: 公益404
```

#### 4. 修改完,重新编译部署即可.

```bash
hexo d -g

```




## 2. 添加Fork Me On Github

- 添加`Fork Me On Github`挂件在博客左上角(右上角).官网[可选样式](https://github.com/blog/273-github-ribbons)

### 1. 拷贝Github挂件样式代码如下:

``` html
<a href="https://github.com/you"><img style="position: absolute; top: 0; left: 0; border: 0;" src="https://camo.githubusercontent.com/8b6b8ccc6da3aa5722903da7b58eb5ab1081adee/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f6f72616e67655f6666373630302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_left_orange_ff7600.png"></a>
```
### 2. 修改上述代码中href地址为自己的github地址.

``` html
<a href="https://github.com/you">
改为:
<a href="https://github.com/hhstore">

```

### 3. 修改hexo主题(这里以Next主题为例,不同主题修改略有差异,请注意)

- 修改文件: themes/next/layout/_layout.swig
- 打开_layout.swig文件,找到如下对应位置,添加上述样式代码段即可.

``` html

<!doctype html>
<html class="theme-next {% if theme.use_motion %}use-motion{% endif %} {% if theme.scheme %}theme-next-{{ theme.scheme | lower }}{% endif %}">
<head>
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
</head>


<body>
  {% include '_partials/old-browsers.swig' %}

  <div class="container one-column {% block page_class %}{% endblock %}">
    <div class="headband"></div>
    
    
    <!----------- add Fork me on Github ------------>
    
    <a href="https://github.com/hhstore"><img style="position: absolute; top: 500; left: 0; border: 0;" src="https://camo.githubusercontent.com/8b6b8ccc6da3aa5722903da7b58eb5ab1081adee/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f6f72616e67655f6666373630302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_left_orange_ff7600.png"></a>
    
    <!----------- add Fork me on Github ------------>   
    
    
    <div id="header" class="header">
      <div class="header-inner">
        {% include '_partials/header.swig' %}
      </div>
    </div>

    <!-------------省略------------------->
    <!-------------省略------------------->


    <div class="back-to-top"></div>
  </div>

</body>

</html>

```

## 3. 添加博客访问量统计

- [不蒜子](http://ibruce.info/2015/04/04/busuanzi/)
- [hexo添加访问统计](http://jackroyal.github.io/2015/05/30/hexo-setting-with-comments-and-visitors/)
- 使用不蒜子脚本.
- 修改主题模板,几处地方,效果如本博客.


### 3.1 博文访问量统计修改点:(只适用于Next主题,其他主题,参考修改)

```bash

iBlog/themes/next/layout/_macro/post.swig

在<div class="post-header"></div> 中找到<div class="post-meta"></div>
在其中,最末尾处,添加如下代码:(该代码实现,非博客主页,才显示阅读量统计)

        {% if not is_index %}
          <span id="busuanzi_container_page_pv">  |  阅读量 <span id="busuanzi_value_page_pv"></span> 次</span>
        {% endif %}


```




## 4. 添加多说评论
- [Hexo使用多说教程](http://dev.duoshuo.com/threads/541d3b2b40b5abcd2e4df0e9)
- [多说API - 代码显示【文章评论数】方法](http://dev.duoshuo.com/docs/5016427f77cf5fa30500000e)

## 5. 添加站内搜索
- 站内搜索服务: 百度,google.考虑google被墙,建议选择第三方的.
- 第三方站内搜索服务: tinysou/Swiftype 
- [swiftype服务](https://swiftype.com/)
- [tinysou服务](http://doc.tinysou.com/)
- [参考: 动动手指，NexT主题与Hexo更搭哦（基础篇）](http://www.arao.me/2015/hexo-next-theme-optimize-base/)
- 特别提醒: 参考如上文档修改后,如果博客中的swiftype搜索框,无法正常弹出.请注意检查chrome浏览器的广告插件(Adblock Plus),设置成"对当前网站禁用",刷新即可.


## 6. SEO优化

### 6.1 优化title

更改index.swig文件，文件路径是your-hexo-site\themes\next\layout，

```html

将下面代码:

{% block title %} 
  {{ config.title }} 
{% endblock %}

改成:

{% block title %} 
  {{ config.title }} - {{ theme.description }} 
{% endblock %}

```

- 首页标题,会更符合 "网站名称 - 网站描述" 这习惯。


### 6.2 进阶: seo优化，在Title中显示关键词

```html
{% block title %} 
  {{ theme.keywords }} - {{ config.title }} - {{ theme.description }} 
{% endblock %}
```

- 注意：别堆砌关键字，整个标题一般不超过80个字符，可以通过chinaz的seo综合查询检查。


## 7. 添加友情链接

- [参考](http://zipperary.com/2013/05/30/hexo-guide-4/)


## 8. 添加最近访客

- [动动手指，给你的Hexo站点添加最近访客（多说篇）](http://www.arao.me/2015/hexo-next-theme-optimize-duoshuo/)

## 9. 博客迁移至gitcafe

- [gitcafe](https://gitcafe.com/)
- 参考: [《托管博客到gitcafe》](http://zipperary.com/2013/11/23/hexo-to-gitcafe/)
- 由于 Google 被大陆屏蔽，Github 从大陆访问也比较慢，且不太稳定。
- 考虑把 Blog 迁移到国内，Gitcafe提供的免费 Page 服务，方便迁移。
- 建议把 google 提供的 jquery 和 fonts api 全换掉。
- 由于不同的主题其位置不同，最好是搜索一下。


## 10 博文中添加图片,音乐,视频.

- [参考](http://zipperary.com/2013/06/27/media-on-hexo/)


## 11. 博客绑定二级域名

- 待更新.





