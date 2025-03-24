---
title: Css和html
description: 一个Css和html笔记
date: 2025-03-05
hidden: false
tags: Css和html
ptags: 
---



# Css&html

## BFC&层叠顺序&选择器优先级

```js
-->BFC
	块级格式化上下文，内部子元素会按独特的规则进行排列：
		相邻元素margin会发生重叠，无论什么方向
		计算宽高时，float元素也会被计算，不会再高度塌陷
		
	触发条件：
		根元素，即HTML标签
		overflow不为visible
		float不为none
		display为：inline-block flex inline-flex grid inline-gird  inline-table table-cell table-caption
		position 为absolute/fixed

-->层叠顺序
	z-index为负< background< border< 块级元素 <浮动元素 <内联元素 <没有设置z-index的定位元素 < z-index为正

-->选择器优先级
	!important>行内>id>类&伪类(:)>元素&伪元素(::)>通配符*
```

## 五种监听器

### IntersectionObserver

```js
//监听元素在监听器在指定根元素划分的可视区 的 可见性变化,即进入或离开这块区域
const rootElement = document.getElementById('box')
const rootHeight = rootElement.getBoundingClientRect().height  
intersectionObserver = new IntersectionObserver(  
	(entries) => {  
		entries.forEach((entry) => {  
			if (entry.isIntersecting) {} //元素是否进入可视区域
			//entry.isVisible						//元素是否可见
			//entry.boundingClientRect 	//触发的元素当前的getBoundingClientRect()返回对象
			//entry.rootBounds						//监听的根元素当前的getBoundingClientRect()返回对象
			//entry.target								//触发的元素
		})  
	},  
	{  
		root: rootElement,
		// 指定可视区,对应margin,这里是指定根元素的 顶部0 - 顶部60px 为可视区域
		rootMargin: `0px 0px ${-(rootHeight - 60)}px 0px`,
		// 交叉比例,要完全显示或完全隐藏才算变化
		threshold: [1.0]  
	}  
)

intersectionObserver.observe(要监听的元素);
intersectionObserver.unobserve(取消监听的元素);
intersectionObserver.disconnect();
```

```vue
<!--组件封装-->
<template>  
  <div id="intersection-observer-box" v-bind="$attrs">  
    <slot />  </div></template>  
<script setup>  
import { onBeforeUnmount, onMounted } from 'vue'  
  
const props = defineProps({  
  // 元素是否进入视口  
  isIntersecting: {  
    type: Boolean,  
    default: true  
  },  
  // 进入或离开视口的比例  
  threshold: {  
    type: Number,  
    default: 1.0  
  },  
  // 默认进入或离开容器触发监听,  
  // 如果设置了rootMargin，分别对应容器上右下左收缩的比例  
  // 例如[0,0,0.8,0] 代表仅监听0-20%高度部分  
  rootMargin: {  
    type: Array,  
    default: () => [0, 0, 0, 0]  
  },  
  // 需要监听进入/离开容器的元素列表  
  observers: {  
    type: Array,  
    default: () => []  
  },  
  // 需要监听进入/离开容器的元素id列表  
  observerIds: {  
    type: Array,  
    default: () => []  
  }  
})  
/*  
* mutate接受根据isIntersecting判断的进入或离开视口的元素  
* getTargets接受根据observerIds获取到的元素组成的{id:target} 隐射对象  
* */  
const emits = defineEmits(['mutate', 'getTargets'])  
  
let rootElement = null  
let observer, resizeObserver  
onMounted(() => {  
  rootElement = document.getElementById('intersection-observer-box')  
  resizeObserver = new ResizeObserver((entries) => {  
    for (const entry of entries) {  
      if (entry.contentBoxSize) {  
        // Firefox将' contentBoxSize '实现为单个内容矩形，而不是数组  
        const contentBoxSize = Array.isArray(entry.contentBoxSize)  
          ? entry.contentBoxSize[0]  
          : entry.contentBoxSize  
        const { blockSize, inlineSize } = contentBoxSize  
        if (observer) observer.disconnect()  
  
        const { threshold, isIntersecting, observers, observerIds } = props  
  
        let rootMargin = ''  
        props.rootMargin.forEach((item, index) => {  
          rootMargin += `${index % 2 ? -inlineSize * item : -blockSize * item}px `  
        })  
        observer = new IntersectionObserver(  
          (entries) => {  
            entries.forEach((entry) => {  
              console.log('entry', entry)  
              if (entry.isIntersecting == isIntersecting) {  
                emits('mutate', entry)  
              }  
            })  
          },  
          {  
            root: rootElement,  
            rootMargin,  
            threshold: [threshold]  
          }  
        )  
        observers.forEach((domItem) => {  
          observer.observe(domItem)  
        })  
        const targets = observerIds.reduce((p, id) => {  
          p[id] = document.getElementById(id)  
          return p  
        }, {})  
        Object.values(targets).forEach((domItem) => {  
          observer.observe(domItem)  
        })  
        emits('getTargets', targets)  
      }  
    }  
  })  
  resizeObserver.observe(rootElement, {  
    box: 'content-box'  
  })  
})  
onBeforeUnmount(() => {  
  resizeObserver.disconnect()  
  observer.disconnect()  
})  
</script>  
  
<style scoped lang="scss"></style>

```

