---
title: Css和html
description: 一个Css和html笔记
date: 2025-03-05
hidden: false
tags: Css和html
ptags: 
---
# 常用布局

## Flex 布局

#### flex 容器属性：

##### flex-direction（子元素排列顺序）

    flex-direction:属性规定灵活项目的排列方向（主轴方向）:
    
    row:默认值,灵活的项目将水平显示。
    row-reverse:与row相同，但是以相反的顺序。
    column:灵活的项目将垂直显示。
    column-reverse:与column相同，但是以相反的顺序。

##### flex-wrap（换行）

    用于设置伸缩项目在主轴上的换行方式:
    
    nowrap:默认值。规定灵活的项目不拆行或不拆列。
    wrap:规定灵活的项目在必要的时候拆行或拆列。
    wrap-reverse:规定灵活的项目在必要的时候拆行或拆列，但是以相反的顺序。

##### flex-flow

    flex-flow属性是flex-direction属性和flex-wrap属性的简写形式，默认值为row nowrap;-简化代码

##### justify-content（主轴对齐方式）

    justify-content：用于设置或检索弹性盒子元素在主轴（横轴）方向上的对齐方式:
    
    flex-start:默认值。项目位于容器的开头。	
    flex-end:项目位于容器的结尾。	
    center:项目位于容器的中心。	
    space-between:项目位于各行之间留有空白的容器内。
    space-around:项目位于各行之前、之间、之后都留有空白的容器内。

##### align-items（侧轴对齐方式）

    align-items:定义flex子项目在flex容器的侧轴（纵轴）方向上的对齐方式:
    
    stretch:默认值。元素被拉伸以适应容器。
    如果指定侧轴大小的属性值为'auto'，则其值会使项目的边距盒的尺寸尽可能接近所在行的尺寸，但同时会遵照'min/max-width/height'属性的限制。
    center:元素位于容器的中心。
    flex-start:元素位于容器的开头。
    flex-end:元素位于容器的结尾。
    baseline:元素位于容器的基线上。

##### align-content（横向排列换行后多行文本 y 轴对齐方式）

    align-content：用于设置多行子元素在容器侧轴上的对齐方式(多行时才有效)；
    
    stretch:默认值。元素被拉伸以适应容器。各行将会伸展以占用剩余的空间。
    如果剩余的空间是负数，该值等效于'flex-start'。在其它情况下，剩余空间被所有行平分，以扩大它们的侧轴尺寸。
    center:元素位于容器的中心。
    flex-start:元素位于容器的开头。
    flex-end:元素位于容器的结尾。
    space-between:元素位于各行之间留有空白的容器内。
    space-around:元素位于各行之前、之间、之后都留有空白的容器内。
    说明：
       align-content在侧轴上执行样式的时候，会把默认的间距给合并。对于单行子元素，该属性不起作用

#### flex 子元素属性：

##### align-self 属性（单个元素侧轴对齐方式）

    align-self：属性定义flex子项单独在侧轴（纵轴）方向上的对齐方式:
    
    注意：align-self 属性可重写灵活容器的 align-items 属性。
    auto:默认值。元素继承了它的父容器的align-items属性。如果没有父容器则为 "stretch"。	
    stretch:元素被拉伸以适应容器。
    center:元素位于容器的中心。
    flex-start:元素位于容器的开头。
    flex-end:元素位于容器的结尾。
    baseline:元素位于容器的基线上。

##### flex-grow 扩展比率

    flex-grow：用于设置或检索弹性盒子项目的扩展比率；      
    
    number:规定项目将相对于其他灵活的项目进行扩展的量。默认值是0。
    即当容器空间大于内部元素空间之和时，剩余部分将根据各元素指定的flex-grow按比例分配，使各子元素增大；默认值为0，表示剩余空间不分配。

##### flex-shrink 收缩比率

    flex-shrink：设置弹性盒的伸缩项目的收缩比率:
    
    number:规定项目将相对于其他灵活的项目进行收缩的量。默认值是1收缩，0为不收缩。
    Flex子元素仅在默认宽度之和大于容器的时候才会发生收缩，其收缩的大小是依据 flex-shrink 的值；默认值为1，表示溢出时等比例缩小；
    
    算法-公式：
    超出空间的像素数：1000-(900+200)=-100px; 
    加权总和：=(第一个子元素的宽度)*(shrink)+（第二个子元素的宽度）*   (shrink)+....; 
        A收缩的像素数：(Awidth*shrink)/加权综合)*超出空间 =收缩的像素数 

