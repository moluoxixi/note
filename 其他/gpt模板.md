---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---
```
图表组件仍然报错Cannot read properties of null (reading 'insertBefore')
行只能放在容器组件中，列只能放在行中
容器组件默认占父组件宽高的100%，没有则是画布宽高的100%，
行组件宽默认占父组件的100%，高根据里面的内容自适应，
列组件高度根据里面的内容自适应
```

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
```
不满足要求如下： 
1. 左侧组件列表基础组件，布局组件的显示不是element-plus组件的样子，图表组件不是图表渲染出来的样子
2. 画布中，布局组件拖进去没有白色背景，基础组件未满足只能放在布局组件中的要求，图表组件未满足只能放在容器组件中的要求
3. 我希望组件都是基于栅栏布局，而不是绝对定位
4. 图表组件拖拽进去未能实时看到效果
5. 预览按钮没有文字，且预览功能看不到效果，而且预览是有网格线的
```

```
请使用Vue 3、Element Plus、Tailwind CSS、ECharts和Ant Design/G2在src/components/lowCodeEditor2中开发一个完整的低代码编辑器组件，严格按照以下要求：

技术要求：
- 使用pnpm作为包管理工具
- Vue 3组合式API和TypeScript
- Element Plus作为基础UI组件库
- Tailwind CSS进行样式管理
- ECharts和Ant Design/G2用于图表组件

功能要求：
1. 左侧组件面板：
   - Element Plus基础组件（按钮、输入框、选择器等）
   - Element Plus布局组件（容器、栅格等）
   - 基于ECharts和G2的图表组件（柱状图、折线图、饼图等）
   - 组件支持拖拽到画布
   - 基础组件，布局组件 直接使用Element Plus原生组件作为展示
   - 图表组件使用基础图表进行展示

2. 中间画布区域：
   - 画布自身展示其实际样式，包括网格背景、边界等
   - 拖入的基础组件和布局组件和图表组件需保持与组件面板样式一致
   - 支持组件磁吸对齐和网格辅助线
   - 支持多组件选择和拖拽
   - 组件不能超出画布边界
   - 画布不可选中
   - 强制要求基础组件和画布组件必须放置在布局组件内部

3. 右侧属性编辑面板：
   - 动态显示当前选中组件的属性
   - 支持修改组件属性、样式和事件
   - 属性修改实时反映到画布
   - 为布局组件提供容器管理功能
   - 提供组件树结构视图

4. 数据处理功能：
   - 支持JSON Schema格式导入导出页面配置
   - 提供版本历史和撤销/重做功能
   - 导出时保持组件嵌套结构完整性
   - 支持预览生成的表单或页面

5. 开发文档：
   - 使用Storybook创建组件示例和文档
   - 为该低代码组件提供.stories文件
   - 展示布局组件和基础组件的嵌套使用方式
   - 提供典型场景的使用示例

请按照以上要求实现低代码编辑器，并确保代码遵循以下规范：
- 每个函数和代码块必须有中文注释说明功能
- 所有函数必须包含错误处理和日志记录
- 组件结构应遵循src/components/lowCodeEditor2/types/index.ts中定义的类型接口
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
