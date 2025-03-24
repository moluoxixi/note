---
title: Css和html
description: 一个Css和html笔记
date: 2025-03-05
hidden: false
tags: Css和html
ptags: 
---
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

## 常见选择器

### 一、CSS + CSS3 选择器

| 选择器             | 示例                 | 描述                                |
|--------------------|----------------------|-------------------------------------|
| 类选择器           | `.name {}`           | 选择类名为 name 的元素              |
| ID 选择器           | `#id {}`             | 选择 ID 为 id 的元素                 |
| 元素选择器         | `div {}`             | 选择所有 div 元素                   |
| 通配符选择器       | `* {}`               | 选择所有元素                       |
| 后代选择器         | `div p {}`           | 选择所有 div 内的 p 元素            |
| 子选择器           | `div > p {}`         | 选择 div 下的直接子元素 p          |
| 兄弟选择器         | `div + p {}`         | 选择紧接在 div 后的 p 元素          |
| 交集选择器         | `div, p, .name {}`   | 选择共享样式的元素                  |

### 二、属性选择器

| 选择器                           | 示例                          | 描述                                |
|----------------------------------|-------------------------------|-------------------------------------|
| 属性选择器                       | `a[target=_blank]`           | 选择所有 target 属性为 _blank 的 a 标签 |
| 属性包含选择器                   | `div[title~=name]`           | 选择 title 属性包含 name 的 div 元素 |
| 属性开头选择器                   | `img[src^='https']`          | 选择 src 属性以 https 开头的 img 标签 |
| 属性结尾选择器                   | `img[src$='.png']`           | 选择 src 属性以 .png 结尾的 img 标签 |
| 定义属性选择器                   | `*[target] { color: red; }`  | 所有带有 target 属性的元素变为红色 |
| `span[class='test']`             | 匹配 class 为 test 的 span 标签 |
| `span[class*='test']`            | 匹配 class 中包含 test 的 span 标签 |
| `span[class]`                     | 匹配所有带有 class 属性的 span 标签 |
| `[class='all']`                  | 匹配所有 class 为 all 的元素 |
| `[class*='as']`                  | 匹配所有 class 中带有 as 字符串的元素 |

### 三、伪类选择器

| 伪类选择器                       | 示例                       | 描述                                |
|-----------------------------------|----------------------------|-------------------------------------|
| 焦点伪类                         | `:focus`                   | 选择获得焦点的元素                  |
| 悬浮伪类                         | `:hover`                   | 选择鼠标悬停的元素                  |
| 前置伪类                         | `p::after`                 | 在 p 元素后面追加内容                |
| 后置伪类                         | `p::before`                | 在 p 元素前面追加内容                |
| 光棍伪类                         | `p:empty`                  | 选择没有子元素的 p 标签             |
| 取反伪类                         | `div:not(p)`               | 选择 div 下所有不是 p 标签的元素    |
| 首个选择器                       | `div p:first-of-type`      | 选择 div 下的第一个 p 标签          |
| 末尾选择器                       | `ul li:last-child`         | 选择 ul 下最后一个 li               |
| 正序筛选伪类                     | `:nth-child(2n)`           | 选择正序的第 2 的倍数元素           |
| 倒序筛选伪类                     | `:nth-last-child(2)`       | 选择倒序的第 2 个元素               |

### 注意点

- `nth-child(2)`：找位置为 2 的 p 元素，如果位置 2 不是 p 元素则不生效。
- `nth-of-type(2)`：找排在第二的 p 元素，即使前面有其他元素。

## 伪对象选择符

| 选择符                          | 描述                                        |
|---------------------------------|---------------------------------------------|
| `::after`                       | 在被选元素的内容后面插入内容               |
| `::before`                      | 在元素内容之前添加新内容                   |
| `::first-letter`               | 定义对象内第一个字符的样式                 |
| `::first-line`                 | 定义对象内第一行的样式                     |
| `::selection`                  | 定义用户选择内容的样式（背景颜色）        |
| `::-webkit-scrollbar`          | 去除滚动条                                 |

## 表单

### 表单标签

| 标签         | 描述                                        |
|--------------|---------------------------------------------|
| `<form>`     | 创建 HTML 表单，用于向服务器传输数据      |
| name 属性    | 规定表单的名称                              |
| action 属性  | 提交表单时，向何处发送表单数据            |
| method 属性  | 规定如何发送表单数据（POST 或 GET 方法）  |

