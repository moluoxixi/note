---
title: webpack
description: webpack笔记
date: 2025-01-28
tags:
  - 前端
---
## 命令解析

我们分析如上命令:

1. ``cross-env``：``cross-env``是一个工具，允许您以跨平台的方式设置环境变量。在这种情况下，它将``NODE_ENV``环境变量设置为"development"。
2. ``NODE_ENV=development``：这将环境变量``NODE_ENV``设置为"development"。将``NODE_ENV``设置为"development"是Web开发中的常见做法，表示应用程序正在开发环境中运行。这可以影响应用程序中使用的各种工具和库的行为。
3. ``webpack-dev-server``：这是Webpack的开发服务器。它提供Webpack捆绑文件，并通常在开发过程中使用，以提供热重载和其他开发功能。
4. ``--config src/common/config/webpack.config.dev.js``：此标志指定Webpack用于开发构建的配置文件。在这种情况下，它指向``src/common/config``目录中的``webpack.config.dev.js``文件。该文件可能包含用于开发构建的配置设置。
5. ``--progress``：此标志表示应在控制台中显示构建进度。它提供有关构建过程的反馈。
6. ``--watch``：此标志指示Webpack监视源代码的更改，并在检测到更改时自动重新编译。这是开发服务器的常见做法，以监视代码更改并在需要时触发重新构建。
7. ``--colors``：此标志启用控制台中的带颜色输出。它通过使用颜色来区分输出的不同部分，有助于使构建日志更易阅读。
8. ``--profile``：此标志告诉Webpack生成并显示构建配置文件。构建配置文件可以帮助您了解构建过程中花费时间的地方，这对优化构建时间很有用。

# 自定义插件

# webpack介绍

## webpack运行过程

告诉webpack打包的起点 ===>入口文件

分析依赖关系图,根据顺序依次将资源引入形成代码块(chunk)

将代码块进行各项处理,比如将less解析成css ===>这一过程称为打包

将处理好的东西输出,输出的东西称为 bundle ==>打包生成静态资源

## 常用配置项

## webpack五个核心概念

|   |   |   |
|---|---|---|
|五个核心概念|叫法|作用|
|Entry|入口|打包时，第一个被访问的源码文件，指示 webpack 应该使用哪个模块（webpack中一切都是模块），来作为构建其内部依赖图的开始。 webpack可以通过入口,加载整个项目的依赖,默认是src/index.js|
|output|出口|打包后输出到哪个文件夹中,默认是dist/main.js|
|loader|加载器|将非js资源处理成webpack能识别的资源(js资源),****loader执行是自下而上的****,命名方式:xxx-loader|
|plugin|插件|执行更加强大的功能,比如压缩等|
|module|模式|指示webpack使用本地运行调试的环境(development)还是代码优化上线运行的环境(production)|

## 什么是构建工具

如果想解析ts,less等,需要一个个小的工具,非常麻烦,于是前端提出了一种概念,把这些小的工具集成成一种大的工具,称之为构建工具,

webpack是一种构建工具,(静态模块打包器)

# 错误

unable to locate

路径错误

# webpack使用流程

## 初始化 package.json

输入指令:

npm init

输入webpack包名,然后疯狂回车

## 下载并安装 webpack 和Jquery

输入指令:

## 本地安装的webpack-cli注意

## 1.新建各种文件

### 新建``src``和``build``文件夹

- src ==> 项目的源代码目录
- build ==>通过webpack打包处理后输出的目录

### 在src下新建index.js

- index.js ==>入口起点文件

## 2.运行打包指令

### 开发环境指令：

#### 代码解析:

webpack会以 src/js/index.js为入口文件开始打包,打包后会build/js目录下新建main.js,并将打包后的内容输出到main.js文件中

--mode指定整体打包环境为开发环境

#### 功能：

webpack 能够编译打包 js 和 json 文件，并且能将 es6 的模块化语法转换成浏览器能识别的语法。

### 生产环境指令：

#### 代码解析:

