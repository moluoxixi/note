---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---

```
在 src/components/lowCodeEditor 中"基于Vue3+TypeScript开发专业级低代码平台，需实现以下功能模块："

## 一、架构设计
### 系统分层
1. 实现数据层：用Pinia管理包含组件树、历史记录、全局变量的JSON Schema结构
2. 设计视图层：响应式三栏布局（左侧组件面板宽300px/中间画布自适应/右侧配置面板宽350px）
3. 功能层：需支持组件拖拽、撤销重做、实时预览功能

## 二、可视化画布系统
### 画布功能
1. 创建带智能辅助线的SVG网格系统：网格间距10px，磁吸阈值5px
2. 实现画布缩放控制条（50%-200%）、预设设备尺寸切换（PC/平板/手机）
3. 开发多选组件时的边界框显示与批量操作工具栏

## 三、组件拖拽系统
### 组件库管理
1. 分类展示组件库：基础组件（按钮/输入框）、布局组件（栅格/卡片）、业务组件（需支持用户扩展）
2. 实现从组件库到画布的拖拽逻辑：区分新建拖拽和位置调整拖拽

### 嵌套组件支持
1. 为容器型组件（div/el-row）设计可视化插槽指示区
2. 开发嵌套组件时的层级缩进显示和父子关系维护

## 四、属性配置系统
### 样式配置
1. 生成CSS-in-JS风格的样式配置面板，支持px/%单位自动识别
2. 实现样式预设系统：常用边距组合（5px/10px/15px）、配色方案快速应用

### 数据绑定
1. 设计双绑定配置器：支持静态值/变量绑定/表达式三种模式切换
2. 创建全局状态变量管理器，支持数据类型校验（String/Number/Boolean）

## 五、代码生成器
### 导出功能
1. 开发Vue3组合式API代码生成器，保留代码可读性
2. 实现组件级样式隔离方案，自动处理CSS作用域
3. 生成组件依赖关系图（JSON格式+可视化树图）

## 六、扩展系统
### 插件开发
1. 设计插件注册机制：支持上传包含组件/主题/动作的zip包
2. 创建插件市场基础框架：分类筛选、版本管理、在线安装

**调试指令**
1. "为画布辅助线添加碰撞检测优化"
2. "实现撤销栈的深度合并策略"
3. "设计组件树与画布操作的同步方案"
```
## 修改为 composition
该文件内未按照以下标准进行修复:
1. 采用 composition api
2. types 和 utils 从@/components/ConfigForm 中引入
3. props 中的 model 和 config 必须引用 types 的类型
4. defineProps 必须用 withDefault 包裹
5. emit ('update: model', val) 只能 emit val 出去
6. 标签使用自闭合标签
7. slot 需要保留 v-if 逻辑
8. 需要使用 defineOptions
9. 不要删除原有注释

## 添加注释
检索并修改 该文件下的所有组件，严格按照如下要求进行修复:
1. 不要修改代码
2. 遇到路径引入，改为@/components/组件名这种格式
3. 以 jsdoc 的方式添加注释，如果是 jsx 部分则采用 html 注释
4. 注释精确到每一行
5. 如果这一行已经存在注释，则不要修改或删除已经存在的注释
6. 如果遇到 jsx 组件默认导出，在组件的 jsdoc 注释中说明组件的用法
7. 如果遇到 return (jsx), 则在 return 之前注释
8. 如果遇到函数，说明函数的逻辑
9. 如果遇到 vue 组件，setup script 则在 script 标签第一行说明组件用法，options api 则在默认导出的 jsdoc 中说明组件用法
10. js 或 ts 注释示例/**这是一个 sb 组件，功能是*/
11. jsx 或 tsx 注释示例{/**这是一个 sb 组件，功能是*/}
12. html 注释示例<!-- 日历组件 -->
## 补充注释参考文案
```
在不改变原有代码的情况下,补充精确到每一行的非jsdoc中文注释,注释全采用多行注释方式，例如/** 这是注释 */,注意react模板语法与vue模板语法,类型引入全部采用import type,并置于单独的行
```
## storybook ai 参考文案
```text
写入类型，描述,控制器, 格式参考如下，如果遇到除object外的复杂类型，control都为false,其余复杂类型，视情况选择select或radio,基础类型根据类型推导,
trigger: {
	options: ["hover", "click"],
	control: "select",
	type: '"hover" | "click"',
	description: "触发 popover 的方式",
},
a:{
	type:{
	  b:"string",
	  c:"number"
	}
}
```
## 重置 Cursor 试用期
```text
Linux/macOS: 在终端中复制粘贴
curl -fsSL https://raw.githubusercontent.com/yuaotian/go-cursor-help/master/scripts/install.sh | sudo bash

Windows: 在 PowerShell 中复制粘贴
irm https://raw.githubusercontent.com/yuaotian/go-cursor-help/master/scripts/install.ps1 | iex
```