### ResizeObserver

```js
// 监听元素大小的改变
const resizeObserver = new ResizeObserver((entries) => {  
	for (const entry of entries) {
	    if (entry.contentBoxSize) {
			// Firefox将' contentBoxSize '实现为单个内容矩形，而不是数组
			const contentBoxSize = Array.isArray(entry.contentBoxSize)
				? entry.contentBoxSize[0]
				: entry.contentBoxSize;
			// blockSize元素现在的高度,inlineSize元素现在的宽度
			const { blockSize, inlineSize } = contentBoxSize;
			//do something
	    }
    }
})  
resizeObserver.observe(要监听的元素, {
	box:'border-box' //设置监听的盒模型,content-box（默认）,border-box
})
resizeObserver.unobserve(取消监听的元素);
resizeObserver.disconnect();

  ```

### MutationObserver

```js
// 监听对元素 属性,节点 的修改
// 例如监听水印的移除再添加回去
const mutationObserver = new MutationObserver((mutationsList) => { 
	for (let mutation of mutationsList) {
		if (mutation.type == "childList") {} //子节点新增or删除
		else if (mutation.type == "attributes") {} //属性修改
	}
});
mutationObserver.observe(要监听的元素, {
	childList: false, // 子节点的变动（新增、删除或者更改）  
    attributes: true, // 属性的变动
    attributeFilter: ['style'], 
    characterData: false, // 节点内容或节点文本的变动  
    subtree: false // 是否将观察器应用于该节点的所有后代节点 
});
mutationObserver.unobserve(取消监听的元素);
mutationObserver.disconnect();
```

### PerformanceObserver&ReportingObserver

```js
// PerformanceObserver接收性能报告
// ReportingObserver接收违反安全策略,网络错误等的报告
```

## Other

```js
user-select: none; //禁止文本选中
```

## link 和@import

```js
-->link和@import
	`link` 标签会在解析时对于的 `link` 标签时开始下载，`@import` 规则会在在 CSS 文件被下载和解析到包含 `@import` 语句时才开始下载被导入的样式表。这意味着使用 `link` 标签可以更快地加载样式
	
	`link` 标签解析过程中会阻塞后续 dom 解析，阻塞页面渲染，包括解析并下载 `link` 标签中的 `@import` 所引用的 css 文件
	
	`@import` 加载顺序在 `link` 之后，会覆盖 `link` 的样式
	
	`link` 标签是HTML标签，所以它的支持性非常广泛，适用于所有主流的现代浏览器。而 `@import` 规则是CSS提供的一种导入样式表的方式，虽然也被大多数浏览器支持，但在一些旧版本的浏览器中可能存在兼容性问题。
	
	`@import` 规则只能在CSS样式表中使用，而不能在HTML文件中使用。`link` 标签可以用于在HTML文件中导入样式表，还可以用于导入其他类型的文件，如图标文件
```

## 布局方式

```css
flex
flex-driection
justifty-content
align-items
```

## BOM

### 三种鼠标位置

只读

| event. clientX & clientY | 拿的是鼠标相对视口的水平距离和垂直距离，相对的是视口的左上角（以视口左上角为原点)                 |
| ----------------------- | --------------------------------------------------------- |
| event. pageX & pageY     | 拿的是鼠标相对页面的水平距离和垂直距离，相对的是页面的左上角（以页面左上角为原点） 不支持 ie9 以下        |
| event. offsetX & offsetY | 拿的是鼠标相对绑定事件的元素自身的水平距离和垂直距离，相对的是绑定事件的元素自身的左上角（以元素自身左上角为原点) |

screen

### 四种元素位置

只读

| 元素.getBoundingClientRect (). top/buttom/left/right | 拿的是元素距离视口上下左右的距离        |
| ------------------------------------------------ | ----------------------- |
| 元素. clientLeft& clientTop                         | 拿的是元素边框大小               |
| 元素. offsetLeft& offsetTop                         | 元素偏移量绝对定位值+元素自身的 margin |
| 元素. scrollLeft& scrollTop 可写                      | 拿的是元素滚动距离               |

### 四种元素大小

只读

| 元素.getBoundingClientRect (). width/height | 拿的是元素内容 + padding + border 的宽/高, 包含小数                                                     |
| --------------------------------------- | --------------------------------------------------------------------------------------- |
| 元素. clientWidth& clientHeight            | 内容 + padding 的宽/高                                                                        |
| 元素. offsetWidth& offsetHeight            | 内容 + padding + border 的宽/高                                                               |
| 元素. screenWidth& screenHeight            | 当内容比盒子小的时候，拿的是盒子的 clientWidth/Height 当内容比盒子大的时候，拿的是内容的 offsetWidth/Height 加一侧外边距+盒子的一侧内边距 |
