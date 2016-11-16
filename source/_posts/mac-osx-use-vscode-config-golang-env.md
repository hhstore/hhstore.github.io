title: "Mac 平台: 使用 vscode 搭建 Golang 开发环境"
date: 2016-11-15 16:42:13
categories: Tools
tags: [Mac, vscode, Golang, IDE]
---
本篇介绍 Mac 平台 使用 virtual studio code 搭建 golang 开发环境, 包含 debug 环境的配置.

<!-- more -->

## 1. vscode 简介:

### 1.1 vscode 亮点:
- Microsoft 开发, 高质量, 高颜值
- 启动速度比 atom 快, 资源占用少
- 插件比 atom 好用, 官方插件库下载安装快
- 对 Python, golang 支持够好
- 集成终端好用
- debug 功能好用(简直是 mini 的 IDE)

### 1.2 对比 IDE:

- 之前一直使用: pycharm + go 插件, 搭配开发 golang.
- 优点: 
    - go 插件的 debug 功能,比较强大
    - pycharm 的有强大的代码跳转,补全功能.
- 缺点:
    - pycharm 每次建立项目索引比较慢.
    - 启动比较笨重, 有些时候只是写测试代码, 不太需要启动 IDE.
- vscode 的优点, 刚好可以弥补 pycharm 的不足.
- 以后搭配2者作开发.很方便.

### 1.3 技巧操作:

- 列编辑模式: ultraedit 中特色功能
    - 快捷键: `shift + alt + 鼠标左键`
    - vscode 版本 > 1.2.0
- Ctrl+P 模式: (Mac 是 `CMD+P`)
    - 直接输入文件名，快速打开文件
    - `:` 跳转到`行数`，也可以`Ctrl+G`直接进入(Mac 是 `CMD+G`)
    - `@` 跳转到symbol（搜索变量或者函数），也可以Ctrl+Shift+O直接进入
    - `@:`根据分类跳转symbol，查找属性或函数，也可以Ctrl+Shift+O后输入:进入
    - `#` 根据名字查找symbol，也可以Ctrl+T
- 编辑:
    - 上下移动一行： `Alt+Up` 或 `Alt+Down`
    - 向上向下复制一行： `Shift+Alt+Up` 或 `Shift+Alt+Down`
    - 代码格式化：`Shift+Alt+F`，或 `Ctrl+Shift+P` 后输入 `format code`
    - 更改代码文件语言模式: 显示-->状态栏显示.
- 代码重构:
    - 跳转到定义处：`F12`
    - 列出所有的引用：`Shift+F12`
    - 重命名：比如要修改一个方法名，可以选中后按F2，输入新的名字，回车，会发现所有的文件都修改过了。
- 显示相关:
    - 侧边栏显/隐：`Ctrl+B`
    - 预览markdown: `Ctrl+Shift+V`
    - 双栏对比: `Ctrl+\`
- 皮肤预览:
    - f1后输入 theme 回车，然后上下键即可预览
- [学会用好 Visual Studio Code](https://nshen.net/article/2015-11-20/vscode/)
- [VS Code tips and tricks 翻译](http://geek.csdn.net/news/detail/94108)
- [VS Code Tips and Tricks](https://github.com/Microsoft/vscode-tips-and-tricks)

## 2 vscode 安装:

- 官网下载安装: [vscode 官网](https://code.visualstudio.com/)
- brew cask 安装:

```bash

# 安装:
brew cask install visual-studio-code

# 查看 vscode 信息:
-> % brew cask info visual-studio-code

visual-studio-code: 1.3.1,e6b4afa53e9c0f54edef1673de9001e9f0f547ae
Microsoft Visual Studio Code, VS Code
https://code.visualstudio.com/
Not installed
https://github.com/caskroom/homebrew-cask/blob/master/Casks/visual-studio-code.rb
==> Contents
  Visual Studio Code.app (app)
  /Applications/Visual Studio Code.app/Contents/Resources/app/bin/code (binary)

```

## 3 vscode 常用插件安装:

- 基础插件:
    - vscode-icons: 颜值, 彩色文件,目录
    - Material Theme Kit: 编辑器 UI 主题
    - visual studio code settings sync: 同步 vscode 配置文件
- 开发必备:
    - code runner: 执行 go, python,各种代码
    - beautify : 格式化代码
    - git history:
    - go: 开发必备
    - python: 开发必备
    - docker support:
    - debugger for chrome:
    - bootstrap3 snippets: 
    - html snippets: 各种 补全用的 snippets, 官方插件库搜索添加.
- 补充: [Visual Studio Code有哪些你常用的插件？- 知乎](https://www.zhihu.com/question/40640654)

## 4. vscode 配置 golang 开发环境:

### 4.1 安装 golang:

```
# 安装:
brew install go

# 查看安装成功:
-> % go version
go version go1.7.3 darwin/amd64

```

### 4.2 配置 golang 环境变量:
- `GOPATH` : 必须设置
- `GOBIN`: 非必需, 但通常顺手设置.
- 设置办法: 添加到 zsh 的配置文件: `~/.zprofile`
- 参考如下配置 `~/.zprofile`:

```

#######################################################
#                 for Golang:
#######################################################

#-------------------------------
# set GOPATH:
#-------------------------------

# go lib path:
GO_LIB_PATH=${HOME}/iGit/iSpace/iGo/libdir

