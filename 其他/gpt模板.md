---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---
```

仔细阅读 temp-go-view ,文档参考https://www.mtruning.club/guide/start/ 在本项目的 src/componets/lowCodeEidtor 中重新实现这个低代码编辑器, 严格按照以下要求:
1. 严格阅读代码, 列出它有哪些功能


仔细阅读 temp-go-view ,文档参考https://www.mtruning.club/guide/start/ 在本项目的 src/componets/lowCodeEidtor 中重新实现这个低代码编辑器, 严格按照以下要求:
1. 遇到路径引入，改为@/components/组件名这种格式
2. 严格阅读代码, 实现低代码功能支持如下:
	1. 组件拖拽系统
		1. 从左侧组件库拖拽组件到中间画布
		2. 组件定位与布局管理
		3. 支持多种基础组件（按钮、输入框、文本等）
	2. 可视化编辑
		1. 组件选择与高亮显示
		2. 组件属性实时配置
		3. 所见即所得的编辑体验
	3. 历史记录管理
		1. 撤销/重做操作
		2. 状态历史记录保存
		3. 操作步骤追踪
	4. 组件属性配置
		1. 位置坐标设置（X/Y坐标）
		2. 尺寸调整（宽度/高度）
		3. 组件特定属性配置
	5. 组件类型支持
		1. 基础组件（按钮、输入框、文本）
		2. 画布组件等
		3. 可扩展的组件系统
		4. 组件样式与主题定制
	6. 画布管理
		1. 空状态提示
		2. 画布尺寸控制
		3. 组件层级管理
	7. 项目管理
		1. 保存功能
		2. 预览功能
		3. 清空画布
	8. 响应式设计
		1. 基于 Tailwind CSS 的响应式界面
		2. 适配不同屏幕尺寸
		3. 现代化 UI 设计
	9. 组件样式配置
		1. 按钮：类型、尺寸、禁用状态等
		2. 输入框：标签、占位符、类型、只读/禁用状态等
		3. 文本：内容、字体大小、字重、颜色、对齐方式等
	10. 开发者友好
		1. Storybook 集成
		2. 组件化架构
		3. TypeScript 类型支持
3. 严格阅读代码, 使用 tailwind 参照 `temp-go-view/sr/components` 依次实现所有组件
4. 在 `.storybook/.stories/lowCodeEditor.stories.tsx` 中提供该组件的 `storie`
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