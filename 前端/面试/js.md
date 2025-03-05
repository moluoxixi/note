---
title: js
description: 一个js笔记
date: 2025-03-05
hidden: false
tags: js
ptags: 
---
# js

## typeof & toString & delete

```js
-->typeof可以判断哪些类型
	7种 : number、bigint、string、boolean、undefined、Symbol及function
	对于其他的类型返回结果都是字符串的object,无法进一步判断

-->Object.prototype.toString
	对象在创建之时，会使用用this对象`[[Class]]`记录对象创建时的类型,这个属性是不可读的，Object.prototype.toString调用时,会使用this对象的`[[Class]]`来作为返回值的第二个字段`[[object 第二个字段]]`

-->delete
	delete运算符用于删除变量与值之间的连接,并不是之间删除值
	var a={p:{x:1}};
	var b=a.p;
	delete a.p;
	console.log(b); //{x:1}

```

## ES6

```js
-->??
	空值合并运算符,当左侧的操作表达式值为 null或者 undefined时，返回其右侧操作表达式值，否则返回左侧操作表达式值。
	null??1 //1
	undefined??1 //1
	0??1 //0
-->?.
	可选链操作符,在左侧表达式值为 null或者 undefined时,执行右侧代码

-->super关键字
	super指向当前方法的隐式原型属性`__proto__`

-->new.target属性
	返回实例化了的构造函数, 用于判断构造函数/Class 是否实例化
	1. 该属性一般用在构造函数之中，返回new命令作用于的那个构造函数
	2. 如果构造函数不是通过new命令调用的，则返回undefined
	3. Class 内部调用new.target，返回当前 Class。

-->Set Map WeekSet WeekMap
	Set 类似一维数组,[...],存储的值会去重,保证都是独一无二的
	Map 类似二维数组,[[key,value],..],key和value可以是任何类型,常用于非string类型key的情况
	WeekSet,WeekMap,类似Set,Map,区别是,他们的成员必须是对象,且对成员的引用是弱引用,垃圾回收时会被直接回收掉

-->class

	1. 无修饰符/public,代表公有,声明的属性或方法会挂载在类本身的实例身上,后代通过super继承实例成员后,可通过this访问
	2. constructor方法是类的默认方法，通过new命令生成对象实例时，自动调用该方法。一个类必须有constructor方法，如果没有显式定义，一个空的constructo方法会被默认添加。
	3. static代表静态,声明的属性或方法会挂载在类自身上,后代无法通过this访问
	4. #代表私有, 声明的属性或方法只能在类内部访问

-->Promise
	将异步以同步的形式表现出来,具有all allSettled any race resolve reject 6种静态方法,其原型对象上具有then catch finally 三种方法
	all(Promise[])
 


-->公有/私用/静态/特权
	公有属性和公有方法:属于这个类的所有对象都可以访问到的属性和方法
	私有属性和私有方法:只能在类的内部访问的属性和方法
	静态属性和静态方法:挂载在类自身身上而不是实例身上的方法/属性
	特权方法:有权访问内部私有属性和私有方法的公有方法
```

## 垃圾回收&上下文

```
## 垃圾回收机制&执行上下文&this

```sh
-->垃圾回收机制
    是浏览器回收js垃圾对象的机制,会单独开辟线程
    引用计数法:每包含一次对变量的引用,引用计数+1,为0则清除
    标记清除法:
    将内存区分为新生代和老生代,新生代区域又分为使用区和空闲区,当一个对象超过新生代内存的25%,或经过多次标记仍未清除会被挪到老生代,
    当使用区满时,执行一次垃圾回收机制:
    	从根对象出发,标记所有可达对象,,将所有可达对象复制到空闲区排序,不可达对象清除,使用区与空闲区交换,
    老生代仅清除不可达对象并排序
​
-->执行上下文
    是描述代码执行的抽象概念,描述代码的执行环境
    有以下几个明确步骤:
    确定this绑定
    创建词法环境
    创建变量环境
    ​
    词法环境由以下两部分组成:
    - 环境记录(存储变量和函数)：用于存储变量和函数声明的实际绑定位置,规定了标识符与上下文之间的映射关系
    - 对外部环境的引用(用来实现作用域链)：记录当前环境对外部词法环境的环境记录的引用(全局词法环境对外部环境的引入记录为null)
    ​- 变量环境也是一种词法环境,主要用于存储var声明的变量的实际绑定位置
    - [[Scopes]]是v8引擎在调试过程中使用的一种机制，用来展示当前函数所在的执行上下文可访问的作用域链。

