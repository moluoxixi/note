---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---

# 实用

```
的参数，参数描述，类型与类型注释
```

```
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
LURLodECTqzkxN1fevjx
生成一张高清印度人学生证件照
4 布局组件  间距   待定
1. 上传组件
2. 配置化表单
3. 剩余需要收集需求

```

跳舞
```
A captivating woman in elegant attire dances gracefully under dynamic spotlights, with a blurred, energetic crowd in the background.
```
## 虚拟模块
```
使用E:\project\companyProject\trasen\vue-component\packages\utils\ViteConfig\src\plugins\utils\virtual.ts抛出的工厂函数，在E:\project\companyProject\trasen\vue-component\packages\utils\ViteConfig\src\plugins\importComponentsOrUtils.ts中实现如虚拟模块插件，要求如下：  
虚拟模块id默认为virtual:
```


```
## 函数或方法规范：
1. 统一采用 jsDoc 进行参数注释，要求描述到每一个参数
2. 多参数，采用 options 对象作为入参，在函数体首行进行解构，
3. 所有函数入参都应该有默认值，如果是函数体内对参数解构，可忽略解构默认值
4. 每个参数的类型都应该在当前文件所处目录的_types 目录下有精准的定义
5. 方法与类型的命名应该与接口强关联，例如/suno/cover/generate，方法名就应该是 sunoCoverGenerate，它的入参类型就应该是 sunoCoverGenerateParamsType
```
## AI 提示词

```
进行优化/处理，要求如下：  
1.用```text markdown内容```输出markdown，标题采用 ## 标题，方便带格式的复制  
2.只能采用有序列表，不允许无须列表  
3.要求围绕 角色，技能，回复示例，限制 四块内容
```
## 文档
```
仔细阅读packages/components中的DraggableTable源码，特别是props,slots,defineExpose,defineEmit，去更新docs/examples中对应组件的示例，和docs/components/基础组件中对应的文档，参考docs/examples/DateRangePicker中示例，  
1. 添加非常多的单个示例，直到能表达出每一个props的作用
2. 示例中不要用单行语句，包含样式和js
3. 不要使用alert
4. 函数采用function
5. 同一类型的示例应该放在同一文件夹中，参考docs/examples/DateRangePicker/type文件夹  
6. 描述应该放在docs/components/基础组件对应的md中，不要放在docs/examples/Tree中  
7. 每个:::demo块应该有单独的描述而不是整体描述  
8. examples中不应该有tailwind样式，仅采用原生css
9. 组件无须引入，已经被全局注册了
10. 表格中的代码描述需要使用``包裹
11. 遇到|字符需要转义
12. 类型声明过长时需要用^[属于什么类型，例如Function]`具体的类型`
13. 删除无用文件
```

```
参照E:\project\companyProject\trasen\vue-component\docs\vitepress\components中的组件与工具包的.md说明文件，更新/新增各组件与工具包的README.md，
统一添加基础示例，工具包提供api，组件添加props,events,Slots、Expose，
已经存在的README也需要更新的一致
```
## 虚拟卡
```
5293664168902060
有效期mmyy：06/2028
安全码(CVC):   532
姓名(Name): Nelson Ryan
国家（country）:United States（美国）
街道  2435 Polk St, Eugene
城市  Eugene
州  OR
邮编  97405
```
## APIKeys
```
AIzaSyA68GtGH8azUgqFMtNfyZYpgfks4NJi-cc

AIzaSyAfo7sRUNcu7mfOkZiHoGYQJzv-g-ja-d8
```

## el-table 转 vxe-grid
```text
根据注释生成vxe-grid的columns,没有field的需要补上field但是要写注释/**补充field*/区分
```
## 修改为 composition
该文件内未按照以下标准进行修复:
1. 采用 composition api
2. types 和 utils 从@/components/Editor 中引入
3. props 中的 model 和 config 必须引用 types 的类型
4. defineProps 必须用 withDefault 包裹
5. emit ('update: model', val) 只能 emit val 出去
6. 标签使用自闭合标签
7. slot 需要保留 v-if 逻辑
8. 需要使用 defineOptions
9. 不要删除原有注释

