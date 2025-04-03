[vite 配置](https://ui.shadcn.com/docs/installation/vite)

| react命令                         | vue 命令                              | 作用                         |
| ------------------------------- | ----------------------------------- | -------------------------- |
| pnpm dlx shadcn@latest init<br> | pnpm dlx shadcn-vue@latest init<br> | 初始化，项目依赖 tailwind, 先跟着官网配置 |
| pnpm dlx shadcn@latest add<br>  | pnpm dlx shadcn-vue@latest add<br>  | 添加组件                       |
[components](https://ui.shadcn.com/docs/components)

问题 1: 草稿没有方的概念
问题 2: 双击的医嘱没有 prescId | sourcePrescId
```
checkBigTypeCode: checkBigTypeCode ? checkBigTypeCode : this.catalogCode,
        medicalType: '0',
        positionCodes: this.searchFormXm.positionCodes,
```