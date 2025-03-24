---
title: Css和html
description: 一个Css和html笔记
date: 2025-03-05
hidden: false
tags: Css和html
ptags: 
---

# Css&html

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



# 常用布局

## Flex布局
### flex 容器属性

#### 1. flex-direction（子元素排列顺序）

`flex-direction` 属性规定灵活项目的排列方向（主轴方向）：

- **row**: 默认值，灵活的项目将水平显示。
- **row-reverse**: 与 row 相同，但以相反的顺序。
- **column**: 灵活的项目将垂直显示。
- **column-reverse**: 与 column 相同，但以相反的顺序。

#### 2. flex-wrap（换行）

用于设置伸缩项目在主轴上的换行方式：

- **nowrap**: 默认值，灵活的项目不拆行或不拆列。
- **wrap**: 在必要时拆行或拆列。
- **wrap-reverse**: 在必要时拆行或拆列，但以相反的顺序。

#### 3. flex-flow

`flex-flow` 属性是 `flex-direction` 属性和 `flex-wrap` 属性的简写形式，默认值为 `row nowrap`，用于简化代码。

#### 4. justify-content（主轴对齐方式）

`justify-content` 用于设置弹性盒子元素在主轴（横轴）方向上的对齐方式：

| 值               | 描述                                      |
|------------------|-------------------------------------------|
| **flex-start**   | 默认值，项目位于容器的开头。             |
| **flex-end**     | 项目位于容器的结尾。                     |
| **center**       | 项目位于容器的中心。                     |
| **space-between**| 项目位于各行之间留有空白的容器内。       |
| **space-around** | 项目位于各行之前、之间、之后都留有空白。 |

#### 5. align-items（侧轴对齐方式）

`align-items` 定义 flex 子项目在 flex 容器的侧轴（纵轴）方向上的对齐方式：

| 值         | 描述                                      |
|------------|-------------------------------------------|
| **stretch**| 默认值，元素被拉伸以适应容器。           |
| **center** | 元素位于容器的中心。                     |
| **flex-start** | 元素位于容器的开头。                 |
| **flex-end**   | 元素位于容器的结尾。                 |
| **baseline**    | 元素位于容器的基线上。              |

#### 6. align-content（多行文本 y 轴对齐方式）

`align-content` 用于设置多行子元素在容器侧轴上的对齐方式（多行时才有效）：

| 值            | 描述                                      |
|---------------|-------------------------------------------|
| **stretch**   | 默认值，元素被拉伸以适应容器。           |
| **center**    | 元素位于容器的中心。                     |
| **flex-start**| 元素位于容器的开头。                     |
| **flex-end**  | 元素位于容器的结尾。                     |
| **space-between** | 元素位于各行之间留有空白的容器内。 |
| **space-around**  | 元素位于各行之前、之间、之后留有空白。 |

> 说明：`align-content` 在侧轴上执行样式时，会把默认的间距合并。对于单行子元素，该属性不起作用。

### flex 子元素属性

#### 1. align-self（单个元素侧轴对齐方式）

`align-self` 定义 flex 子项单独在侧轴（纵轴）方向上的对齐方式：

| 值         | 描述                                      |
|------------|-------------------------------------------|
| **auto**   | 默认值，继承父容器的 `align-items` 属性。 |
| **stretch**| 元素被拉伸以适应容器。                   |
| **center** | 元素位于容器的中心。                     |
| **flex-start** | 元素位于容器的开头。                 |
| **flex-end**   | 元素位于容器的结尾。                 |
| **baseline**    | 元素位于容器的基线上。              |

#### 2. flex-grow（扩展比率）

`flex-grow` 用于设置或检索弹性盒子项目的扩展比率：

- **number**: 规定项目将相对于其他灵活的项目进行扩展的量。默认值是 0。

#### 3. flex-shrink（收缩比率）

`flex-shrink` 设置弹性盒的伸缩项目的收缩比率：

- **number**: 规定项目将相对于其他灵活的项目进行收缩的量。默认值是 1，表示溢出时等比例缩小。

**算法-公式**：
- 超出空间的像素数：1000 - (900 + 200) = -100px
- 加权总和：=(第一个子元素的宽度) * (shrink) + (第二个子元素的宽度) * (shrink) + ...
- A 收缩的像素数：\(\frac{(Awidth \times shrink)}{加权综合} \times 超出空间\)

#### 4. flex-basis（伸缩基准值）

`flex-basis` 设置弹性盒伸缩基准值（指定 flex-item 在主轴上的初始大小）：

- **number**: 规定灵活项目的初始长度。
- **auto**: 默认值，长度等于灵活项目的长度。

#### 5. order（出现顺序）

`order` 属性设置或检索弹性盒模型对象的子元素出现的顺序：

- **number**: 值越小排列越靠前，值越大顺序越靠后。

#### 6. flex（属性简写）

- `flex` 属性用于设置弹性盒模型对象的子元素如何分配父元素的空间。
- `flex` 属性是 `flex-grow`、`flex-shrink` 和 `flex-basis` 属性的简写属性。

| 值   | 描述                |
|------|---------------------|
| **auto** | 1 1 auto          |
| **none** | 0 0 auto          |
| **1**    | 1 1 0%            |
## Grid布局
```text
display: grid;

display: inline-grid;

grid-template-columns: 100px 1fr 1fr;                // fr 是fraction 的缩写，意为"片段"，可以与绝对长度的单位结合使用
grid-template-columns: 1fr 1fr 1fr;
grid-template-columns: repeat(3, 1fr);               // repeat()接受两个参数，第一个参数是重复的次数，第二个参数是要重复的值。
grid-template-columns: 1fr 1fr minmax(100px, 1fr);   // minmax()函数产生一个长度范围，表示长度就在这个范围之中。它接受两个参数，分别为最小值和最大值。
grid-template-columns: repeat(auto-fill, 100px);     // 空白匿名网格
grid-template-columns: repeat(auto-fit, 100px);      // 空白匿名网格折叠合并
grid-template-columns: fit-content(100px) fit-content(100px) 40px auto;  // 让尺寸适应于内容，但不超过设定的尺寸,只支持数值和百分比值

grid-template-rows  //  使用方法与列相同

row-gap: 20px;       // 行间距
column-gap: 30px;    // 列间距
gap: 20px;           // 行列间距

justify-items 指定单元格内容的水平对齐方式，属性值有：
stretch：【默认值】拉伸，占满单元格的整个宽度。
start：对齐单元格的起始边缘。
end：对齐单元格的结束边缘。
center：单元格内部居中。

align-items 指定单元格内容的垂直对齐方式，属性值有：
normal：【默认值】会根据使用场景的不同表现为stretch或者start。
stretch：拉伸，占满单元格的整个宽度。
start：对齐单元格的起始边缘。
end：对齐单元格的结束边缘。
center：单元格内部居中。
baseline：基线对齐（align-items属性特有属性值）

place-items 是align-items属性和justify-items属性的合并简写形式：
place-items: start end;

justify-self 跟justify-items属性的用法完全一致，但只作用于单个项目。

align-self 跟align-items属性的用法完全一致，也是只作用于单个项目。

place-self 是align-self属性和justify-self属性的合并简写形式。
```

# 常用属性

## 通用属性

| 属性      | 描述                                      |
|-----------|-------------------------------------------|
| initial   | 默认值                                    |
| unset     | 未设置（用于样式重置）                   |
| revert    | 回归到浏览器的默认样式                   |

## 边框的属性

### 1. border-width

| 属性值   | 描述                                      |
|----------|-------------------------------------------|
| thin     | 定义细的边框。                           |
| medium   | 默认。定义中等的边框。                   |
| thick    | 定义粗的边框。                           |
| length   | 允许您自定义边框的宽度。                 |

### 2. border-color

| 属性值           | 描述                                      |
|------------------|-------------------------------------------|
| color_name       | 颜色名称                                  |
| hex_number       | 十六进制颜色                              |
| rgb_number       | RGB 颜色                                   |
| transparent      | 默认值，边框颜色为透明                   |

### 3. border-style