webpack会以 src/js/index.js为入口文件开始打包,打包后会build/js目录下新建main.js,并将打包后的内容输出到main.js文件中

--mode指定整体打包环境为生产环境

#### 功能：

在开发配置功能上多一个功能，压缩代码。

### 终端输出结果需注意项:

hash: 打包后输出的结果,每次打包时都会生成一个唯一的hash值

### 结论

webpack 能够编译打包 js 和 json 文件。

能将 es6 的模块化语法转换成浏览器能识别的语法。

能压缩代码。

### 问题

不能编译打包 css、img 等文件。

不能将 js 的 es6 基本语法转化为 es5 以下语法。

## 3.创建配置文件

### 创建webpack配置文件

作用:指示webpack应该干什么

### 配置内容如下

### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

### 结论: 此时功能与上节一致

## 4.打包css

### 将css打包成js

#### 1.将需要打包的样式文件引入到入口文件中(index.js)

#### 2.下载安装 loader 包

#### 3.在webpack配置文件中的loader配置模块中进行配置

#### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 将css打包成独立的文件

#### 1.下载安装 plugin 包

#### 2.在webpack.config.js配置文件中引入mini-css-extract-plugins模块

#### 3.在webpack配置文件中的plugins配置模块中进行配置

#### 4.在webpack配置文件中的loader配置模块中进行配置

#### 5.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 5.打包HTML资源

### 1.下载安装 plugin 包

### 2.在webpack配置文件中引入html-webpack-plugins模块

### 3.在webpack配置文件中的plugins配置模块中进行配置

### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包图片资源

### 打包以模块方式引入的图片

import dog from './image/01.jpg'

#### 1.在webpack配置文件中的loader配置模块中进行配置

#### 2.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 打包html中引入的图片

#### 1.在webpack配置文件中的loader配置模块中进行配置

#### 2.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 打包css中引入的图片

#### 1.下载安装 plugin 包

#### 2.在webpack.config.js配置文件中引入mini-css-extract-plugins模块

#### 3.在webpack配置文件中的loader配置模块中进行配置

#### 2.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包字体文件

### 1.在webpack配置文件中的loader配置模块中进行配置

### 2.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包公共资源

### 下载安装 plugin 包

作用就是将某文件或某文件夹下的文件复制到指定目录下

### 在webpack配置文件中的plugins配置模块中进行配置

### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 每次打包前删除之前的打包文件

### 下载安装 plugin 包

### 引入

### 在webpack配置文件中的plugins配置模块中进行配置

### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 7.打包除css|js|html|less之外的资源

### 1.下载安装 plugin 包

### 2.在webpack配置文件中引入path模块和html-webpack-plugin模块

### 3.在webpack配置文件中的loader配置模块中进行配置

### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包ejs

### 下载loader包

### 在webpack配置文件的loader模块中配置

## js 语法检查

### 1.下载安装包

- eslint 检验js代码格式的工具
- eslint-config-airbnb-base：最流行的js代码格式规范
- eslint-webpack-plugin：webpack中使用eslint
- eslint-plugin-import：用于在package.json中读取eslintConfig的配置

### 2.webpack配置文件中引入

### 2.在webpack配置文件中的plugins模块中进行配置

### 3.配置 package.json

### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## js 兼容性处理

### 1.下载安装包

### 2.在webpack配置文件的loader模块中配置

- @babel/preset-env只能转义基本语法（promise不能转换）
- @babel/polyfill（转换所有js语法）

- ``npm i @babel/polyfill -D``
- ``import '@babel/polyfill'``(入口文件中引入)

### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## webpack额外配置

### 配置默认识别的后缀和路径别名

#### 在webpack配置文件中添加新的配置模块

### 自动编译

#### 安装

#### 在webpack配置文件中添加新的配置模块

#### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 压缩css

#### 安装

#### 引入

#### 在webpack中添加新的配置模块

#### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 配置入口和资源的最大文件大小,忽略性能提示

### 配置代理服务器

****服务器向服务器发送请求不受同源策略限制****

****代理服务器代替用户访问目标服务器****

在webpack或各种脚手架中配置代理