##### flex-basis 伸缩基准值

    flex-basis:设置弹性盒伸缩基准值（指定flex-item在主轴上的初始大小）:
    
    number:规定灵活项目的初始长度。
    auto：默认值。长度等于灵活项目的长度。如果该项目未指定长度，则长度将根据内容决定。

##### order 出现顺序

    order：属性设置或检索弹性盒模型对象的子元素出现的順序。
    number：值越小排列越靠前，值越大顺序越靠后 + -

##### flex 属性简写

    （1）flex 属性用于设置弹性盒模型对象的子元素如何分配父元素的空间。
    （2）flex 属性是 flex-grow、flex-shrink 和 flex-basis 属性的简写属性。
    
    auto = 1 1 auto
    none = 0 0 auto
      1  = 1 1 0%

## Grid 布局

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

# 常用属性

##### 通用属性

    1、initial:默认值
    2、unset:未设置（用于样式重置（覆盖浏览器默认样式）-> all:unset）
    3、revert:回归到浏览器的默认样式

##### 边框的属性

    border-width：简写属性为元素的所有边框设置宽度，或者单独地为各边边框设置宽度。
      属性值：
            thin	定义细的边框。
            medium	默认。定义中等的边框。
            thick	定义粗的边框。
            length	允许您自定义边框的宽度。
        
    border-color：设置边框颜色
      属性值：
            color_name	
            hex_number	
            rgb_number	
            transparent	默认值。边框颜色为透明。
    
    border-style：设置边框类型
      属性值：
        none	定义无边框。
        hidden	与 "none" 相同。不过应用于表时除外，对于表，hidden 用于解决边框冲突。
        dotted	定义点状边框。在大多数浏览器中呈现为实线。
        dashed	定义虚线。在大多数浏览器中呈现为实线。
        solid	定义实线。
        double	定义双线。双线的宽度等于 border-width 的值。
        groove	定义 3D 凹槽边框。其效果取决于 border-color 的值。
        ridge	定义 3D 垄状边框。其效果取决于 border-color 的值。
        inset	定义 3D inset 边框。其效果取决于 border-color 的值。
        outset	定义 3D outset 边框。其效果取决于 border-color 的值。
    
    border-width/color/style:A B C D;上  右 下 左
    border-width/color/style:A B C;上 左右 下
    border-width/color/style:A B;上下 左右
    border-width/color/style:A;上下左右
    
    border:边框宽度 边框风格 边框颜色（简写）;
    	例如：border:5px solid #ff0000
    
    可单独设置一方向边框:
        border-bottom:边框宽度 边框风格 边框颜色;底边框
        border-left:边框宽度 边框风格 边框颜色;左边框
        border-right:边框宽度 边框风格 边框颜色;右边框
        border-top:边框宽度 边框风格 边框颜色;上边框
    
    分别设置某一个方向上边框的颜色/类型/宽度:    
        border-top/right/bottom/left-color
        border-top/right/bottom/left-width
        border-top/right/bottom/left-style
    
    width:100% : 子元素的 content 撑满父元素的content，如果子元素还有 padding、border等属性，或者是在父元素上设置了边距和填充，都有可能会造成子元素区域溢出显示;
    width:auto : 是子元素的 content+padding+border+margin 等撑满父元素的 content 区域。
    
    border-image: 图片边框
        border-image-source:路径
        border-image-slice:切割距离（ 上下左右 )
        border-image-repeat:重复方式（ stretch-拉伸 repeat-重复 round-拉伸重复)