| 属性值   | 描述                                      |
|----------|-------------------------------------------|
| none     | 定义无边框。                             |
| hidden   | 与 "none" 相同，但用于表格时解决边框冲突。 |
| dotted   | 定义点状边框。                           |
| dashed    | 定义虚线。                               |
| solid    | 定义实线。                               |
| double   | 定义双线。                               |
| groove   | 定义 3D 凹槽边框。                      |
| ridge    | 定义 3D 垄状边框。                      |
| inset    | 定义 3D inset 边框。                    |
| outset   | 定义 3D outset 边框。                   |

### 4. 边框简写

```css
border: 5px solid #ff0000; /* 边框宽度 边框风格 边框颜色 */
```

### 5. 单方向边框设置

```css
border-bottom: 边框宽度 边框风格 边框颜色; /* 底边框 */
border-left: 边框宽度 边框风格 边框颜色;   /* 左边框 */
border-right: 边框宽度 边框风格 边框颜色;  /* 右边框 */
border-top: 边框宽度 边框风格 边框颜色;    /* 上边框 */
```

### 6. 边框属性设置示例

| 属性                        | 描述                                      |
|-----------------------------|-------------------------------------------|
| border-width/color/style    | A B C D; 上右下左                     |
| border-width/color/style    | A B C; 上左右下                        |
| border-width/color/style    | A B; 上下左右                           |
| border-width/color/style    | A; 上下左右                              |

## 背景属性

### 1. background-color

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| colorname            | 规定颜色名称为背景                       |
| hex                  | 规定十六进制的背景颜色                   |
| rgb                  | 规定 RGB 的背景颜色                        |
| transparent          | 默认，背景颜色为透明                     |

### 2. background-image

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| url ()                | 指向图像路径                             |
| none                 | 默认值，不显示背景图像                   |

### 背景图片的显示原则

1. 容器尺寸等于图片尺寸，背景图片正好显示在容器中。
2. 容器尺寸大于图片尺寸，背景图片将默认平铺，直至铺满元素。
3. 容器尺寸小于图片尺寸，只显示元素范围以内的背景图。

### 3. background-repeat

| 属性值       | 描述                                      |
|--------------|-------------------------------------------|
| no-repeat    | 背景图像仅显示一次，不平铺               |
| repeat       | 默认。背景图像将在垂直和水平方向重复   |
| repeat-x     | 背景图像将在水平方向重复                 |
| repeat-y     | 背景图像将在垂直方向重复                 |

### 4. background-position

| 属性值                  | 描述                                      |
|-------------------------|-------------------------------------------|
| xpos/%/left right center| 水平位置                                  |
| ypos/%/top bottom center | 垂直位置                                  |

### 5. background-attachment

| 属性值       | 描述                                      |
|--------------|-------------------------------------------|
| scroll       | 默认值。背景图像会随着页面的滚动而移动   |
| fixed        | 背景图像不会随着页面的滚动而移动         |

### 6. background

| 属性值                       | 描述                                      |
|------------------------------|-------------------------------------------|
| background: color image repeat position attachment; | 简写属性，在一个声明中设置所有的背景属性 |

## 文本的属性

### 1. font-size

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| 数值型               | 必须给属性值加单位，0 时除外             |
| 绝对大小关键字      | xx-small = 9px, x-small = 11px, ...     |

### 2. color

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| colorname            | 颜色名称                                  |
| hex                  | 十六进制颜色                              |
| rgb                  | RGB 颜色                                   |

### 3. font-family

| 描述                                      |
|-------------------------------------------|
| 设置多个字体名称作为后备机制              |
| 字体名称超过一个字时，必须用引号          |
| 多个字体系列用逗号分隔                    |

### 4. font-weight

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| bolder               | 更粗的                                    |
| bold                 | 加粗                                      |
| normal               | 常规                                      |
| lighter              | 更细                                      |
| 100—900             | 100 对应最轻的字体变形                    |

### 5. font-style

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| italic               | 倾斜                                      |
| oblique              | 更倾斜                                    |
| normal               | 取消倾斜，常规显示                        |

### 6. line-height

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| normal               | 默认。设置合理的行间距                    |
| number               | 设置数字，此数字会与当前的字体尺寸相乘   |
| length               | 设置固定的行间距                          |

### 7. text-align

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| left                 | 把文本排列到左边。                        |
| right                | 把文本排列到右边。                        |
| center               | 把文本排列到中间。                        |
| justify              | 实现两端对齐文本效果。                    |

### 8. text-decoration

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| none                 | 没有修饰                                  |
| underline            | 添加下划线                                |
| overline             | 添加上划线                                |
| line-through         | 添加删除线                                |

### 9. text-indent

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| length               | 定义固定的缩进。                          |
| %                    | 定义基于元素宽度的百分比的缩进。         |

### 10. text-transform

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| none                 | 默认。标准文本                            |
| capitalize           | 每个单词以大写字母开头                    |
| uppercase            | 仅有大写字母                              |
| lowercase            | 仅有小写字母                              |

### 11. letter-spacing

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| normal               | 默认。字符间没有额外的空间                |
| length               | 定义字符间的固定空间（允许使用负值）。   |

### 12. word-spacing

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| normal               | 默认。定义单词间的标准空间                |
| length               | 定义单词间的固定空间。                    |

## 文本溢出

### overflow

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| visible              | 默认值，内容不会被修剪                    |
| hidden               | 内容会被修剪且不可见                      |
| scroll               | 内容会被修剪，显示滚动条                  |
| auto                 | 内容被修剪时显示滚动条                    |
| inherit              | 从父元素继承 overflow 属性的值              |

### white-space

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| normal               | 默认值，多余空白会被忽略                  |
| pre                  | 空白会被保留（类似 pre 标签）              |
| pre-wrap             | 保留空白符序列，正常换行                  |
| pre-line             | 合并空白符序列，保留换行符                |
| nowrap               | 文本不会换行，直到遇到<br/>标签为止      |

### text-overflow

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| clip                 | 不显示省略号（...），简单裁切             |
| ellipsis             | 溢出时显示省略标记                        |

### 示例代码

```css
/* 设置单段文字显示省略号 */
width: 100px; /* 强制容器宽度 */
white-space: nowrap; /* 文字在一行显示 */
overflow: hidden; /* 设置文字溢出 */
text-overflow: ellipsis; /* 溢出文字显示省略号 */

/* 多行文本省略 */
display: -webkit-box;
-webkit-line-clamp: 3;
-webkit-box-orient: vertical;
overflow: hidden;
text-overflow: ellipsis;
white-space: nowrap;
```

## 列表属性

### list-style-type

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| none                 | 无标记                                    |
| disc                 | 默认。标记是实心圆                        |
| circle               | 标记是空心圆                              |
| square               | 标记是实心方块                            |
| decimal              | 标记是数字                                |
| decimal-leading-zero  | 0 开头的数字标记 (01, 02, 03, 等)        |
| lower-roman          | 小写罗马数字 (i, ii, iii, iv, v, 等)     |
| upper-roman          | 大写罗马数字 (I, II, III, IV, V, 等)     |
| lower-alpha          | 小写英文字母 (a, b, c, d, e, 等)         |
| upper-alpha          | 大写英文字母 (A, B, C, D, E, 等)         |
| lower-greek          | 小写希腊字母 (alpha, beta, gamma, 等)    |
| lower-latin          | 小写拉丁字母 (a, b, c, d, e, 等)         |
| upper-latin          | 大写拉丁字母 (A, B, C, D, E, 等)         |

### list-style-position

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| inside               | 列表项目标记放置在文本以内                |
| outside              | 默认值。标记位于文本的左侧                |

### list-style-image

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| URL                  | 图像的路径                                |
| none                 | 默认。无图形显示                          |

### list-style

| 示例                 | 描述                                      |
|----------------------|-------------------------------------------|
| list-style: circle inside; | 设置列表项标记为圆形并放置在文本内 |
| list-style: url () inside;  | 使用图片作为列表符号并放置在文本内 |
| list-style: none;          | 去掉列表符号                        |

## 浮动

### float

| 属性值               | 描述                                      |
|----------------------|-------------------------------------------|
| left                 | 元素向左浮动                              |
| right                | 元素向右浮动                              |
| none                 | 默认值。元素不浮动                        |

### 分类

