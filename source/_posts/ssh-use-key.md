title: "SSH 使用 SSH-KEY 登录, 并禁用密码登录"
date: 2016-08-22 14:55:32
categories: Tools
tags: [SSH, Ubuntu]
---

SSH 使用 SSH-KEY 登录, 并禁用密码登录的配置方法.

<!-- more -->

## 0. 更改 SSH 登录的背景:

- 最近查看阿里云主机的后台监控日志, 发现有被攻击, 查了下 log 详情.
- 发现有人在对主机 SSH 登录端口22, 做暴力验证, 已经攻击了几天了, 瞬间吓尿有木有.
- 赶紧把 SSH 登录的口令方式禁掉, 切到 密钥对方式登录.
- 安全意识, 还是要提高, 懒癌要不得. 果断把其他几台主机, 都改了.

## 1. SSH 登录方式:

- 密码口令登录: 简单, 但是不安全, 公网主机,容易被攻击.
- SSH-KEY 登录: 需要设置



## 2. 使用 SSH-KEY 登录配置原理:

1. 本机(Mac or winPC), 生成 SSH-KEY(公钥 id_rsa.pub 和私钥 id_rsa)
2. 远程主机(Ubuntu), 创建目录和文件: ~/.ssh/authorized_keys
3. 将本机(Mac or winPC)公钥 id_rsa.pub 内容拷贝并添加到 远程主机(Ubuntu)的 authorized_keys 文件中
4. 本机, 使用 SSH 登录工具(如 ZOC), 输入用户名, 勾选本机 SSH-KEY 私钥, 连接远程主机.

## 3. 配置过程:

### 3.1 Mac 本机生成 SSH-KEY:

- 略
- 路径: ~/.ssh/
- 私钥: ~/.ssh/id_rsa
- 公钥: ~/.ssh/id_rsa.pub

```bash

# ssh-keygen:生成秘钥对
# 其中：
#  -t指定算法
#  -f 指定生成秘钥路径
#  -N 指定密码
ssh-keygen -t rsa 


# 本地公钥, 上传到远程主机:
scp ~/.ssh/id_rsa.pub root@192.168.1.3:~/.ssh/


```


### 3.2 远程主机创建.ssh 目录

- 文件和目录的权限千万别设置成chmod 777.这个权限太大了，不安全，数字签名也不支持
- 本机生成的rsa/dsa签名的公钥, 是给远程主机使用的. 公钥内容, 要拷贝到远程主机的.ssh/authorized_keys中


```bash

# 创建目录:
cd ~
mkdir .ssh
chmod 700 .ssh

# 创建文件:
cd .ssh
touch authorized_keys
chmod 600 authorized_keys


# 写入公钥内容:
echo 'ssh-rsa public ' >> ~/.ssh/authorized_keys

# 写入方法2:(该公钥,是有本地主机, 上传到远程主机上的)
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys 


```

### 3.3 本机SSH 连接远程主机:

- ZOC 连接,设置步骤略.
- 尝试连接, 若成功.则进行下一步,禁用密码登录方式.

### 3.4 禁用 SSH 的密码登录方式:
- 修改: vim /etc/ssh/sshd_config

```bash

#禁用密码验证
PasswordAuthentication no

#启用密钥验证
RSAAuthentication yes
PubkeyAuthentication yes

#指定公钥数据库文件
AuthorsizedKeysFile .ssh/authorized_keys


```

- 重启 SSH 服务, 重新使用  SSH 口令方式登录远程主机, 验证是否已成功禁用
- 若提示: [SSH] FAIL: Permission denied (publickey). 则表明禁用成功.

```bash

#RHEL/CentOS系统
service sshd restart

#ubuntu系统
service ssh restart

#debian系统
/etc/init.d/ssh restart


```


## 4. 参考:

- [SSH 使用密钥登录并禁止口令登录实践](https://linux.cn/article-5776-1.html)


