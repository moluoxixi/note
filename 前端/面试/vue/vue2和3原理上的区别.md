---
title: vue2和3原理上的区别
description: 一个vue2和3原理上的区别笔记
date: 2025-03-05
hidden: false
tags:
  - vue2和3原理上的区别
ptags:
  - vue
---

## 2/3 原理上的区别

1. 源码用 ts 重写
2. 响应性系统优化：Vue 2 使用了 Object. defineProperty 来实现响应式系统，Vue
   3 在 reactive 和 ref 接受复杂类型时使用了 Proxy 来实现, 仅在 ref 接受基本类型时使用 defineProperty 代理。
	1. defineProperty 在对象新增和删除属性时, 数组新增, 删除, 修改属性以及通过 length 改变长度时不具有响应式
	2. proxy 支持更多数据类型的劫持, 除 Object 和 Array 外, 还支持 Map, Set, WeakSet, WeakMap
3. proxy 劫持数组本身, vue2 只能通过数组方法实现对数组的监控
4. 树摇：依赖 es module 的 import 和 export, 通过分析引用关系摇掉冗余代码
5. diff 优化:
	- Vue 3 在将模板转换为 AST 树时将动态改变节点结构的部分 (例如 vif, vfor) 放在一个数组中, 节点改变时从数组中取值, 避免每次动态改变节点重新生成虚拟 DOM 递归比较
	- 模板解析 compile, parse 将 template 解析为 AST 树, optimize 阶段遍历 AST 树找到静态节点打上标记, generate 阶段根据 AST 树生成 Render 函数，同时将静态节点提升到 render 函数外作为常量
	- 生成后遍历 AST 树寻找静态节点并打上静态标识, 在生成高性能渲染函数时将静态节点提取到渲染函数之外，避免每次渲染时重新创建