| 类型               | 描述                                      |
|--------------------|-------------------------------------------|
| 块状元素          | div, p, h3, ol, li, ul, dl, dt, dd      |
| 行内元素          | em, i, b, strong, a, sup, sub, span, del |

# CSS 选择器

##### 常见选择器

    一、CSS+CSS3 选择器
    类选择器： .name{}
    ID选择器： #id{}
    元素选择器： div{}
    通配符选择器： *{}
    后代选择器： div p{}
    子选择器： div>p{} 和后代不一样的是，只筛选div下所有第一层p标签
    兄弟选择器： div+p{} 筛选div后面一个p元素
    交集选择器: div,p,.name{} 选择的元素共享一个样式
    
    二、属性选择器
    属性选择器： a[target=_blank] 筛选所有a标签中属性target是_blank的
    属性包含选择器： div[title~=name] 筛选div属性title中包裹带有name的
    属性开头选择器： img[src^=‘https’] 筛选img属性src以htttps开头的所有img标签
    属性结尾选择器： img[src$=’.png’] 筛选img属性src以 .png 结尾的img标签
    定义属性选择器时的括号 *[target] {color:red;}  包含标题（target）的所有元素变为红色 
    span[class='test']    这样写是：匹配所有带有class类名test的span标签
    span[class *='test'] 这样写是：匹配所有包含了test字符串的class类名的span标签
    span[class]             这样写是：匹配所有带有class属性的span标签
    [class='all']              这样写是：匹配页面上所有带有class='all'的标签
    [class *='as']           这样写是：匹配页面上所有class类且类名带有as字符串的类的标签
    
    三、伪类选择器
    焦点伪类： :focus
    悬浮伪类： :hover
    前置伪类：p ::after 往p元素前面追加内容
    后置伪类：p ::before 往p元素后面追加内容
    光棍伪类：p :empty 选择没有子元素的p标签
    取反伪类：div: not(p) 选择div下所有不是p标签的元素
    首个选择器： div p:first-of-type 或:first-child 选择div下面第一个p标签
    末尾选择器： ul li:last-child 或 last-of-type 选择ul下最后一个li
    正序筛选伪类： :nth-child(2n) 正序第一个开始自由筛选第2的倍数（2、4、6、8）个元素
    倒序筛选伪类： :nth-last-child(2) 倒序最末尾开始自由筛选第 2 个元素
    注意点 nth-child(2) 和 nth-of-type(2) 区别：
    p:nth-child(2) 找位置是2的p元素，如果位置2不是p元素不生效
    p:nth-of-type(2) 找下面p元素中排在第二的，及时前面有很多其他元素，类似兄弟选择

##### 伪对象选择符

    1）::after :选择器在被选元素的内容后面插入内容
    2）::before:伪元素在元素内容之前添加新内容。
    3）::first-letter:定义对象内第一个字符的样式。
    4）::first-line:定义对象内第一行的样式。
    5）::selection:(c3)定义用户鼠标已选择内容的样式（background color）
    6) ::-webkit-scrollbar { display: none } 去除滚动条
    
    content属性与:before及:after伪元素配合使用，来插入生成内容。
    
    默认地，这往往是行内内容，不过该内容创建的框类型可以用属性 display 控制。
      属性值：
        none	设置Content，如果指定成Nothing
        normal	设置content，如果指定的话，正常，默认是"none"（该是nothing）
        counter	设定计数器内容
        attr(attribute)	设置Content作为选择器的属性之一。
        string	设置Content到你指定的文本
        open-quote	设置Content是开口引号
        close-quote	设置Content是闭合引号
        no-open-quote	如果指定，移除内容的开始引号
        no-close-quote	如果指定，移除内容的闭合引号
        url(url)	设置某种媒体（图像，声音，视频等内容）

# 表单

##### 表单标签

    form标签：用于为用户输入创建 HTML 表单，表单用于向服务器传输数据（<form ></form>）。display:block
    
    name 属性：规定表单的名称，form元素的name属性提供了一种在脚本中引用表单的方法
    action属性：规定当提交表单时，向何处发送表单数据（返回用户页面）。
    method属性：规定如何发送表单数据（表单数据发送到 action 属性所规定的页面，共有两种方法：POST 方法和 GET 方法。）
                  浏览器使用method属性设置的方法将表单中的数据传送给服务器进行处理。

##### 表单控件: input

    <input>
    属性：
    type = '控件类型'
    name：属性标识表单域的名称(name 属性用于对提交到服务器后的表单数据进行标识)；
    Value：属性定义表单域的默认值，其他属性根据type的不同而有所变化。
    maxlength：控制最多输入的字符数，
    Size：控制框的宽度（以字符为单位）
    说明：
    value属性：在checkbox,radio, hidden的标签上表示定义与输入相关联的值  
    
    disabled属性：规定应该禁用input元素。
    disabled = ”disabled”
    
    checked属性：规定在页面加载时应该被预先选定的input元素(默认被选中)。     
       checked=“checked”
    
    1）文本输入框 <input type="text" />
            type属性： 规定 input 元素的类型；。
            value属性：为 input 元素设定值；
            name属性：规定 input 元素的名称。
                name 属性用于对提交到服务器后的表单数据进行标识，或者在客户端通过 JavaScript 引用表单数据，
                只有设置了name属性的表单元素才能在提交表单时传递它们的值。
            placeholder属性：规定帮助用户填写输入字段的提示
            maxlength属性：规定输入字段中的字符的最大长度
            size属性：定义输入字段显的宽度（扩展）
    2)密码框
    	<input type="password" />
    3)提交按钮
    	<input type="submit" value="按钮内容" />
    4)重置按钮
    	<input type="reset" value="按钮内容" />
    5)空按钮
    	<input type="button" value="按钮内容" />
    	value属性在type= "button ", "reset”, "submit " 的标签上，表示定义按钮上的显示的文本
    
    button和submit的区别：
    submit是提交按钮起到提交信息的作用，button只是一个按钮；

##### 表单控件（元素）：input/非 input

    1) fieldset 表单字段集,分组（块状display: block;非input）
       可将表单内的相关元素分组,会在相关表单元素周围绘制边框,fieldset元素可以嵌套，在其内部可以在设置多个fieldset对象。
    
    2) legend 字段集标题，分组标题（块状display: block；非input ）
       legend元素为fieldset元素定义标题，legend元素必须是fieldset内的第一个元素
    
    3）radio 定义单选框/单选按钮(display:inline-block)
       <input type="radio" name="ral" value="" />
    
    4）checkbox 定义复选框
       <input type="checkbox" name="like" value="" />
    
    3) hidden 定义隐藏输入字段。
       <input type= "hidden" name= "country" value="Norway" />隐藏字段对于用户是不可见的，
       隐藏字段通常会存储一个默认值，它们的值也可以由 JavaScript 进行修改。
    
    6）file 文件框
      <input type= "file" name="like" value="" />定义输入字段和 "浏览"按钮，供文件上传。
    
    
    4) label 提示信息标签(display:inline；非input)
       <label for="绑定控件id名"></label>
    此标签为input元素定义标注（标记）；此标签的for属性可把label绑定到另外一个元素上，
    将for属性设置为与该控件的id属性值相同。
    写法：
    （1） <label for="czm">姓名:</label>
         <input type="text" name="name" id="czm" />
    
    （2）<label for="czm"> 姓名: <input type="text" name="name" id="czm" /></label>
    
    5) select 菜单列表 下拉列表(display:inline-block;非input)
        size 属性：规定下拉列表中可见选项的数目，如果size属性的值大于1，但是小于列表中选项的总数目，
        浏览器会显示出滚动条，表示可以查看更多选项。
        <select  name="name" id="czm">
           <option value="" name=""></option>
        </select>
    
    6) option 标签定义下拉列表中的一个选项（一个条目;display:block;非input）
        浏览器将option标签中的内容作为select标签的菜单或是滚动列表中的一个元素显示。
         属性：
           value：定义送往服务器的选项值。
           selected：规定选项(在首次显示在列表中时)表现为选中状态。
           label：下拉列表中会显示出所规定的更短版本。
           
    7) optgroup 标签定义选项组。(display:block;非input)
         optgroup元素用于组合option选项。当使用一个长的选项列表时，对相关的选项进行组合会使处理更加容易。
          label：为选项组规定描述-标题-不能被选中。
    
    
    11）textarea 多行文本框（文本域）(display:inline-block;非input)
         <textarea rows="10" cols="30"></textarea>标签定义一个多行的文本输入控件。
       cols：规定文本区域内可见的宽度
       rows ：规定文本区域内可见的行数。
    
    12）image 图像域提交按钮
       <input type="image" src="submit.gif" alt="Submit" />定义图像形式的提交按钮。
       必须把src 属性和 alt 属性与 <input type="image"> 结合使用。
    
    
    13）button标签定义一个按钮  display:inline-block 
        <button type=""></button>
       属性：
        type：规定按钮的类型。
        属性值：button  reset submit
        说明：要为button元素规定type属性，不同的浏览器对button元素的type属性使用不同的默任值； 

