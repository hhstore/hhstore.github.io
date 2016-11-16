title: Python拾遗 - callable()函数
date: 2015-08-25 17:12:10
categories: Python
tags: [Python]
---

本篇介绍Python的callable()函数的特点以及应用.

<!-- more -->


## 缘由

- 在阅读bottle源码中,发现在实现 Bottle() 类中的 add_controller()的时候,有处callable()调用,很好奇这个语法.
就仔细了解了一下,很有意思的应用.

- 源码片段如下:

```python
    # Bottle()类代码截取片段.
    # 注意与 add_route() 相互调用
    def add_controller(self, route, controller, **kargs):
        """ Adds a controller class or object """
        if '{action}' not in route and 'action' not in kargs:
            raise BottleException("Routes to controller classes or object MUST"
                                  " contain an {action} placeholder or use the action-parameter")
        for action in (m for m in dir(controller) if not m.startswith('_')):
            handler = getattr(controller, action)
            if callable(handler) and action == kargs.get('action', action):
                self.add_route(route.replace('{action}', action), handler, **kargs)   # 特别注意.相互调用

    def add_route(self, route, handler, method='GET', simple=False, **kargs):
        """ Adds a new route to the route mappings. """
        if isinstance(handler, type) and issubclass(handler, BaseController):
            handler = handler()
        if isinstance(handler, BaseController):
            self.add_controller(route, handler, method=method, simple=simple, **kargs)   # 特别注意.相互调用
            return

        method = method.strip().upper()
        route = route.strip().lstrip('$^/ ').rstrip('$^ ')
        if re.match(r'^(\w+/)*\w*$', route) or simple:
            self.simple_routes.setdefault(method, {})[route] = handler
        else:
            route = re.sub(r':([a-zA-Z_]+)(?P<uniq>[^\w/])(?P<re>.+?)(?P=uniq)',
                           r'(?P<\1>\g<re>)', route)
            route = re.sub(r':([a-zA-Z_]+)', r'(?P<\1>[^/]+)', route)
            route = re.compile('^%s$' % route)
            self.regexp_routes.setdefault(method, []).append([route, handler])


```


## callable() 说明

- 简单说: 判断被传参元素,是否是"可调用对象".(可以是函数,lambda表达式,定义了__call__()的类以及其实例)

- 安装过iPython,可以在python解释器中输入如下帮助命令:

```python
help(callable)

```

- 回车,显示如下信息:

```python
Help on built-in function callable in module __builtin__:

callable(...)
    callable(object) -> bool
    
    Return whether the object is callable (i.e., some kind of function).
    Note that classes are callable, as are instances with a __call__() method.

######################################## 

对应含义:
    1. 判断 是否 是可调用对象.(返回 true or false)
    2. 函数,是可调用的.
    2. 实现了__call__()方法的类(以及实例),是可调用的.

```



## callable()测试实例代码:

- 以下测试代码,在iPython中测试通过.
- 对比如下实例代码,就可以很明白的理解 callable() 的功能和使用方法.
- 如下实例,包含了所有类型的测试.

```python

In[6]: callable(1)
Out[6]: False

In[7]: callable(True)
Out[7]: False

In[8]: callable(False)
Out[8]: False

In[9]: callable("hello")
Out[9]: False

In[10]: callable([1, 2, 3])
Out[10]: False

####################################

# 所有的 Python 自带的类型,都是可调用的.

In[11]: callable(list)
Out[11]: True

In[12]: callable(set)
Out[12]: True

In[15]: callable(tuple)
Out[15]: True

In[16]: callable(str)
Out[16]: True

In[17]: callable(dict)
Out[17]: True

In[18]: callable(int)
Out[18]: True

In[19]: callable(float)
Out[19]: True

####################################

# lambda表达式是可调用的

In[27]: f = lambda x: x*2
In[28]: callable(f)
Out[25]: True

####################################

# 函数是可调用的.

In[31]: def g():
...     print "g()"
...     
In[32]: callable(g)
Out[29]: True



####################################

# 各种类定义对比,同时对比 类 和 类实例.

In[5]: class A(object):
...     pass
...     
In[6]: callable(A)
Out[6]: True
In[7]: callable(A())
Out[7]: False

####################################


In[2]: class B:
...     pass
...     
In[3]: callable(B)
Out[3]: True
In[4]: callable(B())
Out[4]: False

####################################


In[8]: class C(object):
...     def __call__(self):
...         print "class C."
...         
In[9]: callable(C())
Out[9]: True
In[10]: callable(C)
Out[10]: True


####################################


In[11]: class D:
...     def __call__(self):
...         print "class D."
...         
In[12]: callable(D)
Out[12]: True
In[13]: callable(D())
Out[13]: True

```