-->this指向
    call,apply,bind强绑指向第一个参数
    new指向实例
    箭头函数没有自己的this,取自它所在的作用域的this
    都没有指向最近调用者,无调用者指向全局(默认window,严格模式undefined,node指向当前模块)
```

## ES6&数组方法

```sh
-->ES6知道什么
模板字符串 rest参数 解构赋值 const let iterator Symbol bigInt Set Map 
class 
    无修饰符(默认public)/public会将成员挂在实例上,后代通过super继承
    static会将成员挂在类自身
    #私有仅类内部访问
Promise
    异步操作以同步的流程表现出来,有6个
    resolve
    reject
    all
    allSettled
    race
    any
async/await generator
​
-->数组方法
​
```

## 继承&深浅拷贝

```
-->继承
原型链继承:使子类与父类通过原型链建立连接,父类构造函数的实例赋值给子类原型对象,并重新将构造器指向子类
借用构造函数继承: 子类构造函数内 将父类函数通过强绑定将this指向子类构造函数实例(即 fn.bind(this))
组合继承:以上两种继承的结合
es6 extends继承
​
-->深浅拷贝
深浅拷贝说的是对象通过创建对象的方式产生一个一模一样的对象的过程
当其中存在引用赋值时,称为浅拷贝,完全不存在引用赋值,就是深拷贝
​
手写要点:
函数接受对象,第二个参数维护一个Map默认值,
判断是对象or数组,
拷贝的时候,将对象/数组的值作为键,新创建的空数组/对象作为值存在Map中,
新创建的对象
​
​
function deepCopy(obj, visited = new WeakMap()) {
  // 如果是基本类型或者已经拷贝过的对象，则直接返回
  if (obj === null || typeof obj !== 'object') {
    return obj;
  }
​
  // 如果已经拷贝过该对象，则直接返回之前创建的副本，避免循环引用
  if (visited.has(obj)) {
    return visited.get(obj);
  }
​
  // 处理特殊情况，如日期对象
  if (obj instanceof Date) {
    return new Date(obj.getTime());
  }
​
  // 处理数组
  if (obj instanceof Array) {
    const arrCopy = [];
    visited.set(obj, arrCopy);
​
    for (let i = 0; i < obj.length; i++) {
      arrCopy[i] = deepCopy(obj[i], visited);
    }
​
    return arrCopy;
  }
​
  // 处理普通对象
  if (obj instanceof Object) {
    const objCopy = {};
    visited.set(obj, objCopy);
​
    for (const key in obj) {
      if (obj.hasOwnProperty(key)) {
        objCopy[key] = deepCopy(obj[key], visited);
      }
    }
​
    return objCopy;
  }
}
```

## 判断数据类型&事件轮询&防抖节流

```javascript
-->如何判断数据类型
typeof可以判断function和除null外的6种基本数据类型(bigInt,Symbol,number,string,boolean,undefined)
instanceof判断除对象外的所有复杂数据类型
isArray判断Array
​
-->事件轮询
当一个异步任务执行时,会将遇到的宏任务推入宏任务队列,微任务推入微任务队列进行等待,当一个宏任务执行完毕,会执行空微任务队列中的所有微任务,再去执行宏任务
​
-->防抖节流
防抖是多次变一次,
节流是多次变少次
```

## 浏览器缓存与存储

```js
-->浏览器缓存
分为强制缓存和协商缓存
强制缓存,服务器返回expires(一个日期代表资源有效期) 和 cache-control(缓存策略)字段,再请求头携带
协商缓存,服务器返回etag(文件唯一标识) 和last-modified(最后修改事件) 字段,请求头携带if-none-Match和if-modified-since(对应服务器返回的那两字段,两两对比相同未修改,不同就修改了)
​
-->浏览器存储
分为cookie&sessionStorage&localStorage&indexDB
三者都是明文传输存在本地,只支持字符串和JSON
cookie         按域名存储   4k,随浏览器一起发送
sessionStorage 按标签页存储 与localSotrage一样是5-10M
indexDB           用于大型存储,localForage作为封装库,可以根据浏览器版本选择indexDB和localStorage
​
token和session不是浏览器存储,token算法存在服务器,session内容存在服务器,分别返回session_id和token字段回浏览器
```

## 输入 url 做了什么&三次握手&四次挥手

```javascript
-->输入url做了什么
用户输入URL按回车
解析获得ip和端口
通过ip和端口寻址
TCP三次握手,如果是 HTTPS：进行安全的 TLS 握手以建立加密连接。
请求html资源
如果管道未被复用,下载完毕四次挥手
    浏览器开始解析html结构
    先进行预加载,发现预加载内容并进行资源请求,例如async script,preconnect等
    在进行主解析,逐行解析html内容,解析到请求就进行下载
    下载过程中如果未复用TCP管道又会进行TCP握手