##### HTML5 新增表单属性

    placeholder:文本框处于未输入状态时文本框中显示的输入提示。
         
    required:检测输入框是否为空，如果为空，则不允许提交（required="required"）。
        
    autofocus:规定在页面加载时,输入域自动地获得焦点,一个页面只能有一个（autofocus="autofocus"）。
         
    novalidate:规定在提交表单时不应该验证form或input域。即使form表单中的input添加了required，也将不进行验证（novalidate="novalidate"）;
    
    multiple:规定输入域中可选择多个值，每个值之间用逗号分开；如果要获取其中的值在用split获取（multiple="multiple"）；
       
    autocomplete:规定form或input域应该拥有自动完成功能。     
             on：默认；规定启用自动完成功能。
             off：规定禁用自动完成功能。
             
    min、max、step:为包含数字或日期的input类型规定限定（约束）
             max规定输入域所允许的最大值。
             min规定输入域所允许的最小值。
             step为输入域规定合法的数字间隔（如果 step="3"，则合法的数是 -3,0,3,6 等）。
    
    form:规定输入域所属的一个或多个表单，属性值必须引用所属表单的id，此属性适用于所有<input>标签的类型；
    
    pattern:规定用于验证input域的模式（pattern是正则表达式）,在提交时会检查其内容是否符合给定格式。
              
    list:list属性与datalist元素配合使用，用来规定输入域的选项列表，list的属性值写datalist的id值。

##### HTML5 多媒体标签

    1、video：定义视频，比如电影片段或其它视频流
    语法：
    <video src="movie.ogg">您的浏览器不支持video标签</video>
    注：可以在开始标签和结束标签之间放置文本内容，这样老的浏览器就可以显示出不支持该标签的信息。
      
    <video> 元素支持三种视频格式：MP4、WebM、Ogg。
    
    2 、audio：定义音频，比如音乐或其它音频流
    语法：
    <audio src="someaudio.wav"> 您的浏览器不支持 audio 标签</audio>
    注：可以在开始标签和结束标签之间放置文本内容，这样老的浏览器就可以显示出不支持该标签的信息
        
     <audio> 元素支持的3种文件格式：MP3、Wav、Ogg。
        
    属性：
      controls属性：如果出现该属性，则向用户显示控件，比如播放按钮。
      autoplay属性：如果出现该属性，则视频在就绪后马上播放。
      muted属性：静音属性。
      loop属性：重复播放属性。
      poster属性：规定视频正在下载时显示的图像，直到用户点击播放按钮。
      src：要播放视频或者音频的路径
    
        
    3、source：此标签为媒介元素（比如video和audio）定义媒介资源。此标签允许规定可替换的视频/音频文件供浏览器根据它对媒体类型或者编解码器的支持进行选择。
    属性：
         src：规定媒体文件的路径
         type：规定媒体资源的类型
      			用于视频：video/ogg   video/mp4     video/webm
      			用于音频：audio/ogg   audio/mp3     audio/wav
       
         <audio controls>
               <!--哪个视频在上面先识别哪个视频-->
               <source src="horse.ogg" type="audio/ogg">
               <source src="horse.mp3" type="audio/mpeg"> 
              Your browser does not support the audio element.        
         </audio>
    
     说明：
         HTML5的多媒体标签的出现意味着富媒体的发展以及支持不使用插件的情况下即可操作媒体文件，极大地提升了用户体验 。

##### 表单 css 属性 (resize、outline)

    resize: 属性规定是否可由用户调整元素的大小;
      属性值：
      none	      用户无法调整元素的尺寸。
      both	      用户可调整元素的高度和宽度(默认值)。
      horizontal  用户可调整元素的宽度。
      vertical	  用户可调整元素的高度。
      
    outline：（轮廓）是绘制于元素周围的一条线，位于边框边缘的外围，可起到突出元素的作用，轮廓线不会占据空间，也不一定是矩形。
      outline-width：规定边框宽度
     outline-style：规定边框样式
     outline-color：规定边框颜色
     outline:width style(solid dashed dotted) color简写
     说明：
     border跟outline的区别：
       border可应用于几乎所有有形的html元素，而outline是针对链接、表单控件和ImageMap等元素设计
       border占据空间，outline不占据空间
     cursor 属性规定要显示的光标的类型（形状）
      属性值：
        url            需使用的自定义光标的 URL。
        default	默认光标（通常是一个箭头）
        pointer	光标呈现为指示链接的指针（一只手）
        auto     	默认。浏览器设置的光标。
        crosshair	光标呈现为十字线。
        move	        此光标指示某对象可被移动。
        e-resize	此光标指示矩形框的边缘可被向右（东）移动。
        ne-resize	此光标指示矩形框的边缘可被向上及向右移动（北/东）。
        nw-resize	此光标指示矩形框的边缘可被向上及向左移动（北/西）。
        n-resize	此光标指示矩形框的边缘可被向上（北）移动。
        se-resize	此光标指示矩形框的边缘可被向下及向右移动（南/东）。
        sw-resize	此光标指示矩形框的边缘可被向下及向左移动（南/西）。
        s-resize	此光标指示矩形框的边缘可被向下移动（南）。
        w-resize	此光标指示矩形框的边缘可被向左移动（西）。
        text	此光标指示文本。
        wait	此光标指示程序正忙（通常是一只表或沙漏）。
        help	此光标指示可用的帮助（通常是一个问号或一个气球）。
        
    ie低版本浏览器设置鼠标指针形状为手型
      cursor：hand
    
    iframe：会创建包含另外一个文档的内联框架
       可以把需要的文本放置在<iframe>和</iframe>之间，这样就可以应对无法理解iframe的浏览器；
       属性：src：URL规定在iframe中显示的文档的URL。
            scrolling：规定是否在 iframe 中显示滚动条。
            	yes:有滚动条
            	no：不显示滚动条
            frameborder：规定iframe是否显示边框
                0：不显示
                1：显示 

# 图像热点链接 map

    指定图片某块区域加超链接 ：使用map标签可以给指定图片某块区域加超链接
    使用方法：
    例：
     <img src="../imgs/1.jpg" alt="" usemap="#map1" />
        <map name="map1" id="map1">
          <area
            shape="rect"
            coords="500px,481px,670px,662px"
            href="./test.html"
            alt=""
          />
          <area shape="circ" coords="774px,582px,86px" href="./test.html" alt="" />
        </map>
    
    1)在html文件中插入一个图片
      <img src=”../img/1.jpg” usemap="">
      属性：
       usemap:将图像定义为客户端图像映射
      
    2)在html文档中插入一个map标签
      A. map标签：定义客户端的图像映射，图像映射是带有可点击区域的图像
      B. 为map标签设置id属性and name属性，属性值相同
      
    3)为img标签加上usemap属性，属性值为map标签的id/name 
        语法：<img src="1.jpg" usemap="#id/name">
    说明：
        img中的usemap属性可引用map中的id或name属性（由浏览器决定）所以需要添加id和name两个属性
    
    4)在map标签内嵌套一个或者多个area标签来实现给指定区域加超链接
       area标签：定义图像映射内部区域area标签始终嵌套在map标签内部
       语法：
       <area shape="" coords="" target="" href="" alt="">
       属性：
         shape:定义区域形状
           属性值：rect-正方形
                  circ-圆形
                  poly-多边形
         coords：定义可点击区域的坐标(xpx,ypx,npx)
         alt：定义此区域的替换文本
         target：设置超链接的打开方式
         
    矩形：shape="rectangle、rect"，coords="x1,y1,x2,y2"
         第一个坐标是矩形的一个角的顶点坐标，另一对坐标是对角的顶点坐标，"0,0" 是图像左上角的坐标。
    
    圆形：shape="circle"，coords="x,y,z"
         x 和 y 定义了圆心的位置（"0,0" 是图像左上角的坐标），z 是以像素为单位的圆形半径。
    
    多边形：shape="poly"，coords="x1,y1,x2,y2,x3,y3,..."
         每一对 "x,y" 坐标都定义了多边形的一个顶点（"0,0" 是图像左上角的坐标）。定义三角形至少需要三组坐标；高纬多边形则需要更多数量的顶点。
         多边形会自动封闭，因此在列表的结尾不需要重复第一个坐标来闭合整个区域。
    
    说明：
    (1)如果某个 area 标签中的坐标和其他区域发生了重叠，会优先采用最先出现的 area 标签;
    (2)浏览器会忽略超过图像边界范围之外的坐标。

