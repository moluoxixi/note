---
title: vueRouter
description: 一个vueRouter笔记
date: 2025-03-05
hidden: false
tags:
  - vueRouter
ptags:
  - vue
---
## vueRouter
### 路由守卫

```js
-->路由守卫
离开,更新,进入,解析
​
跳转路由
当前路由组件触发beforeRouteLeave触发
再调用全局的beforeEach,
如果路由参数变化调用beforeRouteUpdate,
再调用路由内守卫beforeEnter,
开始解析异步路由组件和组件,
调用组件内的beforeRouteEnter,
调用全局的beforeResolve,
调用afterEach
DOM更新.
```


### history 和 hash 的区别

首先, history 和 hash 都是通过 h5 新增的 pushState 和 replaceState 修改路径的, 不会引起页面刷新

/ #作为锚点标志 , 用于区分接口请求地址和前台路由地址

hash 带/#

history 不带

修改 hash 路由是修改锚点地址, 不会更改接口请求地址, 因此不会出现 404

history 是 h5 新增的, 修改 history 路由是直接修改接口请求地址, 因此刷新页面会出现 404

番外: vue 的路由怎么通过 history 的两个方法实现的

### 解决 history404?

```js
//在devServer配置项中添加配置项
devServer:{
    historyApiFallback:true,    //将所有404的页面都替换为index.html
}
//webpack中将打包的页面指定为/开头
output:{
    publicPath:'/'    public文件内的引入都变成以/开头
}
//naginx配置服务器始终返回入口文件
location / {
    try_files $uri $uri/ /index.html;
}
```

### params 配置项和 path 配置项可以同时存在吗?

不可以

path 可以与 query 配置项同时存在

name 可以与 params 与 query 同时存在

### 如何指定 params 参数可传可不传?

routes 配置项中使用: 占位符?

这个问号代表可传可不传

### 如果指定 name 和 params 配置项, 但 params 参数的值是空串, 无法跳转, 路径出现问题

问题?

路径会丢失路由地址

直接不传 params, 但这样不好

在为空传的 params 参数那使用或运算符替换为 undefined

### 路由组件能不能传 props 参数

通过在组件内使用 props 接收 props 配置项传递的参数

如果只需传 params 参数, 直接 props: true, props 对象映射 params 对象

如果只需传 params 和 query 之外的自定义参数

如果需要传 params 和 query 参数以及自定义参数

### vue-router 报错 3.1.0 版本之后引入了 promise, 重复点击会抛出 Uncaught (in promise) NavigationDuplicated

`$router.push/replace是VueRouter显示原型上的方法`

具有三个参数, 分别为配置项和两个回调

如果只传配置项和一个回调, 这个回调会处理成功和失败的 promise

如果传配置选项和两个回调, 这两回调会分别处理成功和失败的 promise

因此, 如果不传回调时, 当 promise 失败时抛出的错误无法处理, 就会抛出以上错误

解决方案:

降版本

`$router.push/replace.catch`

或二次封装

```js
let replaceRouterFn = () => {
  const original = Router.prototype.push;
  const originalReplce = Router.prototype.replace;
  Router.prototype.push = (location, ...rest) => {
    rest.length ? 
      original.call(this, location, ...rest) 
      :original.call(this, location, () => {});
  };
  Router.prototype.replace = (location, ...rest) => {
    rest.length ? 
      originalReplce.call(this, location, ...rest) 
      :originalReplce.call(this, location, () => {});
  };
  replaceRouterFn = null;
};
replaceRouterFn();
```

### 编程式路由导航与声明式路由导航的区别

编程时路由导航利用函数实现路由跳转

声明式路由导航利用 `<router-link/>` 组件标签

**谁的效率高?**

编程式路由导航每次使用创建一个函数

声明式路由导航每次使用创建一个组件, 并实例化成组件对象

因此 `编程时路由导航效率要高一些`
