title: "使用 Mweb 配合 hexo 编写 github 博客"
date: 2016-08-25 22:12:10
categories: Tools
tags: [hexo, blog, github, mweb]
---
本篇介绍如何使用 Mweb 配合 hexo 编写 github 博客.

<!-- more -->


## MWeb 简介:

- Mac 下目前最好用的 markdown 编辑器
- 亮点:
    - 所见即所得
    - 直接复制粘贴图片到编辑框,自动生成图片 URL
    - 支持上传各种图床
    - 支持发布到各种博客网站
- 简单搜索了一下,找到配合 hexo 在 github 上写博客的办法.

## MWeb 配置:
### 1. 打开 MWeb 外部模式:
- mweb 中, `CMD+E`快捷键激活


### 2. 导入原 github 博客仓库资源目录:

- 找到本机的 github 仓库目录
- 点击 `引入文件夹`, 把 github 博客的 `source` 目录导入, 如截图所示.


```bash
~/iGithub/iBlog

# 查看 我的 github 博客项目目录:
-> % tree iBlog -L 1
iBlog
├── _config.yml
├── cfg_backup.yml
├── db.json
├── node_modules
├── package.json
├── public
├── readme.mdown
├── scaffolds
├── source      # 博客源目录, 导入此目录
└── themes


# 找到 source 目录.
-> % tree source -L 1
source
├── CNAME
├── _posts
├── about
├── books
├── categories
├── images
├── links
├── media       # 默认 Mweb 保存图片的路径.
├── projects
├── tags
├── tools
└── translations


```


![](/media/14732178319341.jpg)


### 3. 设置 `source` 目录属性:
- `source` 文件夹,右键,找到`编辑`.
- 设置 图片保存路径,默认 `media` 文件夹,并改成`绝对位置`

![](/media/14732182875227.jpg)

![](/media/14732184402723.jpg)

- 保存成功后,就可以愉快的在 MWeb 编辑器里写博客了.

### 4. 写一篇博客测试:
![](/media/14732186698429.jpg)


### 5. 发布到 github

- 首先, Mweb 编辑的博客文件,是保存在原 github 博客仓库路径下,所以, 按照正常的发布流程来.
- 切换到 项目目录.

```bash
# 发布命令
[~/xx/xx/iBlog] [master *]
-> % hexo g -d

```
### 6. 查看:

- 打开博客地址, 查看: http://hhstore.github.io 


## 参考:
- [Hexo 博客进阶配置与常见问题](https://joilence.github.io/2016/07/14/improve-blog/)