# BFC 元素

BFC 即 Block Formatting Contexts (块级格式化上下文)，是 W3C CSS2.1 规范中的一个概念。

它是页面中的一块渲染区域，并且有一套渲染规则，它决定了其子元素将如何定位，以及和其他元素的关系和相互作用。 CSS2.1 中只有 BFC 和 IFC, CSS3 中还增加了 GFC 和 FFC。不同类型的 Box，会参与不同的 Formatting Context；

•block-level box 参与 block fomatting context；

•inline-level box 参与 inline formatting context；

•grid-level box 参与 grid formatting context；

•flex-level box 参与 flex formatting context；
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
##### BFC 布局规则

    一、内部的Box会在垂直方向，一个接一个地放置。
    二、Box垂直方向的距离由margin决定。属于同一个BFC的两个相邻Box的margin会发生重叠（按照最大margin值设置）
    三、每个元素的margin box的左边，与包含块border box的左边相接触
    四、BFC的区域不会与float box重叠。
    五、BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素。
    六、计算BFC的高度时，浮动元素也参与计算

##### 哪些元素或属性能触发 BFC

    根元素(<html>)
    浮动元素（float不是none）
    overflow 值不为visible的块元素
    定位元素（元素的position为absolute或fixed）
    行内块元素（元素的display为 inline-block）
    表格单元格（元素的display为 table-cell(td th)，HTML表格单元格默认为该值）
    表格标题（元素的display 为 table-caption(caption)，HTML表格标题默认为该值）
    表格其他元素（元素的 display为 table、table-row(tr)、 table-row-group(tbody)、table-header-group(thead)、table-footer-group(tfoot)或 inline-table
    display 值为flow-root、flex的元素
    contain 值为layout、content或paint的元素
    弹性元素（display为flex或inline-flex元素的直接子元素）
    网格元素（display为grid或inline-grid元素的直接子元素）
    多列容器（元素的column-count或column-width不为auto，包括column-count为1）
    column-span为all的元素始终会创建一个新的BFC，即使该元素没有包裹在一个多列容器中（标准变更，Chrome bug）。

# CSS3 属性

##### 盒子圆角

    border-radius:设置盒子圆角效果；
        border-radius:val; 四个角的圆角是一样的
        border-radius:val1 val2;左上角/右下角  右上角/左下角 
        border-radius:val1 val2 val3;左上角 右上角/左下角 右下角
        border-radius:va11 val2 val3 val4;左上 右上 右下 左下
    border-radius:1~4水平圆角半径/1~4垂直圆角半径；
    
    分别设置某个角的圆角效果：
        border-top-left-radius: 2em 0.5em;
        border-top-right-radius: 1em 3em;
        border-bottom-right-radius: 4em 0.5em;
        border-bottom-left-radius: 1em;
     说明：
        当分开设置元素各个顶角的水平和垂直半径圆角效果时，不需要“/”加上反而是一种错误的写法
        
    取消圆角效果：border-radius:0; 

##### 盒子阴影

    box-shadow：设置盒子阴影，设置多个阴影时，用逗号隔开；
    属性值(依次往后)：
        h-shadow:必需的。水平阴影的位置。允许负值
        v-shadow:必需的。垂直阴影的位置。允许负值
        blur:可选。模糊距离
        spread:可选。阴影的大小
        color:可选。阴影的颜色。在CSS颜色值寻找颜色值的完整列表
        inset:可选。从外层的阴影（开始时）改变为内侧阴影；
        默认是外阴影   
        外阴影：
        x + 右  -左
        y + 下  -上
        内阴影：
        x + 左  -右
        y + 上  -下

##### transform2D 功能函数属性

    1. translate(x,y) ：元素从其当前位置，根据给定的 x 坐标和 y 坐标位置参数进行移动，如果第二个参数未提供，则默认为0；
       translateX(n)：定义 2D 转换，沿着 X 轴移动元素。 +  右  - 左 
       translateY(n)：定义 2D 转换，沿着 Y 轴移动元素。  + 下   - 上
       说明： 单位为%，参照的自身的大小
     
    2. rotate(n deg)：定义2D旋转，在参数中规定角度;
          正值+： 是顺时针旋转       
          负值-： 为逆时针旋转
    注意：rotate和translate同时使用，当书写顺序不同时，会影响显示效果
    
    3. scale(number,number)：指定对象的2D缩放，第一个参数对应X轴，第二个参数对应Y轴，如果第二个参数未提供，则默认取第一个参数的值
       scaleX(number)：指定对象X轴的（水平方向）缩放
       scaleY(number)：指定对象Y轴的（垂直方向）缩放
    	0： 缩小不可见   <1: 缩小    =1: 大小不变
        >1: 放大       负值：翻转 再放大或者缩小
        
    4. skew(angle ,angle)：指定对象skew transformation（斜切扭曲）, 第一个参数对应X轴，第二个参数对应Y轴。
                           如果第二个参数未提供，则默认值为0
        skewX(angle)：指定对象X轴的（水平方向）扭曲
        skewY(angle)：指定对象Y轴的（垂直方向）扭曲
    注意：rotate和skew同时使用，当书写顺序不同时，会影响显示效果
    
    5. matrix(n,n,n,n,n,n) 函数
       matrix() 方法把所有 2D 转换方法组合在一起。
       matrix() 方法需要六个参数，包含数学函数，允许：旋转、缩放、移动以及倾斜元素。

##### 变形原点

    transform-origin: x-axis  y-axis  z-axis；属性允许改变被转换元素原点的位置，2D转换元素能够改变元素 x 和 y 轴,
                                              3D转换元素还能改变其Z轴
    说明：
    该属性只有在设置了transform属性的时候起作用；
    x：left center right/length/%
    y：top center bottom/length/%
    z：length

##### 过渡属性 transition

    1. transition-property：规定设置过渡效果的CSS属性的名称
       属性值：
         none：没有属性会获得过渡效果
         all:所有属性都将获得过渡效果
         property：定义应用过渡效果的css属性名称列表，列表以逗号分隔
       
    2. transition-duration : 规定完成过渡效果需要花费的时间（以秒或毫秒计）;其默认值是0，也就是变换时是即时的；
    
    3. transition-timing-function: 规定过渡效果的速度曲线 （https://cubic-bezier.com/）
        属性值：
        ease	规定慢速开始，然后变快，然后慢速结束的过渡效果（cubic-bezier(0.25,0.1,0.25,1)，默认值。
        linear	规定以相同速度开始至结束的过渡效果（等于 cubic-bezier(0,0,1,1)）。
        ease-in	规定以慢速开始的过渡效果（等于 cubic-bezier(0.42,0,1,1)）。
        ease-out	规定以慢速结束的过渡效果（等于 cubic-bezier(0,0,0.58,1)）。
        ease-in-out	规定以慢速开始和结束的过渡效果（等于 cubic-bezier(0.42,0,0.58,1)）。
        cubic-bezier(n,n,n,n)	在 cubic-bezier 函数中定义自己的值。可能的值是 0 至 1 之间的数值。
        http://cubic-bezier.com/
    
    4. transition-delay：定义在过渡效果开始之前需要等待的时间，以s或ms计，默认值为0。作用于所有元素，包括:before和:after伪元素。
    
    5. 简写属性
       transition: property duration timing-function delay; 设置多个属性的过渡效果时，中间用逗号分隔；
    
    注意：transition-delay与 transition-duration的值都是时间，所以要区分它们在连写中的位置，一般浏览器会根据先后顺序决定，
    第一个时间为 transition-duration 第二个为transition-delay。
    
    实现过渡效果：
    （1）指定要添加效果的CSS属性;
    （2）指定效果的持续时间；
    注意：如果时长未规定，则不会有过渡效果，因为默认值是 0。CSS 属性改变的典型事件是鼠标指针位于元素上时.
    
    在转换概念当中：是没有display这么一说的，通过改变元素的透明度去实现从无到有；