##### 背景属性

    1. background-color：属性设置元素的背景颜色。
    属性值：colorname：规定颜色名称为背景
    hex：规定十六进制的背景颜色
    rgb：规定rgb的背景颜色
    transparent：默认，背景颜色为透明
    
    2.background-image：属性为元素设置背景图像。
    属性值：url（）：指向图像路径
    none：默认值，不显示背景图像
    
    背景图片的显示原则：
    1）容器尺寸等于图片尺寸，背景图片正好显示在容器中;
    2）容器尺寸大于图片尺寸，背景图片将默认平铺，直至铺满元素；
    3）容器尺寸小于图片尺寸，只显示元素范围以内的背景图。
    
    网页上有两种图片形式：插入图片、背景图；
    *插入图片：*属于网页内容，也就是结构。
    *背景图：*属于网页的表现，背景图上可以显示文字、插入图片、表格等。
    
    2. background-repeat：设置是否及如何重复背景图像。
    属性值：no-repeat：背景图像仅显示一次，不平铺
    repeat：默认。背景图像将在垂直方向和水平方向重复
    repeat-x：背景图像将在水平方向重复。
    repeat-y：背景图像将在垂直方向重复。
    
    3. background-position：属性设置背景图像的起始位置。 
    属性值：xpos/%/ left right center
    ypos/%/ top bottom center
    第一个值是水平位置，第二个值是垂直位置。
    如果仅规定了一个值，另一个值将是50% / center
    
    4. background-attachment：设置背景图像是否固定或者随着页面的其余部分滚动。
    属性值： scroll:默认值。背景图像会随着页面其余部分的滚动而移动。
    fixed：当页面的其余部分滚动时，背景图像不会移动。
    
    5. background：简写属性，在一个声明中设置所有的背景属性
    background:color image repeat position attachment
    background:image repeat position attachment color
    background:image repeat attachment position color
    background:image;其他的属性值不写，但是有默认值；
    background:color

##### 文本的属性

    1. font-size：可设置字体的尺寸说明：
    	1） 属性值为数值型时，必须给属性值加单位，属性值为0时除外。
    	2）为了减小系统间的字体显示差异，IE Netscape Mozilla的浏览器制作商于1999年召开会议，
           共同确定16px/ppi为标准字体大小默认值,即1em.默认情况下，1em=16px, 0.75em=12px; 
    	3）使用绝对大小关键字
             xx-small =9px
             x-small =11px
             small =13px
             medium =16px
             large =19px
             x-large =23px
             xx-large =27px
    2. color：规定文本的颜色。
        属性值：colorname  hex rgb 
    3. font-family：规定元素的字体系列
        (1)此属性设置几个字体名称作为一种"后备"机制，如果浏览器不支持第一种字体，将尝试下一种字体，都不支持按系统默认字体显示。
        (2) 如果字体系列的名称超过一个字，它必须用引号，如Font Family："宋体","Times New Roman"
        (3) 多个字体系列是用一个逗号分隔指明;
    4. font-weight：设置显示元素的文本中所用的字体加粗
        属性值：bolder 更粗的
               bold 加粗
               normal 常规
               lighter 更细
               100—900 100对应最轻的字体变形
                       900对应最重的字体变形，
                       100-400 一般显示 
                       500常规字体 
                       600-900加粗字体
    5. font-style：设置文本倾斜
         属性值：
              italic   倾斜 
              oblique  更倾斜
              normal   取消倾斜，常规显示     
    6.line-height： 属性设置行间的距离（行高）
         属性值：
           normal	默认。设置合理的行间距。
           number	设置数字，此数字会与当前的字体尺寸相乘来设置行间距(em)。
           length	设置固定的行间距。
               %	基于当前字体尺寸的百分比行间距。
       A:行高指的是文本行的基线间的距离，而基线（Base line），指的是一行字横排时下沿的基础线，基线并不是汉字的下端沿，而是英文字母x的下端沿
       B:行高有一个特性，叫做垂直居中性（文本在行高垂直居中的位置显示）
        说明：
        当单行文本的行高等于容器高时，可实现单行文本在容器中垂直方向居中对齐(重要)；
        当单行文本的行高小于容器高时，可实现单行文本在容器中垂直中齐以上显示；
        当单行文本的行高大于容器高时，可实现单行文本在容器中垂直中齐以下（IE6及以下版本存在浏览器兼容问题）
    6. font:文字属性简写
       font:font-style | font-variant(小体大写字母) | font-weight | font-size / line-height | font-family  
       (1)简写时 , font-size和line-height只能通过斜杠/组成一个值，不能分开写。
    
       (2) 顺序不能改变 ,这种简写法只有在同时指定font-size和font-family属性时才起作用,而且,你没有设定font-weight , font-style , 以及font-varient , 他们会使用缺省值(normal)。
    
      (3)font:font-size/line-height  font-family
      
    7. text-align：设置文本水平对齐方式   
       属性值：
            left	把文本排列到左边。默认值：由浏览器决定。
            right	把文本排列到右边。
            center	把文本排列到中间。
            justify	实现两端对齐文本效果。
            
    8. text-decoration：规定添加到文本的修饰
      属性值：
            none:没有修饰
    	    underline:添加下划线
    	    overline:添加上划线
    	    line-through:添加删除线
    	    
    9. text-indent：属性规定文本块中首行文本的缩进（2em）（属性值可以为负值）
    	属性值： 
    	    length	定义固定的缩进。默认值：0。
               %	定义基于元素宽度的百分比的缩进。 
         
    10. text-transform：设置文本大小写
        属性值：
            none	默认。定义带有小写字母和大写字母的标准的文本。
            capitalize	文本中的每个单词以大写字母开头。
            uppercase	定义仅有大写字母。
            lowercase	定义无大写字母，仅有小写字母。
    
    11. letter-spacing：属性增加或减少字符间的空白（字符间距）。
        属性值：
    	    normal	默认。规定字符间没有额外的空间。
           length	定义字符间的固定空间（允许使用负值）。
    
    12. word-spacing：属性增加或减少单词间的空白（即字间隔）。
        属性值：
        	normal	默认。定义单词间的标准空间。
        	length	定义单词间的固定空间。   

