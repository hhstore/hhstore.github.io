title: Git配置教程
date: 2015-06-24 21:15:30
categories: Git
tags: [Github, Git, Mac, SSH]

---

本篇详细介绍Git的配置过程,以及常用Git命令.

<!-- more -->

## Part 1: `配置git环境`
### 1.准备工作:

- 1.下载并安装git软件.
    - [git下载地址](http://git-scm.com/)
- 2.注册 github 账号,或者 bitbucket 账号,并新建一个代码仓库.
    - [github地址](www.github.com)
    - [bitbucket地址](www.bitbucket.org)


### 2.配置步骤:
    
#### 1.如果没有安装ssh.

```bash
    ubuntu 版本操作:
    sudo apt-get install ssh
```

### 2.检查SSH公钥是否存在

```bash
    cd ~/.ssh

    查看是否存在.ssh，若存在，跳过下一步.
    不存在,请看下一步.
```

#### 3.生成SSH公钥

```bash
    windows 版本操作:
    安装完 git, 在开始菜单,找到 git 下的 git-bash, 进入git自带模拟终端.
    
    输入如下命令:
    $ ssh-keygen -t rsa -C "xxx@gmail.com"
    按3个回车，密码为空。
    
    最后得到了两个文件：id_rsa和id_rsa.pub
    
    特别说明:
    默认后续所有命令操作,都是在 git-bash 下进行.
    请不要在windows的CMD命令窗口下操作git.  
```

```bash
    ubuntu 版本操作:
    终端输入如下命令:
    $ ssh-keygen -t rsa -C "your_email@youremail.com" 
    按3个回车，密码为空。
        
    然后可以看到:
    Your identification has been saved in /home/you/.ssh/id_rsa. 
    # Your public key has been saved in /home/you/.ssh/id_rsa.pub.
    # The key fingerprint is: 
    # 01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@youremail.com

    最后得到了两个文件：id_rsa和id_rsa.pub
```
#### 4.添加SSH公钥到github
+ [github地址](www.github.com)
+ [bitbucket地址](www.bitbucket.org)

```bash
    步骤:
    1. 打开github.
    2. 进入Account Settings.
    3. 左边,选择SSH Keys.
    4. 选择Add SSH Key.
    5. title随便填，把 id_rsa.pub 内容复制到key里,保存。
```

#### 5.测试key是否生效

```bash
    输入如下命令测试:
    ssh -T git@github.com

    当看到如下提示信息，直接输入: yes
    The authenticity of host 'github.com (207.97.227.239)' can't be established. 
    RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48. 
    Are you sure you want to continue connecting (yes/no)?

    当看到如下提示信息，说明配置成功。
    Hi username! 
    You've successfully authenticated, but GitHub does not provide shell access.
```
    
    
## Part 2: `使用github仓库`(bitbucket类似)


### 1.获取github仓库源码:

```bash
    cd 到 本机常用代码目录.
    输入如下命令:(如下命令,可以从 github 的代码仓库拷贝)
    $ git clone git@github.com:your_name/github-services.git
    
    命令执行成功,本地代码目录下,会产生一个 repo 仓库. 
```

### 2.常用git操作命令.

```bash
    1. 仓库初始化: git init
    2. 查看状态: git status
    3. 添加控制: git add .
    4. 添加单个文件: git add XXX
    5. 添加注释: git commit -m "your commit message."
    6. 提交到远端仓库: git push origin master
    7. 获取最新代码: git pull origin master
    8. 打版本标签: git tag 1.0.0 1b2e1d63ff
    9. 查看版本标签: git tag -l
    10. 提交版本标签: git push origin --tags
    11. 查看区别: git diff <source_branch> <target_branch>
    12. 删除文件: git rm XXX.XXX
    13. 重命名:   git mv AAA.XXX BBB.XXX
    14. 拷贝代码仓库至本地: git clone XXXXX.git
```
### 3.重要git操作tips.

```bash
    1. 完成添加tag操作步骤:
        git tag                    # 显示已经存在的tag标记
        git show tag XXX           # 显示详细的tag信息
        git tag 1.0.0 1b2e1d63ff   # 对某次提交,添加tag
        git tag -a <tagname> -m "blablabla..."  # 可以指定标签信息；
        git push origin --tags     # 推送所有本地tags至远端仓库
        git push origin [tagname]  # 推送单个tag至远端仓库.
    2. 删除标签:
        git tag -d [tagname]                   # 删除
        git push origin :refs/tags/[tagname]   # 推送删除,至远端仓库.


    3. 获取,回退到某次tag提交.(给个示例)
        git clone git@bitbucket.org:wangdao_dev/doraemon.git   # 克隆一个仓库
        cd doraemon                        # 切换到仓库目录下
        git fetch && git checkout v0.01    # 回退到某个tag标记时的仓库状态.
        
        
    4. 版本回退.(当前版本为A,但是有误删除某些文件,想恢复之前版本B中的部分文件.)
        git reset --hard 9770724   # 需要回退到的某个提交版本号
        把版本B状态下,需要的文件拷贝出来.重新另clone一份当前仓库服务器最新状态.把需要的文件,添加进去,重新提交.就可以恢复.
        这是一种折中的办法.
        git reset --hard 只是拿到 过去版本的 状态.并没产生提交和回滚.git服务器端,依然只有停留在最后的提交状态.
        

    5. git reset与revert的区别

        git revert是用一次新的commit来回滚之前的commit，git reset是直接删除指定的commit。
        在回滚这一操作上看，效果差不多。但是在日后继续merge以前的老版本时有区别。因为git revert是用一次逆向的commit“中和”之前的提交，因此日后合并老的branch时，导致这部分改变不会再次出现，但是git reset是之间把某些commit在某个branch上删除，因而和老的branch再次merge时，这些被回滚的commit应该还会被引入。
        git reset 是把HEAD向后移动了一下，而git revert是HEAD继续前进，只是新的commit的内容和要revert的内容正好相反，能够抵消要被revert的内容。
    

```

### 4. 一篇不错的文档
+ [Git 教程 - Git 基本用法](http://lugir.com/git-basic.html)

```bash
  
    Git 是当前最流行的版本控制程序之一，文本包含了 Git 的一些基本用法

    创建 git 仓库
    　　初始化 git 仓库
    mkdir project # 创建项目目录
    cd project # 进入到项目目录
    git init # 初始化 git 仓库。此命令会在当前目录新建一个 .git 目录，用于存储 git 仓库的相关信息
    　　
    　　初始化提交
    touch README
    git add . # 将当前目录添加到 git 仓库中， 使用 git add -A 则是添加所有改动的文档
    git commit -m "Initial commit"
    git remote add origin git@github.com:lugir/repo.git # 设置仓库
    　　修补提交（修补最近一次的提交而不创建新的提交）
    git commit --amend -m "commit message."
    　　提交冲突时可以合并后再推送
    git pull # 获取远程版本库提交与本地提交进行合并
    git push # 提交
    
    使用别人的仓库
    git clone http://path/to/git.git # clone 的内容会放在当前目录下的新目录
    
    将代码从本地回传到仓库
    git push -u origin master
    
    使用 git status 查看文件状态
    git status
    
    查看提交日志
    git log # 查看提交信息
    git log --pretty=oneline # 以整洁的单行形式显示提交信息
    git log --stat # 查看提交信息及更新的文件
    
    Git 分支
    git branch # 查看分支
    git branch 6.x-1.x # 添加分支 6.x-1.x
    git branch checkout master # 切换到主分支
    git branch -d 6.x-1.x # 删除分支 6.x-1.x
    git push origin :branchname # 删除远端分支
    
    Git 标签
    git tag # 查看分支
    git tag 6.x-1.0 # 添加标签 6.x-1.0
    git show 6.x-1.0 # 查看标签 6.x-1.0 的信息
    git tag -a 6.x-1.0 965e066 # 为之前提交的信息记录 965e066 加上标签
    git push --tags # 提交时带上标签信息
    git push origin :/refs/tags/tagname # 删除远端标签
    
    从 git 仓库中导出项目
    git archive --format tar --output /path/to/file.tar master # 将 master 以 tar 格式打包到指定文件
    
    使用 Git 的一些基本守则：
    当要commit/提交patch时：
    使用 git diff --check 检查行尾有没有多余的空白
    每个 commit 只改一件事情。如果一个文档有多个变更，使用 git add --patch 只选择文档中的部分变更进入 stage
    写清楚 commit message

```




## Part 3: git多账号管理.
+ [参考文档](http://my.oschina.net/meilihao/blog/157716)
+ [github/gitlab同时管理多个ssh key -详细](http://xuyuan923.github.io/2014/11/04/github-gitlab-ssh/)

### 需求:
+ 有多个github账号.或者bitbucket账号不想用同一个ssh key.
+ git bash默认只会找: ~/.ssh/id_rsa的key
+ 需要使用ssh的多账号功能.

### 1.配置config文件.
解决方法很简单,需要配置~/.ssh/config文件(没有则新建,没有扩展名) 

+ config 配置文件格式:

```bash
Host myhost  （是自定义host简称，以后连接远程服务器就可以用命令ssh myhost）[注意下面有缩进]
   User         登录用户名(如：git)
   HostName     主机名可用ip也可以是域名(如:github.com或者bitbucket.org)
   Port         服务器open-ssh端口（默认：22,默认时一般不写此行）
   IdentityFile 证书文件路径（如~/.ssh/id_rsa_*)

```
+ 示例 config:

```bash
Host meilihao.github.com
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_rsa_github
```
### 2.修改github对应repo的URL

```bash
   原地址:
   git@github.com:meilihao/gopkg.git
   
   修改后地址:
   git@meilihao.github.com:meilihao/gopkg.git   # 注意修改点.
   
```

### 3.测试修改是否正常.

```bash
    ssh -T yourHost     //我这是: ssh -T meilihao.github.com
```

### 4.修改git提交URL.

```bash
    git remote rm origin 
    git remote add origin git@meilihao.github.com:meilihao/gopkg.git   # 注意修改的细节点,变化处.
```


### 5.使用sourcetree的多账号.
+ 记得修改config文件,
+ 同时在"Tools"菜单的"add ssh key"中选择私钥,
+ 最重要的是clone时要使用修改后的path.

### 6.报错信息.
- 1.//git clone 项目时提示Host key verification failed

```bash
> 使用 ssh 协议时会验证对方服务器的 key。
> ssh无法确认服务器出示的 key 是可信认的，所以问你这个 key 是不是真的是你要连接的那个服务器的。
> 你没说「yes」所以 ssh 认为你不想继续连接，结果当然是连接失败
```

- 2.//git clone Permissions 0644 for ‘~/.ssh/id_rsa’ are too open

```bash
    把文件权限,降到0600.
```
- 3. // git push 始终报错. 提示 仓库不存在,或者没有访问权限. 解决办法:
    - 1. 因为存在多个SSH-KEY, 单纯修改设置好 .ssh/config文件,是不够的.

```bash
# .ssh/config内容:
###############################
# github setting
Host llm_git
    HostName github.com
    User git
    IdentityFile C:\Users\XXXX\.ssh\id_rsa_llm_github
```

    - 2. 需要对应修改已经clone下来的项目目录中的.git/config文件中的配置参数.

```bash
[remote "origin"]
    url = llm_git:XXXX/XXX_project.git    # 修改默认的github路径为 host 名称.
    fetch = +refs/heads/*:refs/remotes/origin/*
```

    - 3. 再次执行: git push, 就可以正常提交代码.而不会报权限问题错误.


### 参考: git多账号管理

以前用github的ssh key，后来工作原因多了一个gitlab的账号，在绑定gitlab的ssh key时，发现将github的ssh key覆盖了。怎么同时绑定github和gitlab的ssh key，并不产生冲突呢？ 今天找到了个小技巧，在.ssh目录下新建一个config文件配置一下，就能解决gitlab与github的ssh key的冲突。

#### 生成并添加第一个ssh key

```bash
cd ~/.ssh
ssh  ssh-keygen -t ras -C "youremail@yourcompany.com"

这时可以一路回车，不输入任何字符，将自动生成id_rsa和id_rsa.pub文件。
```
#### 生成并添加第二个ssh key

```bash
$ ssh-keygen -t rsa -C "youremail@gmail.com"

注意，这时不能一路回车，否则邮箱将覆盖上一次生成的ssh key，
给这个文件起一个名字， 比如叫 id_rsa_github, 
所以相应的也会生成一个 id_rsa_github.pub 文件。 
```

#### 查看.ssh下的目录文件，发现多了id_rsa_github和id_rsa_github.pub两个文件。 

```bash
   -> .ssh ls
```

#### 添加私钥

```bash
    $ ssh-add ~/.ssh/id_rsa
    $ ssh-add ~/.ssh/id_rsa_github
```

#### 修改配置文件

+ 在 ~/.ssh 目录下新建一个config文件

```bash 
    touch config   
```

+ 添加以下内容

```bash 
# gitlab
Host gitlab.com
    HostName gitlab.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa

# github
Host github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_github
```

#### 给github/gitlab上添加ssh key

查看ssh key执行cat id_rsa_github.pub内容，将文本内容拷贝到https://github.com/settings/ssh。
生成ssh key的方法可以去看官方教程，这里不再赘述。

#### 测试

```bash
    $ ssh -T git@github.com
    
    如果输出
    Hi xuyuan923! You've successfully authenticated, but GitHub does not provide shell access.
    说明成功的连上github了。

```


---


## Part 4: 扩展阅读.

### 1.github官方帮助文档:(以下必看)
+ 推荐git教程[git book](http://git-scm.com/book/zh/v1)
+ 官方帮助[总目录](https://help.github.com/)
+ 配置第一步.[Generating SSH keys](https://help.github.com/articles/generating-ssh-keys/)
+ 出错解决.[Error: Permission denied (publickey)](https://help.github.com/articles/error-permission-denied-publickey/)
+ 克隆远端仓库.[Cloning a repository](https://help.github.com/articles/cloning-a-repository/)
+ gitignore文件.[全部列表](https://github.com/github/gitignore)
+ git常用操作命令集.[cheat-sheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf)
+ markdown学习使用.[markdown教程](https://help.github.com/articles/markdown-basics/)
+ Mac专属.[GitHub for Mac](https://help.github.com/categories/github-for-mac/)
+ windows专属.[GitHub for Windows](https://help.github.com/categories/github-for-windows/)

### 2.其他:
+ [官方简易教程](http://www.bootcss.com/p/git-guide/)
+ [permission deny问题](http://blog.itpub.net/25851087/viewspace-1262468/)
+ [git教程-很全面](http://blog.163.com/www_iloveyou_com/blog/static/2116583722013111113954760/)
+ [git生成SSH公钥](http://blog.chinaunix.net/uid-26185912-id-3327885.html)
+ [git打标签tag](http://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%89%93%E6%A0%87%E7%AD%BE)
    