# go user workspace:
GO_WORK_PATH=${HOME}/iGit/iSpace/iGo/workdir

export GOPATH=${GO_LIB_PATH}:${GO_WORK_PATH}

#-------------------------------
# set GOBIN:
#-------------------------------

export GOBIN="${GO_LIB_PATH}/bin:${GO_WORK_PATH}/bin"
export PATH="${PATH}:${GOBIN}"

```

- 检查 golang 环境变量设置成功:

```bash

# 查看环境变量:
# 关键看 GOPATH 和 GOBIN,  GOROOT
-> % go env

GOARCH="amd64"
GOBIN="/Users/hhstore/iGit/iSpace/iGo/libdir/bin:/Users/hhstore/iGit/iSpace/iGo/workdir/bin"
GOEXE=""
GOHOSTARCH="amd64"
GOHOSTOS="darwin"
GOOS="darwin"
GOPATH="/Users/hhstore/iGit/iSpace/iGo/libdir:/Users/hhstore/iGit/iSpace/iGo/workdir"
GORACE=""
GOROOT="/usr/local/Cellar/go/1.7.3/libexec"
GOTOOLDIR="/usr/local/Cellar/go/1.7.3/libexec/pkg/tool/darwin_amd64"
CC="clang"
GOGCCFLAGS="-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -gno-record-gcc-switches -fno-common"
CXX="clang++"
CGO_ENABLED="1"

```



### 4.3 配置 golang 开发 debug 模式:

#### 4.3.1 安装 golang debug 插件 delve: 

- golang 调试工具: delve
- 安装 `delve`: [Installation on OSX](https://github.com/derekparker/delve/blob/master/Documentation/installation/osx/install.md)
- Mac 平台: 
    - `必须用 brew 安装`, 
    - `不要直接使用 go get 安装`, 会出现签名, 权限问题, 导致 无法使用 `dlv` 调试工具.
- 请严格参考 `delve` 项目官方安装文档.这一步最容易出问题.

```bash
# 安装 delev 工具:
brew install go-delve/delve/delve

```

- 查看安装情况:

```bash
# 查看安装路径: (go get 安装路径, 必然不是这个)
-> % which dlv
/usr/local/bin/dlv

# 查看 dlv 版本:
-> % dlv version
Delve Debugger
Version: 0.11.0-alpha
Build: v0.11.0

# 查看安装情况:
-> % brew info delve

go-delve/delve/delve: stable 0.11.0, HEAD
Debugger for the Go programming language.
https://github.com/derekparker/delve
/usr/local/Cellar/delve/0.11.0 (6 files, 7.4M) *
  Built from source on 2016-11-15 at 14:14:07
From: https://github.com/go-delve/homebrew-delve/blob/master/Formula/delve.rb
==> Dependencies
Build: go ✔
==> Caveats
If you get "could not launch process: could not fork/exec", you need to try
in a new terminal.

When uninstalling, to remove the dlv-cert certificate, run this command:

    $ sudo security delete-certificate -t -c dlv-cert /Library/Keychains/System.keychain

Alternatively, you may want to delete from the Keychain (with the Imported private key).

```

- 配置问题解决:
    - error: could not launch process: could not fork/exec
        - 原因: 没有使用 brew 安装, 请使用 brew 安装, 
    - error: [delve/issues/159](https://github.com/derekparker/delve/issues/159)


#### 4.3.2 使用 vscode 自动安装 debug 必备的插件:

```bash

# 如下工具: vscode 会自动安装:
# 基本不会出现问题:
go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/lukehoban/go-outline
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/tpng/gopkgs
go get -u -v github.com/newhook/go-symbols
go get -u -v golang.org/x/tools/cmd/guru
```

#### 4.3.3 自定义配置 vscode:

- 修改: 首选项/用户设置:
- 添加如下配置:
    - `settings.json`
- 关键修改: 
    - `go.gopath`
    - `go.goroot`

```

// 将设置放入此文件中以覆盖默认设置
{
    "files.autoSave": "afterDelay",
    // 以像素为单位控制字号。
    "editor.fontSize": 14,

    // 自定义要在 OS X 上运行的终端应用程序。
    "terminal.external.osxExec": "iterm.app",


// Go configuration
    // Specifies the GOPATH to use when no environment variable is set.
    // 这是我个人的 GOPATH, 设置2个, 首个为 lib 路径, 次个为个人开发工作区
    "go.gopath": "/Users/hhstore/iGit/iSpace/iGo/libdir:/Users/hhstore/iGit/iSpace/iGo/workdir",
     // Specifies the GOROOT to use when no environment variable is set.
    "go.goroot": "/usr/local/Cellar/go/1.7.3/libexec",

    "workbench.statusBar.visible": false
}

```

#### 4.3.4 测试 golang debug 效果:

- 修改: launch.json
    - 此文件在执行 debug 时, 会根据提示, 自动生成.
    - 生成在项目根目录下: `/Users/hhstore/iGit/iSpace/iGo/.vscode/launch.json`
- 根据具体情况, 修改: `program` 参数值.
- 具体参考如下图示.

- debug 代码目录:
![测试图片](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/11/20161115-002.png?raw=true)


- debug 断点效果图:
![测试图片](https://github.com/hhstore/hhstore.github.io/blob/master/images/2016/11/20161115-001.png?raw=true)