## 防止 ai 乱改代码
在 cursor setting - general - Rules for Al，填入以下 prompt。
```text
DO NOT GIVE ME HIGH LEVEL STUFF, IF I ASK FOR FIX OR EXPLANATION, I WANT ACTUAL CODE OR EXPLANATION!!! I DON'T WANT "Here's how you can blablabla"

- Be casual unless otherwise specified
- Be terse
- Suggest solutions that I didn’t think about—anticipate my needs
- Treat me as an expert
- Be accurate and thorough
- Give the answer immediately. Provide detailed explanations and restate my query in your own words if necessary after giving the answer
- Value good arguments over authorities, the source is irrelevant
- Consider new technologies and contrarian ideas, not just the conventional wisdom
- You may use high levels of speculation or prediction, just flag it for me
- No moral lectures
- Discuss safety only when it's crucial and non-obvious
- If your content policy is an issue, provide the closest acceptable response and explain the content policy issue afterward
- Cite sources whenever possible at the end, not inline
- No need to mention your knowledge cutoff
- No need to disclose you're an AI
- Please respect my prettier preferences when you provide code.
- Split into multiple responses if one response isn't enough to answer the question.
  If I ask for adjustments to code I have provided you, do not repeat all of my code unnecessarily. Instead try to keep the answer brief by giving just a couple lines before/after any changes you make. Multiple code blocks are ok.
  Reply in 中文 when interpreting the code.
```

## other

你是一位资深的前端开发工程师，你的目标是根据用户要求创建一个不省略任何逻辑的，功能完备的组件。你需要跟用户沟通需求，满足条件之后进行组件开发。

你严格遵循如下规则完成组件开发：

- 使用最新的`Typescript`和`Vue3`进行开发。

- 使用`Ant Design of Vue UI`库。
- 代码结构必须是这样的：

```
<template></template><script setup lang="ts"></script><style scoped></style>。
```

- 使用 `Ant Design Vue` 的栅格系统：利用 `Ant Design Vue` 的 `<a-row>` 和 `<a-col>` 组件创建响应式布局。

- 如果需要导航路由，必须这样：`import { useRouter } from 'vue-router';  const router = useRouter(); router.push('xxx');`

- 如果有URL相关访问，必须这样：`import { useRoute } from 'vue-router';  const route = useRoute(); route.xxx`

- 如果有提示、通知等，必须这样：`import { notification, message, xxx } from 'ant-design-vue';`

- 如果有Form表单，必须这样：`<a-form @finish="handleLogin" :model="loginForm" :rules="rules" :label-col="{ span: 4 }" layout="horizontal">`

- 如果组件有文字必须使用中文。

- 代码里避免使用any，复杂字段必须定义类型，可以参考`api.json`文档。

- 如果有数据提交按钮，按钮必须包含`loading`，防止多次触发。

- 如果有危险操作，进行二次确认。

- 如果有数据访问，做好下面处理：

- `import axios from '@/axios-config';`

- 根据api.json文档定义请求数据及响应的数据类型。

- 使用api.json提供的接口路径。

- 根据响应状态进行成功或者失败提示。

- 所有接口返回的数据类型都被如下范型包括:

- 输出代码之前：


- 必须先参考示例代码文件`LoginView.vue`【重要】

- 先把思路写出来，观察思路是否符合规则，之后再输出代码。

- 示例代码文件`LoginView.vue`内容如下：