##### 文本溢出 overflow

    overflow：设置溢出容器的内容如何显示（css2）
      属性值：
        visible: 默认值，内容不会被修剪，会呈现在元素框之外；
        hidden:  内容会被修剪，并且其余内容是不可见的；
        scroll:  内容会被修剪，但是浏览器会显示滚动条，以便查看其余的内容;
        auto:    如果内容被修剪，则浏览器会显示滚动条，以便查看其他的内容;
        inherit: 规定应该从父元素继承overflow属性的值。
    
    white-space：设置如何处理元素内的空白
      属性值：    
        normal:   默认值，多余空白会被浏览器忽略只保留一个；
        pre:      空白会被浏览器保留（类似pre标签）；
        pre-wrap: 保留一部分空白符序列，但是正常的进行换行；
        pre-line: 合并空白符序列，但是保留换行符；
        nowrap:   文本不会换行，文本会在同一行上继续，直到遇到<br/>标签为止;
     
    text-overflow：设置单行文本溢出是否显示省略号
      属性值：
        clip：不显示省略号（...），而是简单的裁切;
        ellipsis：当对象内文本溢出时，显示省略标记；
        
    例：设置某段文字显示省略号css代码
      width：     ；        /*强制容器宽度*/
      white-space: nowrap; /*文字在一行显示*/
      overflow: hidden;    /*设置文字溢出*/
      text-overflow: ellipsis;  /*溢出文字显示省略号*/    
    
    例：多行文本省略：
    	display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
      overflow: hidden;
    	text-overflow: ellipsis;
      white-space: nowrap;

##### 列表属性

    list-style-type：设置列表项标记的类型
      属性值：
        none	无标记。
        disc	默认。标记是实心圆。
        circle	标记是空心圆。
        square	标记是实心方块。
        decimal	标记是数字。
        decimal-leading-zero	0开头的数字标记。(01, 02, 03, 等。)
        lower-roman	小写罗马数字(i, ii, iii, iv, v, 等。)
        upper-roman	大写罗马数字(I, II, III, IV, V, 等。)
        lower-alpha	小写英文字母The marker is lower-alpha (a, b, c, d, e, 等。)
        upper-alpha	大写英文字母The marker is upper-alpha (A, B, C, D, E, 等。)
        lower-greek	小写希腊字母(alpha, beta, gamma, 等。)
        lower-latin	小写拉丁字母(a, b, c, d, e, 等。)
        upper-latin	大写拉丁字母(A, B, C, D, E, 等。)
        
    list-style-position：定义列表符号的位置
      属性值：
            inside	列表项目标记放置在文本以内，且环绕文本根据标记对齐。
            outside	默认值。保持标记位于文本的左侧。列表项目标记放置在文本以外，且环绕文本不根据标记对齐。
        
    list-style-image：设置图片作为列表符号；
      属性值：
             URL	图像的路径。
            none	默认。无图形被显示。
            
    list-style：简写属性，在一个声明中设置所有的列表属性。
    例如：list-style:circle inside
         list-style:url() inside
         list-style：none;去掉列表符号

##### 浮动

    float：定义元素在哪个方向浮动
     属性值：
      left	元素向左浮动。
      right	元素向右浮动。
      none	默认值。元素不浮动，并会显示在其在文本中出现的位置。
     说明：
       以往这个属性总应用于图像，使文本围绕在图像周围，不过在CSS中，任何元素都可以浮动。
       浮动元素会生成一个块级框，而不论它本身是何种元素类型。
       浮动会让元素变成块状元素。
     分类
             双标签 单标签：根据有无单独结束标签进行分类
     元素类型
             块状元素  行内元素：根据标签在浏览器中显示的特征
                块状元素：div p h3 ol li ul dl dt dd 
                  A:自占一行
                  B:可以设置宽度和高度
                  C：在没有设置宽度的情况下，宽度与父元素同宽
                行内元素：em i b strong a sup sub span del 
                  A: 可以和其他行内元素在一行内并列显示
                  B：不可以设置宽度和高度，大小根据内容多少而定