### 表单控件: input

| 控件类型            | 示例                                     | 描述                                       |
|---------------------|------------------------------------------|--------------------------------------------|
| 文本输入框          | `<input type="text" />`                 | 规定 input 元素的类型                     |
| 密码框              | `<input type="password" />`              | 输入密码                                  |
| 提交按钮            | `<input type="submit" value="提交" />`  | 提交表单                                  |
| 重置按钮            | `<input type="reset" value="重置" />`   | 重置表单                                  |
| 空按钮              | `<input type="button" value="按钮" />`  | 普通按钮                                  |

### 表单控件（元素）：input/非 input

| 控件类型            | 示例                                     | 描述                                       |
|---------------------|------------------------------------------|--------------------------------------------|
| fieldset            | `<fieldset>`                            | 表单字段集，用于分组                      |
| legend              | `<legend>`                              | 字段集标题，分组标题                      |
| radio               | `<input type="radio" name="ral" />`    | 单选框                                    |
| checkbox            | `<input type="checkbox" name="like" />` | 复选框                                    |
| hidden              | `<input type="hidden" name="country" value="Norway" />` | 隐藏输入字段 |
| file                | `<input type="file" name="file" />`    | 文件上传                                  |
| label               | `<label for="czm">姓名:</label>`       | 提示信息标签                              |
| select              | `<select name="name" id="czm">`        | 下拉列表                                  |
| option              | `<option value="1">选项1</option>`     | 下拉列表中的选项                          |
| optgroup            | `<optgroup label="分组">`               | 选项组                                    |
| textarea            | `<textarea rows="10" cols="30"></textarea>` | 多行文本框                          |
| image               | `<input type="image" src="submit.gif" alt="提交" />` | 图像提交按钮                 |
| button              | `<button type="button">按钮</button>`   | 按钮                                      |

### HTML5 新增表单属性

| 属性             | 描述                                      |
|------------------|-------------------------------------------|
| placeholder       | 文本框的输入提示                         |
| required          | 检测输入框是否为空                       |
| autofocus         | 页面加载时自动获得焦点                   |
| novalidate        | 提交表单时不进行验证                     |
| multiple          | 输入域中可选择多个值                     |
| autocomplete      | 启用或禁用自动完成功能                   |
| min/max/step     | 限制数字或日期的输入                     |
| form              | 规定输入域所属的表单                     |
| pattern           | 验证输入域的模式                         |
| list              | 与 datalist 元素配合使用                  |

## HTML5 多媒体标签

| 标签            | 示例                                          | 描述                                      |
|------------------|-----------------------------------------------|-------------------------------------------|
| `<video>`        | `<video src="movie.ogg">您的浏览器不支持video标签</video>` | 定义视频                                  |
| `<audio>`        | `<audio src="someaudio.wav">您的浏览器不支持audio标签</audio>` | 定义音频                                  |
| `<source>`       | `<source src="horse.ogg" type="audio/ogg">` | 定义媒介资源                             |

## 图像热点链接 map

### 使用方法

1. **插入图片**：
   ```html
   <img src="../imgs/1.jpg" alt="" usemap="#map1" />
   ```

2. **定义 map 标签**：
   ```html
   <map name="map1" id="map1">
       <area shape="rect" coords="500,481,670,662" href="./test.html" alt="" />
       <area shape="circ" coords="774,582,86" href="./test.html" alt="" />
   </map>
   ```

### area 标签属性

| 属性        | 描述                                      |
|-------------|-------------------------------------------|
| shape       | 定义区域形状（rect、circ、poly）        |
| coords      | 定义可点击区域的坐标                    |
| alt         | 定义此区域的替换文本                    |
| target      | 设置超链接的打开方式                    |

### 区域形状示例

- **矩形**：
  ```html
  <area shape="rect" coords="x1,y1,x2,y2" />
  ```

- **圆形**：
  ```html
  <area shape="circle" coords="x,y,radius" />
  ```

- **多边形**：
  ```html
  <area shape="poly" coords="x1,y1,x2,y2,x3,y3" />
  ```
# BFC 元素

## 什么是 BFC

BFC（Block Formatting Context）是 W3C CSS2.1 规范中的一个概念。它是页面中的一块渲染区域，有一套渲染规则，决定了其子元素的定位及与其他元素的关系和相互作用。

