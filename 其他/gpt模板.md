---
title: gpt模板
description: gpt模板笔记
date: 2025-01-28
tags:
- 其他
---

# 实用
## 虚拟模块
```
使用E:\project\companyProject\trasen\vue-component\packages\utils\ViteConfig\src\plugins\utils\virtual.ts抛出的工厂函数，在E:\project\companyProject\trasen\vue-component\packages\utils\ViteConfig\src\plugins\importComponentsOrUtils.ts中实现如虚拟模块插件，要求如下：  
虚拟模块id默认为virtual:
```
## 封装 com
```
参考tsCheckbox的目录结构，封装一个xx组件，功能如下：

```
## 注释

```
## 函数或方法规范：
1. 统一采用 jsDoc 进行参数注释，要求描述到每一个参数
2. 多参数，采用 options 对象作为入参，在函数体首行进行解构，
3. 所有函数入参都应该有默认值，如果是函数体内对参数解构，可忽略解构默认值
4. 每个参数的类型都应该在当前文件所处目录的_types 目录下有精准的定义
5. 方法与类型的命名应该与接口强关联，例如/suno/cover/generate，方法名就应该是 sunoCoverGenerate，它的入参类型就应该是 sunoCoverGenerateParamsType
```

```
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
我更新了TsSelect,TsCheckbox,TsRadio,Tabs，
请仔细阅读packages/components中的对应组件的源码，特别是props,slots,defineExpose,defineEmit，去更新docs/examples中对应组件的示例，和docs/components/基础组件中对应的文档，以及它自己的README.md，参考docs/examples/DateRangePicker中示例，  
1. 添加非常多的单个示例，直到能表达出每一个props的作用
2. 示例中不要用单行语句，包含样式和js
3. 不要使用alert
4. 函数采用function
5. 同一类型的示例应该放在同一文件夹中，参考docs/examples/DateRangePicker/type文件夹  
6. 描述应该放在docs/components/基础组件对应的md中，不要放在docs/examples/Tree中  
7. 每个:::demo :::块应该有单独的描述而不是整体描述  
8. examples中不应该有tailwind样式，仅采用原生css
9. 组件无须引入，已经被全局注册了
10. 表格中的代码描述需要使用``包裹
11. 遇到|字符需要转义
12. 类型声明过长时需要用^[属于什么类型，例如Function]`具体的类型`
13. 删除无用文件
14. README.md使用原生markdown语法提供示例
```

```
我更新了AjaxPackage，
请仔细阅读packages/utils中的对应的源码，去更新docs/examples中对应的示例，以及它自己的README.md，参考docs/examples/ViteConfig中示例，  
1. 添加非常多的单个示例，直到能表达出每一个props的作用
2. 示例中不要用单行语句，包含样式和js
3. 不要使用alert
4. 函数采用function
5. 遇到|字符需要转义
6. 类型声明过长时需要用^[属于什么类型，例如Function]`具体的类型`
7. 删除无用文件
8. README.md使用原生markdown语法提供示例
```


```
参照E:\project\companyProject\trasen\vue-component\docs\vitepress\components中的组件与工具包的.md说明文件，更新/新增各组件与工具包的README.md，
统一添加基础示例，工具包提供api，组件添加props,events,Slots、Expose，
已经存在的README也需要更新的一致
```
## 虚拟卡
```
邮箱授权码：vvodtpkachpvijaa
```

```
卡号：5371007492678987
有效期：11/28
cvv：363
余额：10usd
（First Name（名）：Edgar ;
Last Name（姓）：Hettinger ;
账单国家/地区：US（美国）  ;
账单州省：CA（California加利福尼亚州）;
账单城市：San Jose ;
账单街道地址：2381 Zanker Rd Ste 110 ;
账单邮编：95131）
```

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


AIzaSyCDYiGqWECy6qf-pEHx8taJlDu5vPyMY8Y
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