##### 线性渐变

    语法：
    background-image:linear-gradient(direction, color-stop1, color-stop2, ...);
    
    说明：
    direction：定义渐变的角度方向。
        angle:从0deg到360deg，默认为180deg。
      to side-or-corner:由两个关键字组成,第一个为指定水平位置(left或 right)，
                        第二个为指定垂直位置（top或bottom），顺序是随意的，每个关键字都是可选的。
      
    color-stop1, color-stop2,...：指定渐变的起止颜色，由颜色值、停止位置（可选，使用百分比指定）组成。
    
    注意：角度是指水平线和渐变线之间的角度，逆时针方向计算。换句话说，0deg 将创建一个从下到上的渐变，90deg 将创建一个从左到右的渐变。
    但是，请注意很多浏览器(Chrome,Safari,fiefox等)的使用了旧的标准，即 0deg将创建一个从左到右的渐变，90deg 将创建一个从下到上的渐变。

##### 重复线性渐变

    语法:
    background-image: repeating-linear-gradient(direction, color-stop1, color-stop2, ...);用于创建重复的线性渐变 "图像"；
    注意：每个颜色后边必须设置%或者px；

##### 径向渐变

    语法：
    A:
    background-image: radial-gradient(position, shape size, start-color, ..., last-color) 需要处理兼容;
    
    B:
    background-image: radial-gradient(shape(图形) size(尺寸) at position(径变起点), start-color, ..., last-color) 高版本不需要处理兼容;
    说明： 
    shape: ellipse (默认)：指定椭圆形的径向渐变。
           circle ：指定圆形的径向渐变
           
    size：定义渐变的大小：
        farthest-corner (默认) : 指定径向渐变的半径长度为从圆心到离圆心最远的角
        farthest-side ：指定径向渐变的半径长度为从圆心到离圆心最远的边
        closest-corner ： 指定径向渐变的半径长度为从圆心到离圆心最近的角
        closest-side ：指定径向渐变的半径长度为从圆心到离圆心最近的边
        
    position：定义渐变的位置
       length：用长度值指定径向渐变圆心的横坐标或纵坐标。可以为负值。
        percentage：用百分比指定径向渐变圆心的横坐标或纵坐标。可以为负值。
        left：设置左边为径向渐变圆心的横坐标值。
        center：设置中间为径向渐变圆心的横坐标值。
        right：设置右边为径向渐变圆心的横坐标值。
        center（默认）：设置中间为径向渐变圆心的纵坐标值。
        top：设置顶部为径向渐变圆心的纵坐标值。
        bottom：设置底部为径向渐变圆心的纵坐标值。
        
    start-color, ..., last-color：用于指定渐变的起止颜色

##### 重复径向渐变

    语法：
    background-image:repeating-radial-gradient(shape size at position, start-color, ..., last-color);
    注意：每个颜色后边必须设置%或者px；

##### 新增背景属性

    background-origin:规定背景图片的定位区域，规定background-position属性相对于什么位置来定位。
    	属性值：
    		padding-box:背景图像相对于内边距框来定位
    		border-box:背景图像相对于边框盒来定位
    		content-box:背景图像相对于内容框来定位     
    		
    background-clip:属性规定背景的绘制区域
    	属性值:
    		border-box:背景被裁剪到边框盒。
    		padding-box:背景被裁剪到内边距框。
    		content-box:背景被裁剪到内容框。    
    
    background-size：规定背景图片的尺寸；
        属性值：
           length:设置背景图像的宽度,高度。第一个值设置宽度，第二个值设置高度,如果只设置一个值，则第二个值会被设置为 "auto"。
           percentage:以父元素的百分比来设置背景图像的宽度和高度。第一个值设置宽度，第二个值设置高度。如果只设置一个值，则第二个值会被设置为 "auto"。
           cover: 会保持图像的纵横比并将图像缩放成将完全覆盖背景定位区域的最小大小。背景图像的某些部分也许无法显示在背景定位区域中。
           contain:会保持图像的纵横比并将图像缩放成将适合背景定位区域的最大大小，背景图像也许无法覆盖背景区域。
     
    简写： 
    background:url() repeat scroll position/size;  
    
    背景新增功能：同一个元素多重背景设置，先写的显示在上面；
    例如A：
       background-image:url(test1.jpg),url(test2.jpg)...;
       background-repeat:no-repeat,no-repeat...; 
       background-attachment:scroll,scroll...; 
       background-position:10px 20px,50px 60px...;
       B：
       background:url(test1.jpg) no-repeat scroll 10px 20px,
                 url(test2.jpg) no-repeat scroll 50px 60px,
                 url(test3.jpg) no-repeat scroll 90px 100px;

# CSS3 动画

##### 关键帧的定义

    语法:@keyframes animation-name {
           keyframes-selector {css-styles;}
          }
        通过@keyframes规则，能够创建动画。创建动画的原理是，将一套CSS样式逐渐变化为另一套样式，在动画过程中，能够多次改变这套CSS样式。
        以百分比来规定改变发生的时间，或者通过关键词 “from” 和 “to”。
    
        @keyframes mymove{
         from{初始状态属性}
         to{结束状态属性}
        }
        或
        @keyframes mymove{
         0%{初始状态属性}
            ...
         50%（中间再可以添加关键帧）
            ...
         100%{结束状态属性}
        }

##### animation 属性

    1. animation-name：检索或设置对象所应用的动画名称，必须与规则@keyframes配合使用；
       
    2. animation-duration：检索或设置对象动画的持续时间（s/ms）
     
    3. animation-timing-function：检索或设置对象动画的过渡类型
        属性值：
        linear：线性过渡。等同于贝塞尔曲线(0.0, 0.0, 1.0, 1.0)
        ease：平滑过渡。等同于贝塞尔曲线(0.25, 0.1, 0.25, 1.0)
        ease-in：由慢到快。等同于贝塞尔曲线(0.42, 0, 1.0, 1.0)
        ease-out：由快到慢。等同于贝塞尔曲线(0, 0, 0.58, 1.0)
        ease-in-out：由慢到快再到慢。等同于贝塞尔曲线(0.42, 0, 0.58, 1.0);
        cubic-bezier(num, num, num, num)：特定的贝塞尔曲线类型，4个数值需在[0, 1]区间内
        
        timing-function的以上属性值，效果上，关键帧之间会插入补间动画，所以动画效果是连贯性的，是线性动画的效果。
        
        steps()函数/step-start/step-end：实现的动画是没有过渡效果的，而是一帧帧的变化；
        语法：
        steps(次数，start/end)
            第一个参数指定了时间函数中的间隔数量（必须是正整数）;
            第二个参数可选，有start和end两个值，指定在每个间隔的起点或是终点发生阶跃变化，默认为 end；
        step-start等同于steps(1,start)，动画分成1步，动画执行时为开始端点的部分为开始；
        step-end等同于steps(1,end)：动画分成1步，动画执行时以结尾端点为开始，默认值为end。
        
    4. animation-delay：检索或设置对象动画延迟的时间(s/ms)
          属性值：+ - 
     
    5. animation-iteration-count：检索或设置对象动画的循环次数（默认执行1次）
        属性值：
          infinite：无限循环     number: 循环的次数
          
    6. animation-direction ：检索或设置对象动画在循环中是否反向运动
         属性值：
          normal：正常方向
          reverse：反方向运行
          alternate：动画先正常运行再反方向运行，并持续交替运行
          alternate-reverse：动画先反运行再正方向运行，并持续交替运行
          
    7. animation-fill-mode：规定对象动画时间之外的状态;
         属性值：
         none：不改变默认行为。
         forwards：当动画完成后，保持最后一个属性值（在最后一个关键帧中定义），固定动画。
         backwards：在animation-delay所指定的一段时间内，在动画显示之前，应用开始属性值（在第一个关键帧中定义）。
         both：向前和向后填充模式都被应用。
    
    8. animation-play-state：检索或设置对象动画的状态
        属性值：
          running:运动 - 默认值
          paused: 暂停
    
    简写：animation 
      (1) 此属性是所有动画属性的简写属性，除了animation-play-state属性 
      (2) 一个动画多个属性值中间空格隔开；想要设置多个动画时，动画之间用逗号分隔；
      (3) 必须定义动画的名称和时长,如果忽略时长,则动画不会执行，因为默认值是 0;

