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

我需要在src/components/lowCodeEditor目录下创建一个基于Vue3的低代码编辑器组件。

## 核心依赖库
- Vue3 + TypeScript
- Tailwind CSS
- Element Plus
- VueDraggable (基于SortableJS)
- vue-grid-layout
- Pinia
- ECharts/AntV G2

## 总体布局
编辑器分为三个区域：左侧组件面板、中间编辑区域、右侧属性编辑面板。

## 左侧组件面板
- 使用Element Plus组件展示可拖拽组件
- 分为基础组件、布局组件、图表组件三类
- 组件仅作展示用途，禁止点击交互，只能拖拽
- 使用VueDraggable实现拖拽功能

## 中间编辑区域
- 使用vue-grid-layout实现网格布局和磁吸对齐
- 组件禁止原生交互，仅可选中、移动、删除
- 组件嵌套规则：
  * 基础组件和图表组件只能放在布局组件中
  * el-col只能放在el-row中
  * 只有el-container和el-row可直接放入编辑区
- 支持组件多选、复制/粘贴、层级调整
- 实现撤销/重做功能

## 右侧属性编辑面板
- 根据选中组件显示对应属性
- 修改属性实时更新组件
- 分类展示基础属性、样式属性、高级属性

## 状态管理
- 使用Pinia创建三个store:
  * componentsStore: 管理组件实例和层级
  * editorStore: 管理编辑器状态
  * historyStore: 管理操作历史

## 核心功能实现
1. 组件拖拽: 使用VueDraggable实现从左侧到中间区域的拖拽
2. 网格布局: 使用vue-grid-layout实现组件定位和磁吸
3. 组件选择: 点击选中组件，显示操作手柄
4. 属性编辑: 右侧面板更新选中组件属性
5. 导入导出: 使用JSON Schema保存和恢复配置

## 项目结构

src/components/lowCodeEditor/
├── ComponentPanel/         # 左侧组件面板
├── ComponentRenderer/      # 中间编辑区域
├── ComponentPropertyPanel/ # 右侧属性编辑面板
├── types/                  # 类型定义
├── constants/              # 常量定义
├── hooks/                  # 自定义hooks
├── utils/                  # 工具函数
└── store/                  # Pinia状态管理

## 组件交互限制
- 所有组件仅供展示，禁止触发原生交互
- 禁用组件的原生点击、输入、选择等功能
- 仅通过右侧属性面板修改组件配置

## 代码规范
- 添加中文注释
- 包含错误处理
- 使用TypeScript类型定义
- 遵循Vue3最佳实践

## Storybook Stories要求
为每个主要组件创建.stories.ts文件
展示以下典型场景:
基础空白编辑器
预填充了示例组件的编辑器
演示各类组件拖拽的交互示例
展示属性编辑效果的示例
不同布局组件的嵌套示例
图表组件配置示例
每个Story提供必要的文档说明用途和用法
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
