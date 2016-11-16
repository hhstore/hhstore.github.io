title: "Pythonic - 用优雅的方式写Python代码"
date: 2015-08-20 17:12:10
categories: Python
tags: [Python, Pythonic]
---

本篇准备整理各种Python的编程规范,以及比较Pythonic的代码技巧.

<!-- more -->


## 1. 前言

- 写Python也比较久了,感觉有必要认真总结一下常用的Pythonic技巧.
- Python是一门很优雅的语言,对日常代码,有各种"推荐写法".特别适合各种"强迫症".
- 官方有PEP8规范,强迫你按推荐"姿势"写代码.如果你的姿势不优雅,会被认为很low.
- 初级的PEP8规范: 空格缩进,变量,函数,类命名规范,空行,注释规范.好在pycharm会自动提示.
- 中级的代码推荐写法: 各种优雅的代码,越简洁明了,越推荐.杜绝各种"冗长代码". <<Python Cookbook>>里有很多技巧.
    - 列表解析
    - 装饰器
    - 解包
    - with语句
    - yield语句
- 高级点的: 个人理解是充分理解Python的内部实现机制,正确合理选择适合的数据结构和算法,以及库和框架.做到物尽其用.
    - 充分使用标准库(减少重复造轮子)
    - 正确的姿势使用第三方库
    - 优雅的使用框架



## 2. 什么是Pythonic?

对于这个词,我个人的理解是: 

- 请尽可能的用更优雅的方式写Python.
- 请尽可能的使用Python标准写法.
- 请尽可能的使用Python推荐写法.
- 请杜绝丑陋的其他语言惯性的写法.


更详细的解读,参考用google检索Pythonic,所找的的高质量的文章.

- [What is Pythonic?](http://blog.startifact.com/posts/older/what-is-pythonic.html)
- [赖勇浩: Pythonic到底是什么玩意儿？](http://blog.csdn.net/gzlaiyonghao/article/details/2762251)
- [知乎提问:初学 Python，有哪些 Pythonic 的源码推荐阅读？](http://www.zhihu.com/question/20336475)
- [让你的python代码更加pythonic](http://wuzhiwei.net/be_pythonic/)
- [写地道的PYTHON](http://www.pythonpub.com/article/1483)
- [十个我希望早点知道的python方法](http://www.codefrom.com/c/214)
- [一些pythonic代码的例子](http://michaelyou.github.io/2015/04/16/%E4%B8%80%E4%BA%9Bpythonic%E4%BB%A3%E7%A0%81%E7%9A%84%E4%BE%8B%E5%AD%90/)
- [Python实用技巧-成为Pythoner必经之路](http://justjavac.com/python/2012/04/13/pythoner-handout.html)
- [Python 编码时应该注意的几件事情](http://justjavac.com/python/2012/07/27/python-a-few-things-to-remember.html)
- [Python 实用技巧](https://github.com/lzjun567/note/blob/master/note/python/useful_features.md)
- [干货: Python 的神奇方法指南](http://justjavac.com/python/2013/06/11/a-guide-to-pythons-magic-methods.html)


在Python解释器中,执行: import this 回车,会显示如下信息:

```python
import this

The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!

```

这首小诗,说明了Python的代码哲学.值得好好体会.




## 3. 更 Pythonic 的代码技巧清单

### tips

- tip01. 对换变量值.

```Python

a = 1
b = 2

# Pythonic, 使用元组的unpack技巧,一行代码解决.
a, b = b, a
(a, b) =  (b, a)

# Not-Pythonic, 典型的C语言思维.
temp = b
b = a
a = temp
```


- tip02. 链式比较


```Python

a = 1
b = 5

# Pythonic
1 <= a <= b <10                # True

# Not-Pythonic
a >= 1 and a <=b and b < 10    # True

```

- tip03. 真值测试

    - 为真条件: 
        - True值  
        - 任意(非空字符串, 非0数字, 非空容器)
        - 其他任意非False值
    
    - 为假条件:
        - False值
        - 空字符串: "", ''
        - 数字0
        - None
        - 空容器,包括 [], (,), {}, set()


```Python

# Pythonic
if 真:
    print 真
    

# Not-Pythonic
if 真 == 真:
    print 真
    
```

- tip04. 字符串反转

```Python
# 原始串: ABC
# 反转串: CBA

# Pythonic
s1 = "ABC"
s2 = s1[::-1]

def reverse(s):
    return s[::-1]  # 反转

# Not-Pythonic
def reverse(s):
    temp = ""
    for i in xrange(len(s)-1, -1, -1):
        temp = "{0}{1}".format(temp, s[i])  # 逐个字母反转拼接
    return temp

```

- tip05. 回文检测

```Python
# 应用上例技巧实现
# 回文串: AAABAAA (对称) // AAABBAAA

# Pythonic
def is_palindrome(s):
    return bool(s == s[::-1])    # return True or False

# Not-Pythonic
# 各种尝试首尾单一字符比较判断的思路.
    
# 回文检测: 递归版本
def is_palindrome_recursion(s):
    if len(s) <= 1:
        return True
    else:
        return s[0] == s[-1] and is_palindrome_recursion(s[1:-1])
    
# 回文检测: 循环版本
def is_palindrome(s):
    for i in range(len(s)/2):
        if not s[i] == s[len(s)-i-1]:
            return False
    return True

```


- tip06. 字符串列表连接(join函数应用)

```Python
# 使用场景: 常见于 路径拼接
# 示例: str_list = ["c:", "users", "xiaoming", "hello.txt"]

# Pythonic
file_path = ["c:", "users", "xiaoming", "hello.txt"]
result = "/".join(file_path)  # result = "c:/users/xiaoming/hello.txt"

def join_str(sources, sep):  
    return sep.join(sources)   # 简单包裹join函数: 
                               # sep:连接符
                               # sources: 可迭代序列(可以是字符串,列表,元组)

# Not-Pythonic
# 根据join函数特点,简单实现了一个同样效果版本.
# 初步测试效果同join(),由于没看join()的实现源码,可能不完善.
def join_str_ex(sources, sep):
    result = ""
    if isinstance(sources, (str, list, tuple)):
        for item in sources:
            result = "{0}{1}{2}".format(result, item, sep)
        result = result[0:(len(result) - len(sep))]  # 保持拼接效果完全一致
    elif isinstance(sources, dict):
        for key, value in sources.iteritems():
            result = "{0}{1}{2}".format(result, key, sep)
        result = result[0:(len(result) - len(sep))]
    return result


```

- tip06. 列表内置函数应用(sum, max, min)


```Python
# 对数组元素,求和,寻找最大值,最小值,是常见需求.
# Python的list,已经内置了处理函数.无需自己写.

# Pythonic
from operator import mul
nums = [1, 2, 3, 4, 5, 6, -1]
print sum(nums), max(nums), min(nums), reduce(mul, nums, 1)   # return 20, 6, -1, -720(乘积)


# Not-Pythonic

sum_all = 0
max_num = -float('inf')
min_num = float('inf')
mul_all = 1

for num in nums:
    if num > max_num:
        max_num = num
    if num < min_num:
        min_num = num
    sum_all += num
    mul_all *= num
print sum_all, max_num, min_num, mul_all

# 简单测试，在numList的长度为10000000时，对列表求和，
# Pythonic 耗时0.6s，Not-Pythonic 耗时1.3s，将近两倍的差距。

```


- tip07. 待更新补充.


```Python

# Pythonic


# Not-Pythonic

```

















