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
## 准备下个月有次数的时候运行
### 低代码
```text

# 低代码编辑器Plus组件开发需求

我需要在src/components/lowCodeEditor目录下创建一个基于Vue3的低代码编辑器组件。该组件需要遵循以下技术规范和功能要求：

## 技术栈
- Vue3 Composition API + TypeScript
- Tailwind CSS用于样式
- Element Plus组件库
- ECharts和AntV/G2用于图表展示
- 支持JSON Schema

## 关键交互模式
- 左侧组件面板：所有组件（Element Plus组件和图表组件）仅作为静态展示，禁止任何点击交互，仅支持拖拽操作
- 中间编辑区域：组件同样禁止直接交互，不能点击、输入或触发其原生行为，仅支持通过选择后在右侧编辑面板修改属性

## 总体布局
编辑器分为三个主要区域：

### 左侧组件面板
- 分类展示Element Plus的基础组件（按钮、输入框、选择器等）
- 布局组件（el-row、el-col、el-container等）
- 图表组件（基于ECharts和G2的可视化组件）
- 基础组件和布局组件必须保持Element Plus原生外观和样式，但仅作为视觉展示
- 图表组件显示带有实际数据的完整图表效果
- 所有组件禁用原生交互功能，只能拖拽
- 每个图表组件需要有默认的示例数据和样式展示
- 支持组件搜索功能

### 中间编辑区域
- 拖入的组件必须保持与左侧面板完全相同的外观和样式
- 编辑区域内的组件禁用所有原生交互行为（如按钮点击、输入框输入等）
- 组件只能通过选中后在右侧属性面板修改
- 实现磁吸对齐功能，使组件能够自动对齐
- 添加选中状态的视觉标识（如边框、操作handles）
- 严格的组件嵌套规则：
  * 基础组件和图表组件只能放在布局组件中
  * el-col组件只能放在el-row中
  * el-row宽度默认100%
  * el-container宽高默认100%
  * 仅布局组件el-container和el-row可直接拖入编辑区域，其余组件需满足嵌套规则才可拖入
- 支持组件选中、移动、删除等基本操作
- 实现组件多选和批量操作功能
- 提供组件复制/粘贴功能
- 支持组件层级调整（上移/下移/置顶/置底）
- 实现简单的撤销/重做功能

### 右侧属性编辑面板
- 根据选中组件显示对应的属性配置项
- 支持修改组件的常用属性、样式和事件
- 对于图表组件，提供数据配置和样式调整选项
- 实时预览属性变更效果
- 分类展示不同类型的属性（基础属性、样式属性、高级属性等）

## 组件渲染与数据流
- 为每个Element Plus组件创建对应的配置模型，包含：组件类型、默认属性、允许编辑的属性列表
- 实现渲染适配层，将抽象组件模型转换为实际渲染的Vue组件
- 所有组件应使用ref包装，以便在不影响视觉展示的情况下控制其属性

## 状态管理
- 使用Pinia实现以下Store：
  * componentsStore：管理所有组件实例及其层级关系
  * editorStore：管理编辑器状态（选中组件、拖拽状态等）
  * historyStore：管理操作历史记录（撤销/重做）

## 拖拽实现细节
- 采用 **VueDraggable**（基于SortableJS）作为主要拖拽实现库
- 使用 **vue-grid-layout** 实现网格对齐和磁吸功能
- 对于复杂交互场景，可结合 **Interact.js** 实现更精细的拖拽控制
- 对于组件变换（缩放、旋转等），推荐使用 **moveable** 库
- 在拖拽过程中显示可放置区域的视觉提示（有效/无效区域）
- 拖拽时显示组件轮廓作为预览
- 实现智能辅助线功能，帮助用户对齐组件

## 核心功能
- 组件的拖拽和放置
- 磁吸对齐功能
- 组件嵌套规则的实现和验证
- JSON Schema导入导出功能，用于保存和恢复页面配置
- 页面预览功能
- 支持导出为Vue单文件组件代码（可选功能）

## 代码规范
- 所有功能模块必须包含中文注释说明
- 每个函数必须包含错误捕获和日志记录
- 使用TypeScript类型定义确保类型安全
- 遵循Vue3组件最佳实践
- 代码结构清晰，易于维护和扩展

## 组件结构建议
1. ComponentPanel文件夹管理左侧面板
2. ComponentRenderer文件夹管理中间区域
3. ComponentPropertyPanel文件夹管理右侧属性编辑面板
4. types文件夹统一管理组件的类型
5. 使用Pinia进行状态管理
6. 实现自定义hooks处理拖拽逻辑、组件规则验证等
7. 独立的工具函数和常量定义
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
