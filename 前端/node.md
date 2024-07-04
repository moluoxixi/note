# 模块讲解与内置模块

## 模块介绍与五个默认形参

js文件被node启动时,这个js文件被称作一个模块

模块默认被一个函数包裹,当js被node启动时,函数直接执行,并传入对应实参

这个函数具有以下形参:

exports    默认指向module.exports初始指定的对象

require    引入模块的方法

module    当前module对象的详细内容

__filename    当前的文件的绝对路径

__dirname    当前的文件所在的文件夹的绝对路径

## exports

1. module.exports

指向的对象就是模块真正暴露出来的内容

1. module.exports默认指向一个空对象,我们可以修改它

1. exports默认也指向这个空对象

- 即exports默认具有暴露内容的功能

- 即module.exports或exports指向新地址后,exports失去暴露内容的功能

```
module.exports=function fn(){}    //将fn方法暴露出来
exports.fn=function add(){}    //module.exports已经修改,exports与module.exports不指向同一个地址,所以这里不暴露add方法
```

[http://docs.lipeihua.vip/#/./NodeJS/04.Node.js%E6%A0%B8%E5%BF%83%E6%A8%A1%E5%9D%97](http://docs.lipeihua.vip/#/./NodeJS/04.Node.js%E6%A0%B8%E5%BF%83%E6%A8%A1%E5%9D%97)

## events模块

events是

```
const events = require('events');
const myEvent=new events();    //实例化
​
myEvent.on('自定义的事件名',事件回调);    //设置并绑定事件
myEvent.once('自定义的事件名',事件回调);    //设置并绑定只执行一次的事件
myEvent.emit('自定义的事件名');    //触发该事件
```

## crypto模块

```
const crypto = require("crypto");
​
//创建某个加密方式的哈希对象
const md5 = crypto.createHash("md5");
//创建一个明文
let password = "lipeihua0921";
//加盐 
password += "8888"
//调用md5加密对象的update方法加密,得到密文对象,并且使用digest方法转为16进制字符串
const re = md5.update(password, "utf-8").digest("hex");
console.log(re);
```

## path模块

path模块提供

```
const path = require('path');
```

| 常见的属性和方法 | 说明 | 
| -- | -- |
| __dirname | 当前的文件所在的文件夹的 | 
| path.dirname(路径) | 返回路径截取掉路径所指文件或文件夹之后剩下的路径, | 
| path.extname(路径) | 返回路径指向的文件的扩展名 | 
| path.resolve(路径1,路径1的子路径,前一个路径的子路径,.....) | 将路径或路径片段的序列 | 
| path.join(路径1,...路径n) | 将路径像字符串拼接一样拼接起来 | 


path.dirname(路径)

```
path.dirname('../../作业/test/1.js')    输出 ../../作业/test
path.dirname('hh/作业/test/1.js')  输出 hh/作业/test
```

path.resolve(路径1,路径1的子路径,前一个路径的子路径,.....)

```
path.resolve()
```

## http模块

```
const http=require('http');     //引入http模块
```

### 创建请求

```
//创建一个请求
const req=http.request('协议://请求的ip地址:端口号',res=>{    //res参数是响应的对象    也是个可读流
}
//发送请求
req.end();
```

**http.request方法中事件回调的res参数的属性与方法**

res参数是

| 属性与方法 | 作用 | 
| -- | -- |
| res.statusCode | 状态码 | 
| res.on('data',chunk=>{}) | 每次数据传递过来时触发 | 
| res.on('end',()=>{}) | 当res所有的 | 


### 创建server服务

```
const server=http.createServer((request,response)=>{
    //request:请求对象    是个可读流对象
    //response:响应对象  是个可写流对象
    //设置响应头中 响应内容的格式和编码
    response.setHeader("Content-Type", "text/plain;charset=utf-8");
    //发送响应数据
    response.end('响应数据');
})

```

### 创建服务监听

ip:主机地址 127.0.0.1/localhost(本地主机地址)

在cmd中输入ipconfig 查看自己的局域网ip

端口号:0-65535(范围)

```
//设置服务器的ip和端口号
server.listen(端口号, "ip地址", err => {})//当服务器被成功启动,则函数会自动执行

```

## fs模块

```
const fs = require("fs");    //引入fs模块
```

| 方法 | 说明 | 返回 | 
| -- | -- | -- |
| fs.existsSync(codePath) | 检查对应文件是否存在 | Boolean | 
| fs.unlinkSync(codePath) | 删除指定目录下的文件 | 删除失败报错 | 
| fs.createReadStream('需要读取的文件目录'); | 创建可读流 | 返回可读流对象 | 
| fs.createWriteStream('需要写入的文件目录') | 创建可写流 | 返回可写流对象 | 
| 可读流对象.on('end',()=>{}) | 当 |   | 
| 可读流对象.on('data',chunk=>{}) | 可读流中只要有 |   | 
| 可写流对象.write('要写入的数据') | 将数据写入可写流中 |   | 
| 可读流对象.pipe(可写流对象); | 把可读流中的Buffer数据写入到了可写流 | 返回可读流对象 | 


```
/创建可读流
const rs = fs.createReadStream(filePath);
//创建可写流
const ws = fs.createWriteStream(resultePath)

//可读流中只要有buffer传递进来就会触发 可读流的data事件
rs.on("data", (chunk) => {
  console.log(chunk);
  //在可读流中得到的每一个数据 可以通过可写流依次写入到文件中
  ws.write(chunk);
})

//可读流有一个end事件 当文件读取完毕 则触发end事件
rs.on("end", () => {
  console.log("文件读取完毕");
  //当读完之后,关闭可写流的开头
  ws.end();
})
```

## util模块的promisify

util中有一个promisify方法,

用于将接收 参数组+用于处理结果的回调的函数,封装为promise

```javascript
//可用于fs.open,fs.write,fs.close等
const 变量=promisify(异步方法名);


//例如:
fs.readFile(参数1,参数2,结果回调)
const asyncReadFile=promisify(fs.readFile);
const res=asyncReadFile(参数1,参数2) //这里的res就是结果回调接收的参数
```

# 第三方模块

## form-data模块

用于创建form表单对象

npm i form-data

```java
const FormData=require('form-data');
const path = require('path');
let codePath = path.join(__dirname, `/dist.zip`);
let formData = new FormData();
//将前端文件对应的服务器存储地址和可读流添加到formData中
formData.append('path', path);
formData.append('distFile', fs.createReadStream(codePath));
```

## compressing模块

**用于压缩文件**

npm i compressing

```
const compressing=require('compressing');
//支持zip和tar等
compressing.压缩模式.compressDir(压缩后的保存路径,压缩文件路径).then
compressing.压缩模式.uncompress(压缩文件路径,解压后的保存路径).then

//eg
compressing.zip.compressDir('/path/to/source', '/path/to/destination.zip')

```

## mongoose模块

该模块专门

需要下载

### 连接数据库

```
const mongoose=require('mongoose');
mongoose.connect("mongodb://ip地址:端口号/数据库名",()=>{})    //回调函数为可选的,在数据库被打开时触发

//在数据库被打开时触发,可以用来替代mongoose.connect方法的回调函数
mongoose.connection.once("open", () => {})

```

### 创建当前数据库某个集合的约束对象

```
const 约束对象名=new mongoose.Schema({
    字段:{
        type:String/Number/[String],    //类型,字符串类型,数字类型,数组并且数组中的值为String类型
        unique:true/false,    //是否唯一
        required:true/false,    //是否必须输入
        default:'默认值'
    }
})

```

### 根据某个约束对象,去创建某个集合

```
const 实例对象名=mongoose.model('集合名',约束对象名);

```

### 增

使用create()

**返回值为promise实例,成功实例的值为新增数据(单个为对象,多个为数组)**

```
实例对象名.create({
    字段1:值1,
    ...,
    字段n:值n
})

```

### 删

使用deleteMany()和deleteOne()

**返回值为promise实例,成功实例的值为一个对象**

该对象上包含一个属性:

- deletedCount属性:删除的文档个数

```
实例对象名.deleteMany({查找的条件})

```

### 改

使用updateMany()或updateOne()

**返回值为promise实例,成功实例的值为一个对象**

该对象上包含两个属性:

- matchedCount属性:匹配到的文档个数

- modifiedCount属性:修改的文档个数

```
实例对象名.updateMany({查找的条件},{$set:{更新的内容})

```

### 查

使用find()或findOne()

**返回值为promise实例,成功实例的值为查询结果(数组)**

```
实例对象名.find({
    字段1:查询条件,
    ...,
    字段n:查询条件
})

```

## express模块

```
const express=require('express');

```

### 中间件

1.Express 是一个自身功能极简，完全是由路由和中间件构成一个的 web 开发框架

从本质上来说，一个 Express 应用就是在调用各种中间件。

2.中间件（Middleware） 

- req:请求    

**是个可读流对象**

- res:响应     

**是个可写流对象**

- next:调用该函数将控制权传递给下一个中间件

3.

- err:错误

### 怎么使用中间件

1. 使用

app.use()

1. 第一个参数如果不是path，则默认是"/"

### 中间件分类

#### 应用级中间件

**绑定到调用express()方法返回的那个实例对象上的中间件**

```
const express=require('express');
const app=express();
//使用函数将应用级中间件绑定到调用express()方法返回的那个实例对象上
app.use(中间件)

```

#### 路由器级中间件

1. 绑定到调用express.Router()方法返回的那个实例对象上的中间件

1. 路由器级中间件的工作方式与应用级中间件相同

```
const express=require('express');
const route=express.Router();
//路由器级中间件的工作方式与应用级中间件相同，只是它绑定到express.Router()
route.use(中间件)

```

#### 错误处理中间件

1. 在程序执行的过程中,难免发生错误。

1. 比如文件读取失败，数据库连接失败。

1. 错误处理中间件是

**一个集中处理错误的地方。**

#### 内置中间件

express.static(path)中间件

express提供的

1. 参数是静态资源的目录地址

1. express.static会把这个目录中的所有文件都暴露出去

1. 客户端可以按照路径访问这个目录中所有的静态资源

express.json()中间件

express提供的

**使用该中间件,给res上添加JSON方法,用于处理JSON**

**注意：适用于 Express 4.16.0+**

express.urlencoded()中间件

express提供的

**使用该中间件,给res上添加body,用于获取post等数据在请求体的请求数据**

 

#### 第三方中间件

第三方中间件

cookie-parser

**用于处理cookie**

使用该中间件为request对象添加cookies对象属性,用于访问cookie

为resonse对象添加cookie方法和clearCookie,用于设置cookie和删除cookie

跨域情况下需要设置'Access-Control-Allow-Credentials'为true,允许跨域携带cookie

```
//cookie中间件案例
var express = require('express')
var app = express()
var cookieParser = require('cookie-parser')
app.use(cookieParser())
app.get('/login',(req,res)=>{
    req.cookies
})

```

express-session

connect-mongo

### 创建路由中间件

```
const express=require('express');
const route=express.Router();    //创建路由中间件
route.请求方式('路由地址',(req,res)=>{});
module.exports=route;    //将路由器中间件暴露出去

```

### 请求路由的方式

1. use()不写路由地址,只写回调函数时,默认挂载在

/

| 方法 | 说明 | 
| -- | -- |
| app.get('路由地址',(req,res)=>{}) | 通过GET方式请求路由 | 
| app.post('路由地址',(req,res)=>{}) | 通过POST方式请求路由 | 
| app.use('路由地址',(req,res)=>{}) | 通过任意方式请求路由 | 


### 入口文件请求路由

```
const express=require('express');
const app=express();
const 路由组件名1=require('路由组件路径');    //引入路由中间件
...;
const 路由组件名n=require('路由组件路径');
app.use(路由组件名1,...路由组件名n);    //挂载路由中间件
app.get('路由地址',(req,res)=>{})    //通过GET方式请求路由
app.post('路由地址',(req,res)=>{})    //通过POST方式请求路由
app.use('路由地址',(req,res)=>{})    //通过任意方式请求路由

```

#### 请求路由回调函数的req参数上的方法或属性

| 方法/属性 | 说明 | 
| -- | -- |
| req.body | 请求体,即post的请求信息 | 
| req.query | 请求信息,即get的请求信息,由express.urlencoded()中间件提供 | 


#### 请求路由回调函数的res参数上的方法

| 方法 | 说明 | 
| -- | -- |
| res.end() | 默认响应(需要手动设置content-type响应头) | 
| res.json() | 响应json格式 | 
| res.send() | 响应任意格式 自动帮你设置content-type | 
| res.sendFile() | 响应一个文件出去 | 
| res.download() | 控制下载 | 
| res.redirect(状态码,'路由地址') | 重定向 | 
| res.json({对象}) | 响应一个json对象 | 


### 创建服务器监听

1. 除了端口号

**,后面两个参数为可选参数**

1. ip地址默认为当前根目录地址

```
const express=require('express');
const app=express();
//除了端口号,后面两个参数为可选参数
//ip地址默认为当前根目录地址
app.listen(端口号,'ip地址', err => {
  console.log("服务器启动成功 请访问 协议://ip:端口号");
})

```

## qs模块

用于

提供一个qs.parse方法,

```
req.url    //name=张三&age=18
qs.parse(req.url)    //{name:张三,age:18}

```

## NProgress模块

整进度条

### 下载

```
npm i nprogress

```

### 引入

```
分别引入到js和css

```

使用

```
nprogress.start()    //开始进度条
nprogress.done()    //结束进度条

```

## jwt-simple模块

简单token加密

### 引入

```
const jwt=require('jwt-simple')

```

### 方法

| 方法 | 作用 | 返回值 | 
| -- | -- | -- |
| jwt.encode(需要加密的字段,'用来当密钥的字符') | 将需要加密的字段加进行token加密 | 返回一个加密的字符 | 
| jwt.decode(需要解密的字符,'用来当密钥的字符') | 将加密的字符解密为正常字符 |   | 


## zlib模块

# Buffer缓冲器

### Buffer怎么使用

Buffer是

Buffer 类在全局作用域中，在Global上，可以直接使用，因此无需使用 require('buffer')

Buffer中存的是二进制的,打印Buffer会转成16进制显示,打印Buffer中的数据会转成10进制显示

- 可以遍历Buffer中的每一个值

- Buffer可以调用toString方法将Buffer转成字符串

```
const buf3 = Buffer.from('hello atguigu');
//遍历Buffer
buf3.forEach((item, index) => {
  //104、101、108、....
  console.log(item); // 打印时会自动转换成10进制显示
})
//将buffer转换成字符串
console.log(buf3.toString()); // hello atguigu

```

### Buffer.alloc(size[, fill[, encoding]])

创建一个新的干净的buffer容器

- Buffer.alloc(size[, fill[, encoding]])：

 返回一个指定大小的 Buffer 实例，如果没有设置 fill，则默认填满 0

```
const buf1=Buffer.alloc(10,'at');
console.log(buf1)    //61 74...
//先找到at的unicode编码这个编码是十进制的,再按编码转成二进制保存,为了显示方便,打印Buffer的时候转换为16进制显示出来

//将字符串用二进制在buffer中存起来
//buffer每个为1字节 - 1byte(b)
//buffer中的每一个值是16进制  00--ff   二进制就是00000000--11111111
//1个数据(1b)==》8bit（8位二进制数据）
//1个英文代表一个字节  中文位3个字节

```

### Buffer.allocUnsafe(size)

创建一个可能有垃圾的buffer容器

- Buffer.allocUnsafe(size)：

 返回一个指定大小的 Buffer 实例，但是它不会被初始化，所以它可能包含敏感的数据

```
  // 创建一个长度为 10、且未初始化的 Buffer。
  // 这个方法比调用 Buffer.alloc() 更快，
  // 但返回的 Buffer 实例可能包含旧数据，计算机删除的时候，等空闲才开始删除，所以可能会有遗留数据
  // 因此需要使用 buf2.fill() 或 buf2.write() 重写。
  const buf2 = Buffer.allocUnsafe(10);
  console.log(buf2);//<Buffer d4 d8 04 04 01 00 00 00 30 35>

```

### Buffer.from(string[, encoding])

根据数据创建Buffer容器

- Buffer.from(string[, encoding])：

 返回一个被 string 的值初始化的新的 Buffer 实例

```
//将字符串用二进制在buffer中存起来
//buffer每个为1字节 - 1byte(b)
//buffer中的每一个值是16进制  00--ff   二进制就是00000000~11111111
//1个数据(1b)==》8bit（8位二进制数据,8字节）
//1个英文代表一个字节  中文位3个字节
/*
    1 byte / b = 8 bit
    1 kb = 1024 byte
    1 mb = 1024 kb 
    1 gb = 1024 mb
    1 tb = 1024 gb
*/
const buf3 = Buffer.from('hello atguigu');
console.log(buf3); // <Buffer 68 65 6c 6c 6f 20 61 74 67 75 69 67 75>

```

### Buffer数据.toString()

把一个buffer转回字符串格式展示

# process

process

### process的常见的属性和方法

| 属性和方法 | 说明 | 
| -- | -- |
| process.argv | 返回一个数组，其中包含当 | 
| process.argv0 | 保存当 Node.js 启动时传入的  | 
| process.cwd() | 返回  | 
| process.exit('str') | 退出进程 | 
| process.nextTick(()=>{}) | 创建一个nextTick队列的微任务 | 
| process.env | 返回包含 | 


# 报文

## 报文头常见配置

### Content-Type属性的常见设置

#### 纯文本/html/css

```
  text/plain 纯文本
  text/html html文件
  text/css css文件

```

#### js/json/form格式

```
  application/javascript  js内容
  application/json json内容
  application/x-www-form-urlencoded form表单格式

```

#### image

```
image/gif gif格式图片
image/png png格式图片
image/jpeg jpg/jpeg格式图片

```

#### mp3/mp4

```
 video/mp4 视频格式
 audio/mp3 音频格式

```

### Set-Cookie属性设置

# 参考模型

OSI参考模型

|   |   | 
| -- | -- |
| 应用层 | 应用的协议,以及应用通信的细节 | 
| 表示层 | 转换成下一步需要的格式 | 
| 会话层 | 确定以什么方式连接,以及是否可以连接 | 
| 传输层 | 建立连接 TCP/IP(完整,慢) UDP/IP(时效性,快) | 
| 网络层 | 寻找网络地址,以及路由选择 | 
| 数据链路层 | 解析网络地址,路由,形成数据链路以供物理层传输 | 
| 物理层 | 传输数据,以0/1比特流,高低电压或者光信号等 | 


TCP/IP

|   |   | 
| -- | -- |
| 应用层 |   | 
| 传输层 |   | 
| 网络层 |   | 
| 网络接口层 |   | 


# 6种请求

GET    查    

POST    增    

PUT    改    

DELETE    删    用来请求服务器删除某资源,数据在地址上

HEAD    

OPTIONS 预检请求,

### GET和POST的区别

get获取,post新增

get缓存,post不缓存