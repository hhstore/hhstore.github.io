title: Python常用包 - virtualenv 使用
date: 2015-07-02 11:01:48
categories: Python
tags: [Python, pip, virtualenv]
---

介绍virtualenv的安装和使用,以及配合pip的技巧运用.

<!-- more -->

## 1.virtualenv简介
### 1.1 问题需求:

- 在python开发中,经常涉及不同项目,依赖不同的python版本(2.7或者3.4),又或者依赖不同的第三方包.甚至可能涉及多个版本.
- 项目开发中,开发环境,测试环境,线上部署环境.可能依赖不同的配置.很多时候,开发机可能安装了很多包,而线上部署,可能只需要很小的子集.

### 1.2 解决方案: virtualenv
- virtualenv 为每个不同项目提供一份 Python 安装.它并没有真正安装多个 Python 副本,但是它确实提供了一种巧妙的方式来让各项目环境保持独立.
- virtualenv,类似"python"中的虚拟机.
- 可以对单一项目,在项目中,创建一个虚拟python开发环境.
- 将该项目依赖的包,单独安装在该"虚拟环境"中,实现和其他项目隔离.
- 该项目中,安装的python版本,不会和OS系统冲突.
- 每次使用,都需要在项目中,激活该"虚拟环境".
- 使用完,退出"虚拟环境".

## 2.安装virtualenv
### 2.1 使用pip安装
- 确认已经安装pip 包管理工具.
- 执行如下命令安装.

```bash
sudo pip install virtualenv
```
### 2.2 使用系统包管理工具安装(Mac/Ubuntu)
```bash
brew install pyenv-virtualenv             # Mac下,采用homebrew方式安装

sudo apt-get install python-virtualenv    # ubuntu下,采用apt-get方式安装
```



## 3.使用方法.

- 假定当前有个项目名为: my_project_folder
- 特别提醒: 项目中,每次使用virtualenv,都要先激活,否则默认使用系统的python环境.
- 激活后,所有操作,都是在虚拟环境中.

### 3.1 在项目中,创建虚拟环境.

- 创建虚拟环境.有两种方式.

```bash
cd my_project_folder                    # 切换至项目目录

方式1: 使用 主机默认python版本,创建
virtualenv venv                         # 创建虚拟环境安装目录"venv".

方式2: 指定python版本(路径),创建
virtualenv -p /usr/bin/python2.7 venv   # 指定使用python2.7创建一个 项目虚拟环境.

方式3: 不依赖系统环境中已有的site package(即系统已安装的python包)
virtualenv --no-site-packages venv  # 加上参数 --no-site-packages.
```

- 执行上述命令,项目中,多出一个名为"venv"的文件夹.
- 该文件夹,会从"宿主主机",根据创建方式,拷贝一份"python环境".
- 该虚拟环境中,默认已安装pip.

### 3.2 在项目中,使用虚拟环境.

- 在 my_project_folder 目录下,执行:

```bash
source venv/bin/activate   # 激活项目中的虚拟环境, venv为 创建虚拟环境时,给定名称
```

- 执行该命令后,终端(Mac/Linux)终端提示,会多出(venv)前缀,可作标志:

```
(venv)Your-Computer:your_project UserName$)>

```

- 该(venv)前缀标志,代表之后的所有操作,都是对该虚拟环境进行的.
- 比如再执行pip 安装包, 都将会 安装在该虚拟环境,而不是主机的全局环境.


### 3.3 执行操作.

- 接上,执行如下操作,都将是在该项目的虚拟环境下.

#### 3.3.1 安装开发包

```bash
sudo pip install flask   # 安装flask包

```

#### 3.3.2 运行项目

```python
python xxx.py
```

### 3.4 结束虚拟环境.

- 项目运行结束,执行如下命令:

```bash
deactivate      # 退出项目的 virtualenv 虚拟环境.
```

### 3.5 生成可打包环境
- 某些特殊需求下,可能没有网络, 我们期望直接打包一个ENV, 可以解压后直接使用, 这时候可以使用virtualenv -relocatable指令将ENV修改为可更改位置的ENV
- [参考](http://andrewliu.tk/2014/12/08/Virtualenv%E7%AE%80%E6%98%8E%E6%95%99%E7%A8%8B/)

### 3.6 查看帮助

```bash
virtualenv -h
```


## 4.使用技巧(pip + virtualenv)

经常有这样一种需求:就是把项目发布,需要知道项目依赖哪些包.

### 4.1 pip的常用操作.

```bash

导出:
pip freeze > requirements.txt   # 导出项目依赖的包到requirements.txt文件

批量安装:
pip install -r requirements.txt  # 从依赖文件,批量安装包.
```

### 4.2 配合virtualenv使用.

- 这里为何一定要用virtualenv呢?因为如果没有使用virtualenv,上述pip freeze操作,会将主机安装过的所有python包,都导出.这显然不是我们需要的.

- 对单一的项目,如果没有virtualenv,将导出一堆用不到的包.
- 有了virtualenv,就可以先激活项目中的virtualenv,再执行pip freeze操作.这样就可以保证获取到的都是项目依赖(无冗余).


## 5.使用virtualenvwrapper(略)

- Virtaulenvwrapper是virtualenv的扩展包，用于更方便管理虚拟环境，个人感觉不太需要,想多了解,可参考如下文档.
- Virtaulenvwrapper特点：

    - 1. 将所有虚拟环境整合在一个目录下
    - 2. 管理（新增，删除，复制）虚拟环境
    - 3. 切换虚拟环境
    - [官方文档参考](http://docs.python-guide.org/en/latest/dev/virtualenvs/)


## 6.pip常用操作

```bash

sudo pip install flask             # 单一安装flask包
pip install -r requirements.txt    # 批量安装python包
pip list                           # 查看环境中,已安装的所有python包
pip freeze > requirements.txt      # 导出环境中,已安装所有包至配置文件

```




