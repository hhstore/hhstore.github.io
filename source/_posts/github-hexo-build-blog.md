title: "Github + Hexo搭建博客教程"
date: 2015-06-24 21:15:30
categories: Git
tags: [Github, Hexo, Blog, Git, Nodejs]

---

本篇介绍利用Github和Hexo搭建技术博客的详细过程,以及各种优化配置.

<!-- more -->

- 花了一天时间,摸索利用Github+hexo,完成博客的搭建.基本上可用了,把搭建过程整理成博客,发首篇吧.
- 一点体会:建议每个人都把hexo官网文档完整看一遍.有助于更好理解,并配置hexo博客.

## 1.安装
- [hexo官方文档](https://hexo.io/zh-cn/docs/index.html)
- 先行安装 [Node.js](https://nodejs.org/) 和 [Git](http://git-scm.com/)

### 1.1安装Git

- Windows：下载并安装 git.
- Mac：使用 `Homebrew, MacPorts` 或下载 安装程序 安装。

```bash
    brew install git
```

- Linux (Ubuntu, Debian)：

```bash
    sudo apt-get install git-core
```

- Linux (Fedora, Red Hat, CentOS)：

```bash
    sudo yum install git-core
```

### 1.2安装Node.js
安装 Node.js 的最佳方式是使用 nvm。

- cURL:

```bash
$ curl https://raw.github.com/creationix/nvm/master/install.sh | sh
```
- Wget:

```bash
$ wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
```

- 安装完成后，重启终端并执行下列命令即可安装 Node.js。

```bash
$ nvm install 0.10
```
- 或者您也可以下载 应用程序 来安装。

### 1.3安装Hexo

```bash
    
    sudo npm install -g hexo-cli
    sudo npm install hexo --save
    
    针对Mac平台:
    若编译报错,请先到AppStore下载安装`Xcode`.
    安装完,启动并进入 Preferences -> Download -> Command Line Tools -> Install 安装命令行工具。再执行上述命令.
    
```
### 1.4安装Hexo插件

```bash
    sudo npm install hexo-generator-index --save
    sudo npm install hexo-generator-archive --save
    sudo npm install hexo-generator-category --save
    sudo npm install hexo-generator-tag --save
    sudo npm install hexo-server --save
    sudo npm install hexo-deployer-git --save
    sudo npm install hexo-deployer-heroku --save
    sudo npm install hexo-deployer-rsync --save
    sudo npm install hexo-deployer-openshift --save
    sudo npm install hexo-renderer-marked@0.2 --save
    sudo npm install hexo-renderer-stylus@0.2 --save
    sudo npm install hexo-generator-feed@1 --save
    sudo npm install hexo-generator-sitemap@1 --save
```


## 2.创建博客
```bash
```
- [参考](https://hexo.io/zh-cn/docs/setup.html)

### 2.1初始化博客目录(eg: myblog)

```bash
    mkdir myblog       # 新建 博客文件夹
    cd myblog          # 切换到 博客文件夹
    hexo init          # 初始化
    sudo npm install   # 安装依赖
```

- 命令执行后,myblog目录下文件结构:

```
.
├── _config.yml
├── package.json
├── scaffolds
├── scripts
├── source
|   ├── _drafts
|   └── _posts
└── themes

```

### 2.2目录结构说明:
#### _config.yml
- 网站的 配置 信息，您可以在此配置大部分的参数。

#### package.json
- 应用程序的信息。EJS, Stylus 和 Markdown renderer 已默认安装，您可以自由移除。

```json
package.json
{
  "name": "hexo-site",
  "version": "",
  "private": true,
  "hexo": {
    "version": ""
  },
  "dependencies": {
    "hexo-renderer-ejs": "*",
    "hexo-renderer-stylus": "*",
    "hexo-renderer-marked": "*"
  }
}

```

#### scaffolds
- 模版 文件夹。当您新建文章时，Hexo 会根据 scaffold 来建立文件。

#### scripts
- 脚本 文件夹。脚本是扩展 Hexo 最简易的方式，在此文件夹内的 JavaScript 文件会被自动执行。

#### source
- 资源文件夹是存放用户资源的地方。除 _posts 文件夹之外，开头命名为 _ (下划线)的文件 / 文件夹和隐藏的文件将会被忽略。Markdown 和 HTML 文件会被解析并放到 public 文件夹，而其他文件会被拷贝过去。

#### themes
- 主题 文件夹。Hexo 会根据主题来生成静态页面。

## 3.运行博客

### 3.1本地运行

```bash
```
- 执行以下命令，成功后可访问 `localhost:4000` 查看效果

```bash
hexo server
```

### 3.2常用配置命令

```bash
hexo new "My New Post"    # Create a new post 
hexo server               # Run server 
hexo generate             # Generate static files
hexo deploy               # Deploy to remote sites

命令简写:
hexo n     # new
hexo g     # generate
hexo s     # server
hexo d     # deploy

常用复合命令：
hexo d -g   # 生成加部署
hexo s -g   # 预览加部署

```



## 4.部署到github

### 4.1 github上新建仓库:`hhstore.github.io`

- 注意: 该仓库必须按照此格式命名: XXXX.github.io
- XXXX 为 github 用户名


### 4.2 配置_config.yml

```bash
    cd myblog
    找到_config.yml
```

更改其中内容:

```json

deploy:
  type: git
  repository: https://github.com/hhstore/hhstore.github.io.git
  branch: master


```


### 4.3 部署到github:

```bash
hexo g
hexo d # 部署到github

> 执行上述命令后,产生如下提示:
> Username for 'https://github.com':
> hhstore   # 输入用户名
> 
> Password for 'https://hhstore@github.com':
> XXXXX    # 提示输入用户密码.
> 
> INFO  Deploy done: git  # 提示部署成功.


```
- 若执行成功,会自动将public内容 同步到 hhstore.github.io 仓库.
- 若报错:ERROR Deployer not found: git , 执行如下命令:

```bash
npm install hexo-deployer-git --save
```
- 上一步,安装成功后,再次执行:

```bash
hexo d
```

### 4.4 访问博客

- 若以上步骤无误,访问博客地址: http://hhstore.github.io/


## 5.优化博客

### 5.1绑定域名

```bash
cd myblog   # 依旧是 博客源目录
cd source   # 切换到 source 文件夹下
touch CNAME   # 新建 CNAME 文件


```
- 在CNAME文件中输入:

```
selfrebuild.net 
```




### 5.2安装主题

- [参考](http://yangjian.me/pacman/hello/introducing-pacman-theme/)
- [主题选择](http://www.zhihu.com/question/24422335)
- [主题: NexT](https://github.com/iissnan/hexo-theme-next)
- Pacman是一款为Hexo打造的一款扁平化，有着响应式设计的主题。

#### 1.安装
- 安装pacman主题

```bash
git clone https://github.com/A-limon/pacman.git themes/pacman

```
- 安装Next主题

- 详细配置步骤,参考 `Next` 的github项目说明.

```bash
cd your-hexo-site
git clone https://github.com/iissnan/hexo-theme-next themes/next
```

#### 2.启用

修改你的博客根目录下的config.yml配置文件中的theme属性，将其设置为pacman。同时请设置stylus属性中的compress值为true。

#### 3.更新

```bash
cd themes/pacman
git pull

```
请先备份你的_config.yml 文件后再升级


### 5.3安装插件

- [安装插件](http://cnfeat.com/2014/05/10/2014-05-11-how-to-build-a-blog/)
#### 1.安装

- 添加sitemap和feed插件

```bash
$ npm install hexo-generator-sitemap  --save
$ npm install hexo-generator-feed  --save
```
#### 2.启用

- 修改_config.yml，增加以下内容

```json
# Extensions
Plugins:
- hexo-generator-feed
- hexo-generator-sitemap

#Feed Atom
feed:
  type: atom
  path: atom.xml
  limit: 20

#sitemap
sitemap:
  path: sitemap.xml
  
```

### 5.4配置sitemap(提高搜索引擎收录效果)


使用hexo提供的插件，方法与添加RSS类似。

- 安装sitemap插件到本地：

```bash
npm install hexo-generator-sitemap
```

- 开启sitemap功能：编辑hexo/_config.yml，添加如下代码：

```json
plugins:
- hexo-generator-sitemap

```

- 访问hexo/public/sitemap.xml即可看到站点地图。
- 为了提高搜索引擎对自己站点的收录效果，我们最好手动到google和百度等搜索引擎提交sitemap.xml。

### 5.5自定义 Next 主题的_config文件

#### 修改文件: themes/next/_config.yml

#### 实现效果:

- 实现添加: 标签(tag)页面
- 实现添加: 关于(about)页面
- 更改导航头像avatar
- 关闭自动对文章段落标题加标号
- 布局紧凑模式
- 始终显示右侧导航
- 修改代码高亮主题为: night eighties

#### _config.yml完整内容:

``` json
# when running hexo in a subdirectory (e.g. domain.tld/blog), remove leading slashes ( "/archives" -> "archives" )
menu:
  home: /
  archives: /archives
  categories: /categories
  tags: /tags
  about: /about
  #commonweal: /404.html

# head
avatar: http://www.gravatar.com/avatar/b9b00e66c6b8a70f88c73cb6bdb06787

# Place your favicon.ico to /source directory.
favicon: /favicon.ico

# Set default keywords (Use a comma to separate)
keywords: "Hexo,next"

# Set rss to false to disable feed link.
# Leave rss as empty to use site's feed link.
# Set rss to specific value if you have burned your feed already.
rss: /atom.xml

# Icon fonts
# Place your font into next/source/fonts, specify directory-name and font-name here
# Avialable: default | linecons | fifty-shades | feather
icon_font: default
#icon_font: fifty-shades
#icon_font: feather
#icon_font: linecons

# Code Highlight theme
# Available value: normal | night | night eighties | night blue | night bright
# https://github.com/chriskempson/tomorrow-theme
highlight_theme: night eighties


# MathJax Support
mathjax:


# Schemes
scheme: Mist


# Sidebar, available value:
#  - post    expand on posts automatically. Default.
#  - always  expand for all pages automatically
#  - hide    expand only when click on the sidebar toggle icon.
#sidebar: post
sidebar: always
#sidebar: hide


# Automatically scroll page to section which is under <!-- more --> mark.
scroll_to_more: true


# Automatically add list number to toc.
# toc_list_number: true
toc_list_number: false

## DO NOT EDIT THE FOLLOWING SETTINGS
## UNLESS YOU KNOW WHAT YOU ARE DOING

# Use velocity to animate everything.
use_motion: true

# Fancybox
fancybox: true

# Static files
vendors: vendors
css: css
js: js
images: images

# Theme version
version: 0.4.3

```



## 6.etc

### 6.1 图床

- 七牛(10G免费)

### 6.2 出错问题解决:

