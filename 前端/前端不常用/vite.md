# 原理

vite是基于es module(script type:module&import)实现的，当我们访问index.html的时候，浏览器会引入index.html引入的相关模块及其依赖模块并进行下载操作

vite将代码分为源码和依赖两块,依赖是指node module中的第三方包(不会变),源码是指开发的代码(时刻会变)

在 `启服务(npm run dev等)` 的时候,仅执行预构建,仅包锁(例如package.lock),vue.config.js，node_env变化时会重新预构建

- 如果有缓存且依赖无变化,直接使用缓存,
- 先扫描项目引入的依赖(通过esbuildScanPlugin)，
- 再将node_modules下非esmodule的处理为esmodule，
- 最后将他们进行打包变成一个esmodule模块(结果缓存在node_modules/.vite中)

服务起了后,vite会基于connect起了一个开发服务并监听请求，并通过中间件处理这些请求(项目跑的时候可以看到那些中间件)，将源码文件进行编译。

# 环境变量

默认情况下:

npm run dev 会加载 .env 和 .env.development 内的配置npm run build 会加载 .env 和 .env.production 内的配置

development 和production 即mode，mode 可以通过命令行 --mode 选项来重写。

**所有env环境变量保存在import.meta.env对象中**

```
//例如:
"scripts": {
  "test": "vite --mode test",
  "dev": "vite",
  "build": "vite build"
},
​
//此时npm run test 会加载 .env 和 .env.test 内的配置
```

# 特点

1. 依赖采用预构建&强缓存,源码采用按需编译&协商缓存
2. 预构建采用esbuild,而esbuild用go写的,很快
3. 按需编译仅在devServer请求该文件时去编译该文件为ESM返回给浏览器处理

# 模块的区分

vite将模块区分为 `依赖` 和 `源码`

## 依赖

即不会变动的纯 JavaScript,例如组件库

Vite 将会使用 [esbuild]([https://esbuild.github.io/](https://esbuild.github.io/)) [预构建依赖](https://cn.vitejs.dev/guide/dep-pre-bundling.html)。esbuild 使用 Go 编写，比JavaScript 编写的打包器 (webpack) 预构建依赖快 10-100 倍

## 源码

并非直接是js的文件,而是需要编译的,例如JSX，CSS 或者 Vue/Svelte 组件,时常需要编辑

Vite 以 [原生 ESM](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Modules)方式提供源码。

Vite 在浏览器请求源码时进行转换并按需提供源码,让浏览器接管打包的部分工作.

而**webpack 是打包完毕后,根据请求按需提供源码**

以实现根据情景动态导入代码，即只在当前屏幕上实际使用时才会被处理。

![](images/WEBRESOURCEe7a8af3a863c2dda5db6125a40a07605838a5e8ff18c3dc936a08e9c77019345.png)

![](images/WEBRESOURCE300bbe1722e34899f0a2c5353e096dbf95b061f2138caa9908a2aae552deff06.png)

热更新HMR

在 Vite 中，HMR 是在原生 ESM 上执行的。当编辑一个文件时，Vite 只需要精确地使已编辑的模块与其最近的 HMR 边界之间的链失活[[1]](https://cn.vitejs.dev/guide/why.html#footnote-1)（大多数时候只是模块本身），使得无论应用大小如何，HMR 始终能保持快速更新。

Vite 同时利用 HTTP 头来加速整个页面的重新加载（再次让浏览器为我们做更多事情）：

**源码模块**的请求会根据 `304 Not Modified` 进行**协商缓存**

**依赖模块**请求则会通过 `Cache-Control: max-age=31536000,immutable` 进行**强缓存**，因此一旦被缓存它们将不需要再次请求。