当html结构解析完毕后,包括css解析完毕后,生成DOM Tree,cssom tree
    合并两个Tree生成render Tree,渲染树包含了每一个即将出现在屏幕上的节点，以及每一个节点的样式属性
    进行布局计算,计算每个渲染树节点的几何位置。
    将渲染树的每个节点绘制到屏幕上，生成位图。
    栅格化,将位图转换为图块（Tiles），并进行栅格化，准备发送到 GPU。
​    GPU 负责将图块合成并绘制到屏幕上。
-->三次握手
浏览器向服务器发包请求建立连接
服务器发包同意并请求浏览器建立连接
浏览器发包同意
​
-->四次挥手
浏览器向服务器发包请求断开连接
服务器发包同意断开
等待服务器向浏览器传输完资源后,服务器向浏览器发包请求断开连接
浏览器同意断开连接
```

## 手写 new

```
-->new
创建一个空对象,
使传入的构造函数的原型对象赋值给这个空对象的原型,
改变构造函数的this使它指向空对象,
根据构造函数的返回值类型是否是复杂数据类型选择返回值
```

## 作用域链&原型链&闭包√

```
-->原型链
所有的函数都是Function创建的,所有的对象都是Object创建的,
每个对象都有原型,每个函数都有原型对象,
对象的原型指向创建它的构造函数的原型对象这样一层层往上的链式结构称为原型链,
原型链的终点是null
​
-->作用域链
作用域指的是变量的有效范围,作用域链指的是查找变量一层层往上的链式结构
​
-->闭包
闭包是引用了外部函数变量的函数
```

## 跨域&简单/复杂请求

```js
-->跨域
同源是指 : 协议、ip、端口号完全相同。域名就是ip+端口关联的新地址 
违背同源策略就是跨域, 通常使用 JSONP, CROS, proxy, 解决跨域
JSONP:
1. 利用 script 标签不会触发跨域的特点, 进行数据传输
2. 定义一个函数用于接收后端返回的数据, 比如 json 串, 例如 `const abc=(data)=> data`
3. 在该函数之后定义一个 script 标签指向服务器的 get接口, 用于指定调用的函数名, 例如`http://localhost:3000/testAJAX?callback=abc`
4. 该接口返回一个字符串用于调用函数并接收 json 串, 例如 `callback(json 串)` 

-->简单请求&复杂请求
简单请求的跨域**只需要服务端设置访问控制允许源 (Access-Control-Allow-Origin) 为请求的地址 (如果请求地址写 `*`, 则代表允许所有跨域访问)**
  简单请求的条件:
1. 请求方法必须是 GET、POST 或 HEAD
2. 请求头中仅包含安全的字段, 常见的安全字段包括：
	1. Accept：表示客户端能够接收的内容类型。
	2. Accept-Language：表示客户端优先接受的语言。
	3. Content-Language：表示资源所用的自然语言。
	4. DPR、Downlink、Save-Data、Viewport-Width、Width：这些字段通常与设备特性或用户偏好相关。
	5. Content-Type：对于 POST 请求，其值必须是 `application/x-www-form-urlencoded`、`multipart/form-data` 或 `text/plain` 中的一个。这些类型主要用于表单数据的提交，对服务器的影响较小。

不满足简单请求的就是复杂请求, 具有如下特点:
1. 在正式通信之前，会先发送一个预检请求
2. 预请求中包含 CORS 特有的内容，如 `Access-Control-Request-Method`（实际请求的种类）和 `Access-Control-Request-Headers`（复杂请求所使用的头部）
```
