title: Mac配置Shell神器Zsh
date: 2015-06-25 15:48:14
categories: Mac
tags: [Mac, Shell, zsh, oh-my-zsh]
---

本文介绍Mac配置zsh已经安装并设置oh-my-zsh插件.

<!-- more -->



- MAC 配置zsh + oh-my-zsh 并不复杂
- windows略周折


## 1.安装git：
```bash
    homebrew安装方式:
    brew install git
    
    macport安装方式:
    sudo port git

```


## 2.安装完,更改默认shell为zsh
```bash
    chsh -s /bin/zsh
    或者
    sudo usermod -s /bin/zsh march

    如果是port下来的高版本zsh，记得zsh路径是 /opt/local/bin/zsh。

```

## 3.安装oh-my-zsh插件

- 终端登入zsh（例如开一个新iTerm2窗口或者直接执行zsh），
- 会提示配置zsh，可直接选2,建立一个空的配置，
- 接下来安装 oh-my-zsh 插件。
- oh-my-zsh 是一个广受欢迎的 zsh 配置库，
- github主页上有[安装方法](https://github.com/robbyrussell/oh-my-zsh/)


```bash 
    使用如下脚本下载安装zsh：
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

    等待一段时间，脚本会自动下载安装 zsh，生成一个默认的配置，启动它。

```

## 4.配置zsh主题
### 4.0 修改配置文件
```bash
    切换到用户根目录,vim打开.zshrc配置文件.
    vim ~/.zshrc 

```
### 4.1 修改主题(修改.zhsrc配置文件 ZSH_THEME 参数)
```bash
    ZSH_THEME="random"    # 每次打开终端,随机一个zsh主题.直到找到喜欢的,修改之.
    
    ZSH_THEME="maran"     # 个人最喜欢的主题:maran.zsh-theme
```


### 4.2 启用插件(修改.zhsrc配置文件中 plugins 参数)

```bash
    终端下,输入如下命令,查看支持的插件,根据需要,添加至配置文件中,启动之.
    ls ~/.oh-my-zsh/plugins 
```

- 修改参数:

```bash
    plugins=(bundler git git-flow gnu-utils osx ruby gem perl rails rvm mercurial svn macports osx virtualenvwrapper django pip) 
```

### 4.3 保存.zhsrc配置文件,重开一个终端,生效.


+ [参考](http://site.douban.com/125980/widget/notes/4884065/note/232038698/)

