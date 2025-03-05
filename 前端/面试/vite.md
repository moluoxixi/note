---
title: vite
description: 一个vite笔记
date: 2025-03-05
hidden: false
tags: vite
ptags: 
---
# vite

vite 是基于 es module (script type:module&import) 实现的，当我们访问 index. html 的时候，浏览器会引入 index. html 引入的相关模块及其依赖模块并进行下载操作

vite 将代码分为源码和依赖两块, 依赖是指 node module 中的第三方包 (不会变), 源码是指开发的代码 (时刻会变)

在启服务的时候,仅执行预构建,仅包锁 (例如 package. lock), vue. config. js，node_env 变化时会重新预构建

- 先扫描项目引入的依赖，

- 再将 node_modules 下非 esmodule 的处理为 esmodule，

- 最后将他们进行打包变成一个 esmodule 模块

服务起了后, vite 会基于 connect 起了一个开发服务并监听请求，并通过中间件处理这些请求 (项目跑的时候可以看到那些中间件)
，将源码文件进行编译。