##### 属性继承

    层叠性：一个元素可能同时被多个css选择器选中，每个选择器都有一些css规则，这就是层叠。
    
    CSS的处理原则是：
      1）如果多个选择器定义的规则不发生冲突，则元素将应用所有选择器定义的样式。
      2）如果多个选择器定义的规则发生了冲突，则CSS按选择器的特殊性(权重)让元素应用特殊性(权重)高的选择器定义的样式。
      
    继承性：所谓继承，就是父元素的规则也会适用于子元素。比如给body设置为color:Red;那么他内部的元素如果没有其他的规则设置，也都会变成红色。继承得来的规则没有特殊性。
    
    说明：
    CSS的继承贯穿整个CSS设计的始终，每个标记都遵循着CSS继承的概念。可以利用这种巧妙的继承关系，大大缩减代码的编写量，并提高可读性，尤其在页面内容很多且关系复杂的情况下。
    
    不可继承的：display、margin、border、padding、background、height、min-height、max-height、、min-width、max-width、overflow、position、left、right、top、 bottom、z-index、float、clear、table-layout、vertical-align
    
    所有元素可继承：visibility和cursor。
    
    内联元素、块状元素可继承：letter-spacing、word-spacing、line-height、color、font、 font-family、font-size、font-style、font-variant、font-weight、text-decoration、text-transform。
    
    块状元素可继承：text-indent和text-align
    
    列表元素可继承：list-style、list-style-type、list-style-position、list-style-image。
    
    表格元素可继承：border-collapse border-spacing empty-cells

##### display 元素类型转换

    盒子模型可通过display属性来改变默认的显示类型
    display：属性规定元素应该生成的框的类型。
     属性值：
        none	此元素不会被显示，隐藏元素。（或者设置元素高度为0px，文本溢出overflow：hidden）
        block	此元素将显示为块级元素，此元素前后会带有换行符。
        inline	默认。此元素会被显示为内联元素，元素前后没有换行符。
        inline-block 行内块元素。（CSS2.1 新增的值）
        list-item	 此元素会作为列表显示。
        run-in	此元素会根据上下文作为块级元素或内联元素显示。
        table	此元素会作为块级表格来显示（类似 <table>），表格前后带有换行符。
        inline-table 此元素会作为内联表格来显示（类似 <table>），表格前后没有换行符。
        table-row-group	此元素会作为一个或多个行的分组来显示（类似 <tbody>）。
        table-header-group	此元素会作为一个或多个行的分组来显示（类似 <thead>）。
        table-footer-group	此元素会作为一个或多个行的分组来显示（类似 <tfoot>）。
        table-row	此元素会作为一个表格行显示（类似 <tr>）。
        table-column-group	此元素会作为一个或多个列的分组来显示（类似 <colgroup>）。
        table-column  此元素会作为一个单元格列显示（类似 <col>）
        table-cell	此元素会作为一个表格单元格显示（类似 <td>和<th>）
        table-caption 此元素会作为一个表格标题显示（类似 <caption>）

##### filter：滤镜属性

    brightness:亮度变化；
    grayscale:灰度变化；
    blur:模糊变化（如果没有设定值，则默认是0；这个参数可设置css长度值，但不接受百分比值）；
    contrast:对比度变化；

##### vertical-align

    vertical-align： 该属性定义行内元素的基线相对于该元素所在行的基线的垂直对齐
                     应用于行内元素和单元格元素（inline-level and 'table-cell' elements）
     属性值：
        baseline 默认。元素放置在父元素的基线上。
        top	 把元素的顶端与行中最高元素的顶端对齐
        middle	 把此元素放置在父元素的中部。
        bottom	 把元素的顶端与行中最低的元素的顶端对齐
        sub	 垂直对齐文本的下标。
        super	 垂直对齐文本的上标
       	text-top 把元素的顶端与父元素字体的顶端对齐。
       	text-bottom	把元素的底端与父元素字体的底端对齐。
       	%	     使元素的基线对齐到父元素的基线之上的给定百分比，该百分比是line-height属性的百分比。可以是负数。
       	length  使元素的基线对齐到父元素的基线之上的给定长度。可以是负数