### BFC 参与的格式化上下文

- **Block-level box** 参与 Block Formatting Context
- **Inline-level box** 参与 Inline Formatting Context
- **Grid-level box** 参与 Grid Formatting Context
- **Flex-level box** 参与 Flex Formatting Context

### BFC 的特点

```js
// BFC 特性
--> BFC
    块级格式化上下文，内部子元素按独特规则排列：
        - 相邻元素 margin 会重叠，无论方向
        - 计算宽高时，float 元素也会被计算，不会再高度塌陷

// 触发条件
--> 触发条件：
    - 根元素，即 HTML 标签
    - overflow 不为 visible
    - float 不为 none
    - display 为：inline-block, flex, inline-flex, grid, inline-grid, inline-table, table-cell, table-caption
    - position 为 absolute/fixed

// 层叠顺序
--> 层叠顺序：
    z-index 为负 < background < border < 块级元素 < 浮动元素 < 内联元素 < 没有设置 z-index 的定位元素 < z-index 为正

// 选择器优先级
--> 选择器优先级：
    !important > 行内 > id > 类 & 伪类(:) > 元素 & 伪元素(::) > 通配符 *
```

## BFC 布局规则

1. 内部的 Box 在垂直方向一个接一个地放置。
2. Box 垂直方向的距离由 margin 决定。属于同一个 BFC 的两个相邻 Box 的 margin 会重叠（按照最大 margin 值设置）。
3. 每个元素的 margin box 的左边，与包含块 border box 的左边相接触。
4. BFC 的区域不会与 float box 重叠。
5. BFC 是页面上的一个隔离的独立容器，容器里面的子元素不会影响外面的元素。
6. 计算 BFC 的高度时，浮动元素也参与计算。

## 触发 BFC 的元素或属性

| 元素或属性                                     |
|------------------------------------------------|
| 根元素（<html>）                              |
| 浮动元素（float 不是 none）                   |
| overflow 值不为 visible 的块元素              |
| 定位元素（position 为 absolute 或 fixed）     |
| 行内块元素（display 为 inline-block）         |
| 表格单元格（display 为 table-cell）           |
| 表格标题（display 为 table-caption）          |
| 表格其他元素（display 为 table、table-row、table-row-group、table-header-group、table-footer-group 或 inline-table） |
| display 值为 flow-root、flex 的元素           |
| contain 值为 layout、content 或 paint 的元素  |
| 弹性元素（display 为 flex 或 inline-flex 的直接子元素） |
| 网格元素（display 为 grid 或 inline-grid 的直接子元素） |
| 多列容器（column-count 或 column-width 不为 auto，包括 column-count 为 1） |
| column-span 为 all 的元素始终会创建一个新的 BFC |

# CSS3 属性

## 盒子圆角

```css
border-radius: val; /* 四个角的圆角是一样的 */
border-radius: val1 val2; /* 左上角/右下角  右上角/左下角 */
border-radius: val1 val2 val3; /* 左上角 右上角/左下角 右下角 */
border-radius: val1 val2 val3 val4; /* 左上 右上 右下 左下 */
```

- 取消圆角效果：`border-radius: 0;`

## 盒子阴影

```css
box-shadow: h-shadow v-shadow blur spread color inset;
```

- **属性值**：
  - `h-shadow`: 必需的，水平阴影位置，允许负值
  - `v-shadow`: 必需的，垂直阴影位置，允许负值
  - `blur`: 可选，模糊距离
  - `spread`: 可选，阴影大小
  - `color`: 可选，阴影颜色
  - `inset`: 可选，从外层阴影变为内侧阴影

## transform2D 功能函数属性

1. **translate (x, y)**：元素从当前位置移动。
   - `translateX(n)`：沿 X 轴移动元素。
   - `translateY(n)`：沿 Y 轴移动元素。

1. **rotate (n deg)**：定义 2D 旋转，参数中规定角度。

2. **scale (number, number)**：指定对象的 2D 缩放。

3. **skew (angle, angle)**：指定对象的斜切扭曲。

4. **matrix (n, n, n, n, n, n)**：组合所有 2D 转换方法。

## 变形原点

```css
transform-origin: x-axis y-axis z-axis;
```

- **属性值**：
  - `x`: left center right / length / %
  - `y`: top center bottom / length / %
  - `z`: length

## 过渡属性 transition

