---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---
## cursor 自己生成自己的提示词
```
写一个提示词供cursor在src/components/lowCodeEditorPlus中生成低代码编辑器，
采用中文，
使用tailwind，
技术栈为pnpm,vue3，element-plus，antd/g2,echarts等
左侧为element-plus的基础组件，布局组件，基础组件和布局组件的样式也用element-plus的，基于echarts和g2的图表组件，图表组件的样式用一个写好的图表展示
中间为画布，要求支持磁吸对齐，组件拖进去后，与组件样式保持一致，支持拖拽多个组件，组件不能超出画布，画布不可选中，画布可以展示网格
右侧为组件属性编辑器,
支持json schema导入导出,
提供.stories
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