# 3D

##### 实现 3D 场景（css 属性加给父元素）

    transform-style:指定变形元素是怎样在三维空间中呈现。
     属性值：
       flat:值为默认值，表示所有子元素在2D平面呈现
       preserve-3d: 表示所有子元素在3D空间中呈现。
       
      （1）该属性必须与transform属性一同使用
      （2）需要设置在父元素上面，并且高于任何嵌套的变形元素；  
      
    perspective: 定义3D元素距视图的距离，以像素计；
      （1）为父元素定义 perspective 属性时，其子元素会获得透视效果，而不是元素本身。
      属性值： 
        number:元素距离视图的距离，以像素计。
        none:默认值，与0相同。不设置透视。

##### 3D 转换

    1、位移translate:
    translateX (value)：默认是以X(水平方向)移动
    translateY (value)：默认是以Y(垂直方向)移动
    translateZ (value)：设置元素以Z(前后)轴移动，正值向前使元素视觉上变大，负值向后，使元素视觉上变小
    translate3d(x,y,z): 设置x，y，z轴的移动；
    
    3种写法等价：
    transform:translateZ(800px) translateX(30px) translateY(30px);
    transform:translateZ(800px) translate(30px,30px);
    transform:translate3d(30px,30px,800px)
    
    2、旋转rotate：
    rotateX(deg)：定义沿着X轴的3D旋转。 + 屏幕里   – 屏幕外
    rotateY(deg)：定义沿着Y轴的3D旋转。 + 右  - 左
    rotateZ(deg)：设置元素围绕Z轴旋转；
       如果仅从视觉角度上看，rotateZ()函数让元素顺时针或逆时针旋转，并且效果和rotate()效果等同，但它不是在2D平面的旋转;
    
    rotate3d(1,1,0,50deg)
        x：是一个0到１之间的数值，主要用来描述元素围绕X轴旋转的矢量值；
        y：是一个０到１之间的数值，主要用来描述元素围绕Y轴旋转的矢量值；
        z：是一个０到１之间的数值，主要用来描述元素围绕Z轴旋转的矢量值；a：是一个角度值，主要用来指定元素在3D空间旋转的角度，
        如果其值为正值，元素顺时针旋转，反之元素逆时针旋转缩放效果：
      （1）当值为1时，表示旋转，当值为0是表示不旋转；
      （2）当值为小数时，只给一个小数时会当做1，如果多个非0数值，小数就会生效；
    
    3、scale缩放：
    scaleX (number)：默认是X轴(长度)缩放；
    scaleY (number)：默认是Y轴(高度)缩放；
    scaleZ (number):  默认是Z(宽度)缩放；
    scale3d(num1,num2,num3):设置x,y,z轴的缩放；
    注意：
    scaleZ()和scale3d()函数单独使用时没有任何效果，需要配合其它的变形函数一起使用才会有效果，必须写在其他变形函数的后边；
    
    backface-visibility（是否可见）：
    定义元素在不面对屏幕时是否可见（它用于决定当一个元素的背面面向用户的时候是否可见）。
    属性值：
        visible:背面是可见的-默认值
        hidden：背面是不可见的
    transform-origin（旋转点）：
    语法：transform-origin: x-axis y-axis z-axis；
    允许改变被转换元素原点的位置，2D转换元素能够改变元素x和y轴,3D转换元素还能改变其Z轴;
      x:left center right/length/%
      y:top center bottom/length/%
      z:length
    perspective-origin：
    语法：perspective-origin: x-axis y-axis;主要用来决定perspective属性的源点角度,设置观察方向;
      属性值：
      x: left center right/length/%
      y: top center bottom/length/%
    说明：一般设置在父元素上，结合perspective使用；center center

##### 透视的两种实现方式（景深）

     perspective:设置元素的透视效果
     transform:perspective();设置元素的透视效果
              区别： 
                1. perspective是设置给父元素的
                   transform:perspective()设置给当前需要有转换效果的元素上面，跟其他转换函数一起使用时，写在其他函数的前面
                2. perspective：0 none length
                   transform:perspective(length)

##### css3 新增文本属性

    text-shadow：h-shadow v-shadow blur color；
    向文本添加一个或多个阴影，用逗号分隔的阴影列表，每个阴影有两个或三个长度值和一个可选的颜色值进行规定，省略的长度是0。
     属性值：
        h-shadow:水平阴影的位置。允许负值
        v-shadow:必需。垂直阴影的位置。允许负值
        blur:可选。模糊的距离。
        color:可选。阴影的颜色。
        
    word-wrap:属性用来标明是否允许浏览器在单词内进行断句，这是为了防止当一个字符串太长而找不到它的自然断句点时产生溢出现象。
     属性值：
    	normal:只在允许的断字点换行（浏览器保持默认处理）
    	break-word:属性允许长单词或URL地址换行到下一行-会考虑尽量放在一行内，如果不行再换行
    	
    word-break:属性规定自动换行的处理方法
     属性值：
        normal:浏览器默认处理
    	break-all:它断句的方式非常粗暴，它不会尝试把长单词挪到下一行，而是直接进行单词内的断句
    	Keep-all:文本不会换行，只能在空格或连字符处换行
    
    @font-face
    @font-face是CSS3中的一个模块，主要是把自己定义的Web字体嵌入到你的网页中，随着@font-face模块的出现，
    我们在Web的开发中使用字体不怕只能使用Web安全字体（@font-face这个功能早在IE4就支持）
    
    @font-face的语法规则:
        @font-face { 
             font-family: <YourWebFontName>;
             src: <source> [<format>][, []]; 
        }
     .ttf .eot .woff

##### calc () 动态计算方法详解

    calc是英文单词calculate(计算)的缩写，是css3的一个新增的功能，用来指定元素的长度。
    
     calc() 函数用于动态计算长度值。
         ● calc(必须，一个数学表达式，结果将采用运算后的返回值。)
         ● 运算符前后都需要保留一个空格，例如：width: calc(100% - 10px)；
         ● 任何长度值都可以使用calc()函数进行计算；
         ● calc()函数支持 "+", "-", "*", "/" 运算；
         ● calc()函数使用标准的数学运算优先级规则；
    
    语法：
    	.elm {
      		width: calc(expression);
      		width: calc(50% + 2em)
    	}
    	
    兼容：
     .elm {
    	/*Firefox*/
    	width:-moz-calc(expression);
    	/*chrome safari*/
    	width:-webkit-calc(expression);
    	/*Standard */
    	width:calc();
     }
     
    优点：
     calc()最大的好处就是用在流体布局上，可以通过calc()计算得到元素的宽度。
     复杂的数据运算由浏览器去计算。

# 回流和重绘

##### 回流重绘的概念

重绘：是指当 DOM 元素的样式属性（例如颜色、背景）发生改变时，浏览器重新绘制元素的过程，但并不影响元素的几何属性和布局；相比于回流，重绘的性能开销较小。

回流：也叫重排，是指当 DOM 元素的几何属性（例如位置、大小）发生改变时，浏览器重新计算并更新元素的几何属性，并重新构建页面布局树的过程；回流会导致其他元素的几何属性和布局发生变化。回流是一种相对较慢的操作，会消耗大量的 CPU 资源。

回流一定会导致重绘，但是重绘不一定会导致回流。回流相对较慢，会重新计算文档中元素的位置和几何属性。而重绘是根据元素的新样式重新绘制页面，不需要重新计算元素的位置和几何属性。