## 添加注释
检索并修改该文件下的所有组件，严格按照如下要求进行修复:
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
```
基于该文件内容，重写.storiebook/.stories/DraggableTable.stories.tsx
```


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
# other
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
- mitt/tiny-emitter (轻量级事件总线)
- html2canvas/dom-to-image (页面截图导出)

```text
请严格按照以下要求在src/components/lowCodeEditor中实现一个接近市面上流行的低代码编辑器：

# 低代码编辑器Plus组件开发完整需求：

## 核心依赖库
- Vue3 + TypeScript
- Tailwind CSS
- Element Plus
- VueDraggable (基于SortableJS)
- vue-grid-layout
- Pinia
- ECharts/AntV G2
- Monaco Editor (代码编辑能力)
- JSONSchema (组件属性定义和验证)
- file-saver (配置导出保存)
- lodash-es (数据处理工具函数)
- nanoid (生成唯一组件ID)
- moment (轻量级日期处理)
- hotkeys-js (快捷键支持)
- vue-ruler-tool (画布标尺功能)
- transform-js (视口管理与缩放)

## 总体架构
编辑器分为三个区域：左侧组件面板、中间编辑区域、右侧属性编辑面板。采用SchemaJSON驱动的渲染引擎设计，支持组件的拖拽、配置、预览和导出功能。

## 左侧组件面板
- 使用el-Editor进行组件类型切换，默认展示"全部"
- 分类标签包括：全部、基础组件、布局组件、容器组件、图表组件
- 顶部提供搜索输入框，支持按组件名称搜索
- 基础组件直接使用element-plus组件进行展示（实际组件）
- 图表组件使用图片进行展示（预览图）
- 布局容器组件参考市面上主流低代码平台的展示方式
- 每个组件显示图标和名称，hover时有醒目提示
- 组件仅作展示用途，禁止点击交互，只能拖拽
- 使用VueDraggable实现拖拽功能
- 支持组件分组和自定义组合

## 中间编辑区域
- 使用vue-grid-layout实现网格布局和磁吸对齐
- 拖拽交互体验：
  * 拖动组件至编辑区时，显示带阴影的虚线框，实时指示组件将被放置的确切位置和尺寸
  * 虚线框应与网格对齐，清晰展示组件将占据的网格单元数
  * 显示组件的实际尺寸、位置和样式预览，让用户在放置前了解效果
  * 靠近其他组件时出现磁吸辅助线，帮助精确对齐
  * 拖入嵌套容器时，容器边缘高亮显示，指示有效的放置区域
- 组件位置指示：
  * 放置组件时显示坐标位置信息（如x, y坐标和宽高）
  * 提供网格线作为参考，帮助精确定位
  * 拖动时显示距离临近组件的间距值
- 实时预览与渲染：
  * 组件放置后立即显示与最终效果一致的外观和样式
  * 基础组件直接渲染为实际Element Plus组件
  * 图表组件使用真实数据渲染可交互图表
- 组件嵌套规则：
  * 基础组件和图表组件只能放在布局组件中
  * el-col只能放在el-row中
  * el-container默认宽高100%，需在属性面板中可配置
  * 嵌套容器边缘显示明显的视觉提示，指示可放置区域
- 辅助功能：
  * 网格线和参考线辅助对齐
  * 组件间距离自动计算和显示
  * 高亮显示当前拖拽组件的有效放置区域
- 支持组件多选、复制/粘贴、层级调整
- 实现撤销/重做功能
- 画布增强功能：
  * 标尺功能，显示水平和垂直标尺
  * 缩放控制，支持画布放大缩小
  * 可视区域管理，支持大画布导航
  * 快捷键支持，提高操作效率
  * 组件锁定功能，防止误操作
  * 组件对齐工具栏，实现快速对齐
  * 画布网格显示控制

## 右侧属性编辑面板
- 根据选中组件显示对应属性
- 修改属性实时更新组件预览效果
- 分类展示基础属性、样式属性、高级属性
- 对图表组件提供数据源配置和样式主题设置
- 常用设置放在顶部，提供快速访问
- 样式编辑支持可视化操作，如颜色选择器、滑块控制等
- 提供组件样式预设模板，一键应用
- 高级配置功能：
  * 表达式编辑器，支持属性间联动
  * 事件配置器，可视化配置组件交互事件
  * 变量绑定面板，管理和绑定数据变量
  * 条件渲染配置，设置组件显示条件
  * CSS样式编辑器，支持自定义CSS
  * 动画效果配置，添加过渡和动画

## 状态管理
- 使用Pinia创建五个store:
  * componentsStore: 管理组件实例和层级
  * editorStore: 管理编辑器状态
  * historyStore: 管理操作历史
  * dataStore: 管理数据模型和变量
  * settingsStore: 管理编辑器全局设置
- 支持状态持久化，保存编辑进度
- 实现撤销重做队列，支持操作回溯
- 支持编辑器快照功能，保存关键节点

## 核心功能实现
1. 高精度组件拖拽与放置反馈:
   - 拖动过程中显示半透明组件实际预览效果
   - 同时显示精确的位置指示器和虚线边框
   - 实时显示组件在画布中的确切位置和尺寸
   - 放置前预览组件在当前位置的实际渲染效果
   - 无效放置区域时显示禁止标识
   - 放置完成时有明显视觉反馈和平滑过渡动画
   - 拖拽阻力和吸附设置，优化拖拽体验
   - 支持组件旋转和缩放操作

2. 精确的位置对齐系统:
   - 自动显示组件间距离和对齐参考线
   - 组件拖拽时出现智能磁吸效果
   - 提供网格对齐和自由对齐两种模式
   - 支持相对位置和绝对位置放置
   - 智能对齐算法，识别组件边缘和中心线
   - 对齐吸附力度可配置

3. 实时高保真预览:
   - 组件放置后立即显示与最终效果一致的外观和样式
   - 基础组件显示与最终效果一致的样式和内容
   - 图表组件使用示例数据渲染实际可交互图表
   - 支持设备模拟器预览，如手机、平板等
   - 支持预览模式切换，查看实际交互效果

4. 智能布局系统:
   - 自动调整组件位置避免重叠
   - 支持组件自适应和固定尺寸两种模式
   - 布局组件能智能识别子组件并优化排列
   - 支持响应式布局配置，适应不同屏幕尺寸
   - 布局组件间距自动调整

5. 属性编辑系统:
   - 右侧面板更新选中组件属性，实时反映到预览
   - 属性表单根据JSONSchema动态生成
   - 支持属性联动和条件显示
   - 表达式编辑器支持简单逻辑配置
   - 样式编辑支持主题继承和覆盖

6. 数据管理系统:
   - 可视化数据模型设计器
   - 支持静态数据和API数据源
   - 内置Mock数据生成器
   - 数据绑定可视化配置
   - 支持数据转换和过滤设置

7. 逻辑编排:
   - 无代码事件配置系统
   - 条件逻辑可视化配置
   - 简单动作流程编排
   - 页面状态管理与切换

8. 导入导出系统:
   - 使用JSON Schema保存和恢复配置
   - 支持导出为独立应用代码

## 交互细节
- 布局组件拖入后显示带虚线边框的容器，清晰标识可放置区域
- 拖动时实时显示组件在画布中的确切位置、尺寸和样式
- 基础组件和图表组件拖入后立即显示真实渲染效果
- 组件选中状态有明显视觉标识（高亮边框、操作锚点等）
- 拖拽过程有明确视觉引导，包括组件预览、放置区域指示等
- 组件拖拽时显示辅助线和距离标识，帮助精确对齐
- 组件属性修改后无延迟地更新预览效果
- 多选操作提供批量编辑功能
- 组件操作有轻微动效反馈
- 画布移动和缩放有平滑过渡效果

## 项目结构
src/components/lowCodeEditor/
├── ComponentPanel/             # 左侧组件面板
│   ├── ComponentCategory/      # 组件分类
│   ├── ComponentSearch/        # 组件搜索
│   ├── DraggableComponent/     # 可拖拽组件
│   └── ComponentPreview/       # 组件预览
├── EditorCanvas/               # 中间编辑区域
│   ├── GridCanvas/             # 网格画布
│   ├── ComponentContainer/     # 组件容器
│   ├── DragHelper/             # 拖拽辅助
│   ├── SelectionManager/       # 选择管理
│   ├── AlignmentGuides/        # 对齐辅助
│   ├── ContextMenu/            # 右键菜单
│   └── CanvasToolbar/          # 画布工具栏
├── PropertyPanel/              # 右侧属性编辑面板
│   ├── PropertyForm/           # 属性表单
│   ├── StyleEditor/            # 样式编辑器
│   ├── EventEditor/            # 事件编辑器
│   ├── DataBindingPanel/       # 数据绑定面板
│   └── TemplateManager/        # 模板管理
├── Renderer/                   # 组件渲染器
│   ├── ComponentRenderer/      # 组件渲染核心
│   ├── ContainerRenderer/      # 容器渲染
│   ├── ChartRenderer/          # 图表渲染
│   └── FormRenderer/           # 表单渲染
├── DataManager/                # 数据管理
│   ├── DataModeler/            # 数据模型设计
│   ├── ApiConfigurator/        # API配置
│   ├── MockDataGenerator/      # Mock数据生成
│   └── DataTransformer/        # 数据转换
├── types/                      # 类型定义
│   ├── component.ts            # 组件类型
│   ├── schema.ts               # Schema类型
│   ├── editor.ts               # 编辑器类型
│   └── data.ts                 # 数据类型
├── constants/                  # 常量定义
├── hooks/                      # 自定义hooks
│   ├── useDrag.ts              # 拖拽hook
│   ├── useComponentRenderer.ts # 渲染hook
│   ├── usePropertyEditor.ts    # 属性编辑hook
│   └── useHistory.ts           # 历史记录hook
├── utils/                      # 工具函数
│   ├── schemaUtils.ts          # Schema工具
│   ├── styleUtils.ts           # 样式工具
│   ├── eventUtils.ts           # 事件工具
│   └── exportUtils.ts          # 导出工具
├── store/                      # Pinia状态管理
│   ├── components.ts           # 组件store
│   ├── editor.ts               # 编辑器store
│   ├── history.ts              # 历史记录store
│   ├── data.ts                 # 数据store
│   └── settings.ts             # 设置store
└── services/                   # 服务
    ├── renderService.ts        # 渲染服务
    ├── exportService.ts        # 导出服务
    ├── importService.ts        # 导入服务
    └── historyService.ts       # 历史记录服务

## 组件交互限制
- 所有组件仅供展示，禁止触发原生交互
- 禁用组件的原生点击、输入、选择等功能
- 仅通过右侧属性面板修改组件配置
- 预览模式下允许组件交互测试

## 布局组件特性
- el-container默认宽高100%，需明确展示并在属性面板中提供修改选项
- el-header、el-footer默认高度60px
- el-aside默认宽度300px
- 布局组件默认样式需在属性面板中可配置

## 布局辅助工具
- 网格显示/隐藏控制
- 对齐辅助线
- 组件间距显示
- 快速对齐工具栏
- 缩放控制
- 画布大小调整
- 标尺功能
- 参考线功能
- 快捷键支持

## 扩展性设计
- 插件系统支持功能扩展
- 自定义组件注册机制
- 主题系统支持样式定制
- 布局模板系统
- 多语言支持

## 代码规范
- 添加中文注释
- 包含错误处理
- 使用TypeScript类型定义
- 遵循Vue3最佳实践
- 组件最小化原则
- 性能优化考虑

## Storybook Stories要求
为每个主要组件创建.stories.ts文件，展示以下典型场景:
- 基础空白编辑器
- 预填充了示例组件的编辑器
- 演示组件拖拽与精确位置放置的交互示例
- 展示实时预览与属性编辑效果的示例
- 不同布局组件的嵌套示例
- 图表组件配置与实时预览示例
- 组件对齐和布局调整示例
- 数据绑定与动态渲染示例
- 事件配置与交互示例
- 每个Story提供必要的文档说明用途和用法
```