1. **transition-property**：规定设置过渡效果的 CSS 属性名称。
2. **transition-duration**：规定完成过渡效果需要的时间。
3. **transition-timing-function**：规定过渡效果的速度曲线。
4. **transition-delay**：定义在过渡效果开始前的等待时间。
5. **简写属性**：
   ```css
   transition: property duration timing-function delay;
   ```

## 线性渐变

```css
background-image: linear-gradient(direction, color-stop1, color-stop2, ...);
```

- **说明**：
  - `direction`：定义渐变的角度方向。
  - `color-stop`：指定渐变的起止颜色。

## CSS3 动画

### 关键帧的定义

```css
@keyframes animation-name {
    keyframes-selector { css-styles; }
}
```

- **示例**：
```css
@keyframes mymove {
    from { /* 初始状态属性 */ }
    to { /* 结束状态属性 */ }
}
```

### animation 属性

1. **animation-name**：动画名称。
2. **animation-duration**：动画持续时间。
3. **animation-timing-function**：动画过渡类型。
4. **animation-delay**：动画延迟时间。
5. **animation-iteration-count**：动画循环次数。
6. **animation-direction**：动画是否反向运动。
7. **animation-fill-mode**：动画时间之外的状态。
8. **animation-play-state**：动画状态。

### 3D 属性

- **transform-style**：指定变形元素在三维空间中呈现。
- **perspective**：定义 3D 元素距视图的距离。
# 回流和重绘

## 回流与重绘的概念

- **重绘**：当 DOM 元素的样式属性（如颜色、背景）发生改变时，浏览器重新绘制元素的过程。重绘不影响元素的几何属性和布局，性能开销较小。
  
- **回流**：也称为重排，指当 DOM 元素的几何属性（如位置、大小）发生改变时，浏览器重新计算并更新元素的几何属性，并重新构建页面布局树的过程。回流会导致其他元素的几何属性和布局发生变化，性能开销较大。

> 回流一定会导致重绘，但重绘不一定会导致回流。

## 导致回流的操作

| 操作类型           | 示例属性                                   |
|--------------------|--------------------------------------------|
| 盒模型属性         | width、height、padding、margin、border 等  |
| 定位属性           | position、top、left、bottom、right 等      |
| 布局属性           | display、float、clear、flex 等              |
| 字体属性           | font-size、line-height、text-align 等      |
| 背景属性           | background、background-color、background-image 等 |
| 可见性属性         | visibility、opacity 等                       |
| 浏览器窗口大小变化 | 修改浏览器窗口大小                        |
| 页面初始加载       | 页面加载时                                 |
| 渲染树变化         | 添加或删除元素                             |
| 获取布局属性       | offsetWidth、offsetHeight 等                |

## 导致重绘的操作

| 操作类型           | 示例属性                                   |
|--------------------|--------------------------------------------|
| 颜色属性           | color、background-color、border-color 等    |
| 文字属性           | font-weight、font-style、text-decoration 等 |
| 文本属性           | text-align、text-transform、line-height 等  |
| 背景属性           | background-image、background-position、background-size 等 |
| 盒子模型属性       | box-shadow、outline-color、outline-style 等 |
| 渐变属性           | linear-gradient、radial-gradient 等         |
| 变形属性           | transform、transform-origin 等               |
| 过渡属性           | transition、transition-property、transition-duration 等 |

# 媒体查询

## 基于 CSS 的媒体查询

媒体查询可以根据设备显示器的特性（如视口宽度、屏幕比例、设备方向）为其设定 CSS 样式。

### 语法

```css
@media mediatype and|not|only (media feature) {
    CSS-Code;
}
```

### 媒体设备类型

| 媒体类型   | 描述                                      |
|------------|-------------------------------------------|
| all        | 用于所有设备（默认值）                   |
| print      | 用于打印机和打印预览                     |
| screen     | 用于电脑屏幕、平板电脑、智能手机等       |
| speech     | 应用于屏幕阅读器等发声设备               |
| tv         | 用于电视设备                              |

### 媒体属性

