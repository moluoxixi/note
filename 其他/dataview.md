
| 设置字段  | 释义                                                                               | 必要与否 |
| ----- | -------------------------------------------------------------------------------- | ---- |
| list  | 展现形式。创建列表，还有 table、task 可以选择                                                     | 必要   |
| from  | 检索范围。<br>"文件夹名 或 文件名 或 从根目录开始的path" 从哪个文件夹/文件查找,为空代表所有文件<br>`#标签名` 从哪个指定标签名的文件查找 | 非必要  |
| where | 聚合条件。contains(file.name,"Dataview") 就是匹配文件名为 “Dataview” 的文件                      | 非必要  |
| sort  | 排序，根据什么做排序。 `sort file.ctime` 就是根据文件的创建时间正序                                      | 非必要  |
## file元数据
![[Pasted image 20241212164346.png]]

## 添加文件属性
```js
---
title:123
author: tags: []
---

list from "" where contains(title ,"123")
```
```dataview
task from "大纲"
```