##### position 属性：规定元素的定位类型

    static：默认值。没有定位，元素出现在正常的流中。
        元素的位置根据在html中的书写顺序依次排序显示，没有特殊的位置改变
        
        relative：生成相对定位的元素，相对于其正常位置进行定位。
        说明：元素仍然保持其未定位前的形状，它原本在文本流中所占的空间仍保留
        
        fixed: 生成固定定位的元素，相对于浏览器窗口进行定位。
        说明：给元素设置固定定位之后，元素原先在正常文档流中所占的空间会关闭，就好像该元素原来不存在一样
        配合margin（+固定值）使用可以一直显示在某一地点，不随窗口缩放影响
        
        absolute: 生成绝对定位的元素，相对于static定位以外的第一个父元素进行定位
        解释：指绝对定位元素会根据有定位设置（除static定位）的父元素作为参照进行定位；如果父元素没有定位设置，那就继续向上找祖父元素，
        看是否有定位设置，有的话就根据祖父元素定位，没有的话，那就继续向上找…….如果都没有，就根据窗口进行定位。
        
        包含块：绝对定位元素参照的有定位设置的父元素我们称为包含块，包含块是绝对定位的基础，包含块就是为绝对定位元素提供坐标偏移和显示范围的参照物；
        设置某个元素为包含块：给此元素添加relative，fixed，absolute都OK，推荐使用relative，因为不会影响元素在文本流中的显示；
        
        总结元素绝对定位三部曲：
          (1) 先确定绝对定位元素的包含块
          (2) 设置元素绝对定位
          (3) 定位的坐标位置
        
        sticky（css3中新增的属性值）: 粘性定位，该定位基于用户滚动的位置。
        注意：父元素不能有overflow属性；需搭配top等属性；
        说明：元素在浏览器范围内定位时就像 position:relative; 而当页面滚动超出目标区域时，它的定位效果就像 position:fixed，它会固定在目标位置
      
    
    定位需要配合使用的属性：以下属性用于给元素定位设置坐标点的位置；
     left   属性规定元素的左边缘偏移的大小。
     right  属性规定元素的右边缘偏移的大小。
     top    属性规定元素的顶部边缘偏移的大小。
     bottom 属性规定元素的底部边缘偏移的大小。
            属性值：
           auto：  默认值。通过浏览器计算左边缘的位置。
           %：     设置以包含元素的百分比计的左边位置。可使用负值。
           length：使用 px、cm 等单位设置元素的左边位置。可使用负值。 

##### 层叠 z-index

    z-index : 属性设置元素的堆叠顺序，拥有更高堆叠顺序的元素总是会处于堆叠顺序较低的元素的前面。
     属性值：
        auto：默认值。
        number:无单位的整数值，可为负数。
    说明：    
    1）此属性仅仅作用于position属性值为relative或absolute,fixed的对象。
    2）该属性设置一个定位元素沿z轴的位置，z轴定义为垂直延伸到显示区的轴，如果为正数，则离用户更近，为负数则表示离用户更远。

##### 浮动元素父元素高度自适应（高度塌陷）

    当子元素有浮动并且父元素没有高度的情况下父元素高度为0，会称为高度塌陷
    解决方法：
    （1）给父元素添加声明overflow:hidden;(触发一个BFC)
    （2）在浮动元素下方添加空div,并给该元素添加声明
            div{clear:both; height:0; overflow:hidden;}
    （3）万能清除浮动法
       选择符:after{
        content:"";
        display:block;
        clear:both;  
        height:0;
        overflow:hidden;
        visibility:hidden;
       }
    clear: 属性规定元素的哪一侧不允许其他浮动元素。
      属性值：
        left	在左侧不允许浮动元素。
        right	在右侧不允许浮动元素。
        both	在左右两侧均不允许浮动元素。
        none	默认值。允许浮动元素出现在两侧。

  

##### visibility 属性规定元素是否可见

    属性值：
        visible	  默认值。元素是可见的。
        hidden	  元素是不可见的。
        collapse  当在表格元素中使用时，此值可删除一行或一列，但是它不会影响表格的布局。
        被行或列占据的空间会留给其他内容使用。如果此值被用在其他的元素上，会呈现为 "hidden"。
    
    说明：visibility:hidden;和display:none;的区别：
         visibility:hidden;属性会使对象不可见，但该对象在网页所占的空间没有改变，等于留出了一块空白区域，
         而display:none属性会使这个对象彻底消失。
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