##### 导致回流的操作

    盒模型属性：width、height、padding、margin、border等。
    定位属性：position、top、left、bottom、right等。
    布局属性：display、float、clear、flex等。
    字体属性：font-size、line-height、text-align等。
    背景属性：background、background-color、background-image等。
    盒子模型属性：box-sizing、border-box、outline等。
    可见性属性：visibility、opacity等。
    修改浏览器窗口大小。
    页面初始加载。
    页面的渲染树发生改变：
      如添加或删除元素等。
    获取元素的一些布局属性：
      如offsetWidth、offsetHeight、clientWidth、clientHeight、getComputedStyle()、scrollIntoView()、scrollTo()、getBoundingClientRect()、scrollIntoViewIfNeeded()等。

##### 导致重绘的操作

    颜色属性：color、background-color、border-color等。
    文字属性：font-weight、font-style、text-decoration等。
    文本属性：text-align、text-transform、line-height等。
    背景属性：background-image、background-position、background-size等。
    盒子模型属性：box-shadow、outline-color、outline-style等。
    渐变属性：linear-gradient、radial-gradient等。
    变形属性：transform、transform-origin等。
    过渡属性：transition、transition-property、transition-duration等。

# 媒体查询

##### 基于 css

    媒体查询可以根据设备显示器的特性（如视口宽度、屏幕比例、设备方向：横向或纵向）为其设定CSS样式。使用媒体查询，可以在不改变页面内容的情况下，为特定的一些输出设备定制显示效果。
    
    语法：
    媒体查询包含一个可选的媒体类型和零个或多个满足CSS3规范的表达式. 
    @media mediatype and|not|only  (media feature) {CSS-Code;}
    
    媒体设备类型：
        all:用于所有设备--默认值
        print:用于打印机和打印预览
        screen:用于电脑屏幕，平板电脑，智能手机等
        speech:应用于屏幕阅读器等发声设备
        tv
        
    媒体属性：
        max-height:定义输出设备中的页面最大可见区域高度。
        max-width:定义输出设备中的页面最大可见区域宽度。
        min-height:定义输出设备中的页面最小可见区域高度。
        min-width:定义输出设备中的页面最小可见区域宽度。
        width:定义输出设备中的页面可见区域宽度。
        height:定义输出设备中的页面可见区域高度。
        orientation:定义输出设备中的页面是横屏还是竖屏。 
            landscape横屏 portrait竖屏
        max-device-height:定义输出设备的屏幕可见的最大高度。
        max-device-width:定义输出设备的屏幕最大可见宽度。
        min-device-width:定义输出设备的屏幕最小可见宽度。
        min-device-height:定义输出设备的屏幕的最小可见高度。
        device-height:定义输出设备的屏幕可见高度。
        device-width:定义输出设备的屏幕可见宽度。
        
     
    操作符not、and、only和逗号(,)可以用来构建复杂的媒体查询
    
    （1）and 关键字用来把多个媒体属性和媒体类型组合成一条媒体查询，只有当每个属性都为真时，结果才为真。   
        @media  all and (min-width: 700px) and (orientation: landscape) { ... }
    在可视区域宽度不小于700像素并在在横屏时有效
    
    （2）逗号： 媒体查询中使用逗号分隔，效果等同于 or 逻辑操作符，使用逗号分隔的媒体查询，任何一个媒体查询返回真，样式就是有效的。逗号分隔的列表中每个查询都是独立的，一个查询中的操作符并不影响其它的媒体查询。
        @media all and (min-width: 700px),handheld and (orientation: landscape) { ... }
    
    （3）not 关键字用来对一条媒体查询的结果进行取反，在媒体查询为假时返回真,在逗号媒体查询列表中 not 仅会否定它应用到的媒体查询上而不影响其它的媒体查询
        例如：
        @media not screen and (color), print and (color)
        等价于：
        @media (not (screen and (color))), print and (color) 
    
    （4）only关键字用来排除不支持css3媒体查询的浏览器。
         对于支持Media Queries的设备来说，存在only关键字，移动设备的 Web 浏览器会忽略only关键字并直接根据后面的表达式应用样式文件。对于不支持Media Queries的设备但能够读取Media Type类型的Web浏览器，遇到only关键字时会忽略这个样式文件
         所以，在使用媒体查询时，only最好不要忽略
    
    css2，css3的版本媒体查询的区别：
        一般认为媒体查询是CSS3的新增内容，实际上CSS2已经存在了，CSS3新增了媒体属性和使用场景(IE8-浏览器不支持)
         在CSS2中，媒体查询只使用于<style>和<link>标签中，以media属性存在media属性用于为不同的媒介类型规定不同的样式，媒体属性是CSS3新增的内容；
        <link rel="stylesheet" href="css/wide.css" media="screen " />
         <link rel="stylesheet" href="css/mobile.css" media="screen and (min-width:320px) and (max-width:640px)" />

基于 js

    window.matchMedia(mediaQueryString)返回一个新的 MediaQueryList 对象，表示指定的媒体查询字符串解析后的结果
    
    function myFunction(x) {
        if (x.matches) { // 媒体查询
            document.body.style.backgroundColor = "yellow";
        } else {
            document.body.style.backgroundColor = "pink";
        }
    }
     
    var x = window.matchMedia("(max-width: 700px)")
    myFunction(x) // 执行时调用的监听函数
    x.addListener(myFunction) // 状态改变时添加监听器

# 移动端布局
##### 视口-viewport
```text

许多智能手机都使用了一个比实际屏幕尺寸大很多的虚拟可视区域 (980px)，主要目的就是让 pc 页面在智能手机端阅读时不会因为实际可视区域变形。

所以你看到的页面还是普通样式，即一个全局缩小后的页面。为了让智能手机能根据媒体查询匹配对应样式，让页面在智能手机中正常显示，特意添加了一个 meta 标签。

这个标签的主要作用就是让智能手机浏览页面时能进行优化，并且可以自定义界面可视区域的尺寸和缩放级别。

语法：

<meta name\="viewport" content\="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"\>

属性值：

width: 可视区域的宽度, 值可为数字或关键词 device-width；

height: 可视区域的高度, 值可为数字或关键词 device-height；

initial-scale: 页面首次被显示时的缩放级别（0-10.0），取值为 1 时页面按实际尺寸显示，无任何缩放

minimum-scale: 设定最小缩小比例（0-10.0），取值为 1 时将禁止用户缩小页面至实际尺寸之下

maximum-scale: 设定最大放大比例（0-10.0），取值为 1 时将禁止用户放大页面至实际尺寸之上

user-scalable: 设定用户是否可以缩放（yes/no）

含义为：宽为手机移动设备默认宽度，初始缩放比例为 1，最大缩放比例为原始像素大小，不允许用户放大或者缩小;
```

##### vh、vw 相关
```text
1vw 等于1/100的视口宽度 （Viewport Width）
1vh 等于1/100的视口高度 （Viewport Height）
vmin — vmin 的值是当前 vw 和 vh 中较小的值
vmax — vw 和 vh 中较大的值
svh 表示地址栏 UI 尚未缩小尺寸时的视口高度
lvh 表示地址栏 UI 缩小尺寸后的视口高度
dvh 表示根据地址栏 UI 是否缩小而使用小的、中间的和大的单位
```
##### 移动端适配
###### rem 基本转换
```text
以750px的屏幕宽度，预计100px（根字体大小 ） = 1rem来计算，计算公式为： 
1rem = 根字体大小 = 当前屏幕宽度 (document.body.clientWidth）/ 750 * 100  px
```

###### 移动端适配
```text
1、媒体查询 + rem
计算rem方法：
      结合媒体查询，随着设备的改变 更改html的font-size的值。
html{font-size:100px}
@media screen and (min-width:321px) and (max-width:375px){  	
       html{font-size:45px} 
}
@media screen and (min-width:376px) and (max-width:414px){ 
       html{font-size:50px}
}
@media screen and (min-width:415px) and (max-width:639px){ 
       html{font-size:55px} 
}
@media screen and (min-width:640px) and (max-width:719px){
       html{font-size:60px}
}

2、弹性布局

3、flxible.js  插件
流程：
（1）引入flxible.js插件
（2）去掉html里面默认的meta标签  <meta name="viewport" content="width=device-width, initial-scale=1.0">
```