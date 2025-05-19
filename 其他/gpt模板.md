---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---
```
现在存在如下问题：
删除会导致整个画布清空

还有在画布中严格遵循以下规则：
容器组件默认占父组件宽高的100%，没有则是画布宽高的100%，如果超出则添加滚动条，
行组件宽默认占父组件的100%，高根据里面的内容自适应，
列组件高度根据里面的内容自适应，
```

## cursor 自己生成自己的提示词
```
写一个提示词供cursor在src/components/lowCodeEditorPlus中生成低代码编辑器，要求如下(注意只要提示词):
采用中文，
使用tailwind，
技术栈为pnpm,vue3，element-plus，antd/g2,echarts等
左侧为element-plus的基础组件，布局组件，直接使用element-plus组件进行展示，基于echarts和g2的图表组件，图表组件的样式用一个写好的图表展示
中间为编辑区域，要求支持磁吸对齐，组件拖进去后，与组件样式保持一致，规则是el-col只能放在el-row中，基础组件/图表组件只能放在布局组件中，
el-row宽度默认100%，el-container宽高默认100%
右侧为组件属性编辑器,
支持json schema导入导出,
提供.stories
```

```
请使用Vue 3、Element Plus、Tailwind CSS、ECharts和Ant Design/G2在src/components/lowCodeEditorPlus中开发一个完整的低代码编辑器组件，严格按照以下要求：

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

1. 中间区域：
   - 拖入的基础组件和布局组件和图表组件需保持与组件面板样式一致
   - 支持组件磁吸对齐和网格辅助线
   - 支持多组件选择和拖拽
   - 强制要求基础组件和画布组件必须放置在布局组件内部
   - el-col只能存在于el-row中
   - el-row默认占宽100%
   - 容器组件默认宽高100%

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
- 组件结构应遵循src/components/lowCodeEditorPlus/types/index.ts中定义的类型接口
```

```text
# 低代码编辑器Plus组件开发需求

我需要在src/components/lowCodeEditor目录下创建一个基于Vue3的低代码编辑器组件。该组件需要遵循以下技术规范和功能要求：

## 技术栈
- pnpm作为包管理工具
- Vue3 Composition API + TypeScript
- Tailwind CSS用于样式
- Element Plus组件库
- ECharts和AntV/G2用于图表展示
- 支持JSON Schema

## 总体布局
编辑器需要分为三个主要区域：

### 左侧组件面板
- 分类展示Element Plus的基础组件（如按钮、输入框、选择器等）
- 布局组件（如el-row、el-col、el-container等）
- 图表组件（基于ECharts和G2的可视化组件）
- 每个图表组件需要有默认的示例数据和样式展示
- 组件需要可拖拽到中间编辑区域

### 中间编辑区域
- 支持组件的拖拽放置
- 实现磁吸对齐功能，使组件能够自动对齐
- 严格的组件嵌套规则：
  * el-col组件只能放在el-row中
  * 基础组件和图表组件只能放在布局组件中
  * el-row宽度默认100%
  * el-container宽高默认100%
- 组件拖入后保持与原始组件样式一致
- 支持组件选中、移动、删除等基本操作

### 右侧属性编辑面板
- 根据选中组件显示对应的属性配置项
- 支持修改组件的常用属性、样式和事件
- 对于图表组件，提供数据配置和样式调整选项
- 实时预览属性变更效果

## 核心功能
- 组件的拖拽和放置
- 磁吸对齐功能
- 组件嵌套规则的实现和验证
- JSON Schema导入导出功能，用于保存和恢复页面配置
- 完整的Storybook演示文档（.stories文件）

## 代码规范
- 所有功能模块必须包含中文注释说明
- 每个函数必须包含错误捕获和日志记录
- 使用TypeScript类型定义确保类型安全
- 遵循Vue3组件最佳实践
- 代码结构清晰，易于维护和扩展

## 组件结构建议
1. ComponentPanel文件管理左侧面板
2. ComponentRenderer文件管理中间区域
3. ComponentPropertyPanel文件管理右侧属性编辑面板
4. types文件统一管理组件的类型
5. 使用Pinia进行状态管理
6. 实现自定义hooks处理拖拽逻辑、组件规则验证等
7. 独立的工具函数和常量定义

请根据以上需求，实现一个功能完整、交互友好的低代码编辑器组件，支持基本的页面搭建需求。
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
