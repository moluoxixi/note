---
title: echarts
description: echarts笔记
date: 2025-01-28
ptags:
  - 前端
tags:
  - 前端
---
# 基础操作

引入echars

```
import echarts from 'echarts的路径';
```

准备一个有高度的容器

```
<div id="box"></div>
```

初始化echars实例

```
let myCharts=echarts.init(document.querySelector('#box'));
```

写echars配置项

```
let options={}
```

引入配置项

```
myCharts.setOption(options);
```

vue-echarts包

```
<v-chart :option="option" autoresize></v-chart>
```

# 常见问题

## 初始数据为undefined导致的问题

xAxis初始数据为undefined时,显示奇奇怪怪的,只能给xAxis初始数据设置为undefined

## 动态绘制的图不会具有自适应

等同于vue-charts组件的autoresize属性

需要给window绑定resize监听,在回调里面调用echarts的resize()方法

## 提示框超出被隐藏问题

- 解决一: confine: true, // 将 tooltip 框限制在容器的区域内

- 问题: 有可能档住了鼠标

- 解决二: position (point, params, dom, rect, size) 返回位置坐标 [x, -40]

# 常用配置项

## title

单个{}

多个[]

| text         | '',标题文本            |
| ------------ | ------------------ |
| textStyle    | {},标题样式fontSize:18 |
| subtext      | '',子标题文本           |
| subtextStyle | {},子标题样式           |
|              |                    |
| link         | 标题超链接              |
| target       | 标题指定窗口超链接          |


## legend

{}

| data                  | 表格头部的名字          |
| --------------------- | ---------------- |
| orient                | '',方向vertical,垂直 |
| top/left/right/bottom | 定位               |


## xAxis+yAxis

{}

xAxis X轴相关

yAxis Y轴相关

x轴和y轴

默认情况下:y轴为直轴,x为类轴

| data        | [],每个格子中间显示的值    |
| ----------- | ---------------- |
| show        | false,不显示轴线      |
| boundaryGap | false,轴线两边不留白    |
| type        | '',category指定为类轴 |
| min/max     | number,最小值最大值    |
| axisTick    | {},轴线刻度          |


## series

单个{}

多个[]

数据

| name      | '',对应legend的data名字             |                   |
| --------- | ------------------------------ | ----------------- |
| type      | '',显示的类型,bar柱状图,line折线图,pie饼状图 |                   |
| radius    | [40%,70%],圆的内外半径百分比            |                   |
| smooth    | true,折线图变成曲线图                  |                   |
| labelLine | {}                             |                   |
| data      | [],直轴显示的数据                     |                   |
| areaStyle | 设置填充的颜色(图的颜色)                  |                   |
| itemStyle | {},设置每个峰值的样式,opacity:0,隐藏峰值小圆点 |                   |
| lineStyle | {},设置线条样式,opactiy:0,隐藏线条       |                   |
| barWidth  | number,每个柱的宽度                  |                   |
| color     | 设置文本的颜色                        |                   |
| label     | {},文本配置,formatter-->''         | fn,自定义文本内容自定义文本内容 |
| labelLine | {},length:number               |                   |
|           |                                |                   |
|           |                                |                   |


## tooltip

{}

提示

| trigger   | '',触发时机,Aixs滑到轴线上触发                       |
| --------- | ----------------------------------------- |
| confine   | true,限制提示框在容器内                            |
| position  | fn(鼠标,x,x,x,大小){},返回相对echarts框定位坐标数组[x,y] |
| formatter | ''\|\|fn, 自定义文本内容                         |


## grid

{}

网格

| top/bottom/left/right | number,距离容器上下左右的距离,可以压缩绘制的图让它在容器内 |
| --------------------- | --------------------------------- |
|                       |                                   |
