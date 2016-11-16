title: Ubuntu部署uwsgi脚本问题解决
date: 2015-07-03 20:45:21
categories: Python
tags: [Python, Ubuntu, uwsgi]
---

今天在部署网站项目时,遇到一个问题.由于这个问题很常见,特记录下来,以备复查.


<!-- more -->


## 1. init进程.
- 当Linux启动时,init进程是系统启动之后的第一个用户进程，所以它的pid(进程编号)始终为1.
- init进程上来首先做的事是去读取/etc/目录下inittab文件中initdefault id值,这个值称为运行级别(run-level).它决定了系统启动之后运行于什么级别.运行级别决定了系统启动的绝大部分行为和目的.这个级别从0到6,具有不同的功能.

## 2. /etc/init.d/目录

- 这个目录下,存放的shell脚本能够通过响应start,stop,restart,reload命令,来管理某个具体的应用.
- 作用有点类似windows的注册表.


## 3. /etc/init.d/uwsgi

- 今天在修改uwsgi的服务脚本时,遇到一个问题.就是执行 restart 服务时,始终失败.
- 对脚本作了各种修改尝试,开始以为是kill进程未成功,就重启无效,加了sleep 睡眠等待,发现依然无效.
- 最后,认真观察进程发现是kill时,把自己也干掉了.当然无法继续执行后面的命令,所以要过滤进程所属的用户.
- killall : 根据进程名,杀死进程. 
    - -u选项: 过滤进程所属用户. 
    - -9选项: 强制杀死.

修改后的shell脚本如下:

```bash

#!/bin/bash

case "$1" in
  start)
        psid=`ps aux|grep "uwsgi"|grep -v "grep"|wc -l`
        echo psid
        if [ $psid -gt 2 ];then
            echo "uwsgi is running!"
            exit 0
        else
            echo "Start uwsgi service [OK]"
            uwsgi --ini /etc/uwsgi/apps-enabled/www.website.com.ini
        fi
        ;;
  stop)
        killall -9 -u "www-data" uwsgi      # 过滤 用户组,防止误杀自己.
        echo "Stop uwsgi service [OK]"
        ;;
  restart)
        killall -9 -u "www-data" uwsgi      # 过滤 用户组,防止误杀自己.
        echo "Restart uwsgi service [OK]"
        uwsgi --ini /etc/uwsgi/apps-enabled/www.website.com.ini
        ;;
  *)
        echo "Usages: sh uwsgiserver.sh [start|stop|restart]"
        ;;
esac


```

## 4. 后台执行uwsgi服务

- 这是后台运行程序的写法.使用 nohup 和 & 实现效果.
- 单独使用 & 时,当退出终端,后台运行的程序会自动结束.这显然不符合服务器端程序要求.
- 配合 nohup 实现.同时,会在当前目录,产生一个名为nohup.out的日志文件,记录执行情况.
- 如下命令,自动调用/etc/init.d/uwsgi 服务.也就是上面的脚本.

```bash
(nohup service uwsgi restart &)   # 后台运行服务. 这里是在重启服务.
```

## 5. 回顾总结

- 由于该问题很常见,经常需要kill进程,然后重启服务.很容易犯如上这种错误.
- 记录下来,以备复查.