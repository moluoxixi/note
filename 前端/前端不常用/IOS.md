---
title: IOS
description: IOS笔记
date: 2025-01-28
ptags:
  - 前端
tags:
  - 前端
---
## ios 键盘换行变为搜索

1. input type="search"

1. input 外面套 form，必须要有 action，action="javascript:return true'

1. 表单提交阻止默认提交事件

```javascript
<form action="javascript:return true" @submit.prevent="fomSubmit">
    <input type="search" placeholder="请输入诉求名称" id="search" />
</form>
```