| 媒体属性                | 描述                                          |
|-------------------------|-----------------------------------------------|
| max-height              | 定义页面最大可见区域高度                     |
| max-width               | 定义页面最大可见区域宽度                     |
| min-height              | 定义页面最小可见区域高度                     |
| min-width               | 定义页面最小可见区域宽度                     |
| width                   | 定义页面可见区域宽度                         |
| height                  | 定义页面可见区域高度                         |
| orientation             | 定义页面横屏或竖屏（landscape/portrait）    |
| max-device-height       | 定义设备屏幕可见的最大高度                   |
| max-device-width        | 定义设备屏幕可见的最大宽度                   |
| min-device-width        | 定义设备屏幕可见的最小宽度                   |
| min-device-height       | 定义设备屏幕可见的最小高度                   |
| device-height           | 定义设备屏幕可见高度                         |
| device-width            | 定义设备屏幕可见宽度                         |

### 操作符

1. **and**：将多个媒体属性和媒体类型组合成一条媒体查询。
   ```css
   @media all and (min-width: 700px) and (orientation: landscape) { ... }
   ```

2. **逗号**：媒体查询中使用逗号分隔，效果等同于 or 逻辑操作符。
   ```css
   @media all and (min-width: 700px), handheld and (orientation: landscape) { ... }
   ```

3. **not**：对一条媒体查询的结果进行取反。
   ```css
   @media not screen and (color), print and (color) { ... }
   ```

4. **only**：用于排除不支持 CSS3 媒体查询的浏览器。
   ```css
   @media only screen and (min-width: 700px) { ... }
   ```

### CSS2 与 CSS3 的媒体查询区别

- CSS2 媒体查询只用于 `<style>` 和 `<link>` 标签中，以 media 属性存在。
- CSS3 新增了媒体属性和使用场景。

## 基于 JS 的媒体查询

使用 `window.matchMedia(mediaQueryString)` 返回一个新的 MediaQueryList 对象，表示指定的媒体查询字符串解析后的结果。

### 示例代码

```javascript
function myFunction(x) {
    if (x.matches) { // 媒体查询
        document.body.style.backgroundColor = "yellow";
    } else {
        document.body.style.backgroundColor = "pink";
    }
}

var x = window.matchMedia("(max-width: 700px)");
myFunction(x); // 执行时调用的监听函数
x.addListener(myFunction); // 状态改变时添加监听器
```

# 移动端布局

## 视口（Viewport）

许多智能手机使用一个比实际屏幕尺寸大很多的虚拟可视区域（980px），以便在智能手机端阅读时不会变形。为了让智能手机能根据媒体查询匹配对应样式，特意添加了一个 meta 标签。

### 语法

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
```

### 属性值

- **width**：可视区域的宽度，值可为数字或关键词 device-width；
- **height**：可视区域的高度，值可为数字或关键词 device-height；
- **initial-scale**：页面首次显示时的缩放级别（0-10.0）；
- **minimum-scale**：设定最小缩小比例（0-10.0）；
- **maximum-scale**：设定最大放大比例（0-10.0）；
- **user-scalable**：设定用户是否可以缩放（yes/no）。

## vh、vw 相关

- **1vw**：等于 1/100 的视口宽度（Viewport Width）
- **1vh**：等于 1/100 的视口高度（Viewport Height）
- **vmin**：当前 vw 和 vh 中较小的值
- **vmax**：vw 和 vh 中较大的值
- **svh**：地址栏 UI 尚未缩小尺寸时的视口高度
- **lvh**：地址栏 UI 缩小尺寸后的视口高度
- **dvh**：根据地址栏 UI 是否缩小而使用的单位

## 移动端适配

### rem 基本转换

以 750px 的屏幕宽度，预计 100px（根字体大小）= 1rem 来计算，计算公式为：

\[ 1rem = \frac{\text{当前屏幕宽度 (document. body. clientWidth)}}{750} \times 100 \]

### 移动端适配示例

1. **媒体查询 + rem**
   ```css
   html { font-size: 100px; }
   @media screen and (min-width: 321px) and (max-width: 375px) { 
       html { font-size: 45px; } 
   }
   @media screen and (min-width: 376px) and (max-width: 414px) { 
       html { font-size: 50px; } 
   }
   @media screen and (min-width: 415px) and (max-width: 639px) { 
       html { font-size: 55px; } 
   }
   @media screen and (min-width: 640px) and (max-width: 719px) { 
       html { font-size: 60px; } 
   }
   ```

2. **弹性布局**

3. **flexible. js 插件**
   - 流程：
     1. 引入 `flexible.js` 插件
     2. 去掉 HTML 里面默认的 meta 标签：
     ```html
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     ```

