```
[@form-create/element-ui 驱动安装]
packages/element-ui/src/core/index.js
  ├─ 注册别名：FormCreate.componentAlias(alias)
  │    └─ packages/element-ui/src/core/alias.js   (form → el-form, formItem → el-form-item, ...)
  ├─ 注册组件/解析器/Maker
  ├─ 注入 Element Plus：window.ElementPlus 或
  └─（常用）packages/element-ui/auto-import.js 注册 ElForm 等组件

[核心创建与挂载]
packages/core/src/frame/index.js
  └─ createFormApp(rule, option)
       └─ render() { return h(Type, { ref:'fc', rule, option }) }  ← 入口组件

[入口组件把渲染权交给渲染器]
packages/core/src/components/formCreate.js
  └─ render() { return this.fc.render(); }  ← 运行时渲染入口

[渲染器构建与默认渲染]
packages/core/src/render/index.js
  └─ new fc.CreateNode(handle) 供节点创建
packages/core/src/render/render.js
  └─ defaultRender(ctx, children) 组织VNode/属性/事件

[别名解析与真实组件渲染（最终落点）]
packages/core/src/factory/node.js
  ├─ CreateNode.use(alias)            ← 启用别名表（含 form → el-form）
  └─ h(tag, data, children)
       └─ resolveComponent('el-form') ← 解析为 Element Plus 的 ElForm 并渲染
```