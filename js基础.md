# 执行过程

##### 执行过程

    ● 加载阶段：浏览器或 JavaScript 引擎加载 JavaScript 代码。这可能是通过 <script> 标签加载外部 JavaScript 文件，或者直接执行内联 JavaScript 代码。
    ● 解析阶段：JavaScript 引擎解析 JavaScript 代码，将其转换为抽象语法树（AST）。这个过程中，引擎会检查语法错误。
    ● 编译阶段：JavaScript 引擎将 AST 转换为字节码或直接编译为机器代码。现代的 JavaScript 引擎如 V8 使用即时编译（JIT）技术，可以在运行时将热点代码编译为机器代码，以提高执行效率。
    ● 执行阶段：JavaScript 引擎执行字节码或机器代码。这个过程中，引擎会创建执行上下文，处理变量提升和函数声明，执行代码，处理事件循环和回调函数等。
    ● 垃圾回收：JavaScript 引擎会自动进行垃圾回收，回收不再使用的对象占用的内存。

##### 执行耗时任务

    function renderElements() {
      const container = document.getElementById('container'); // 获取容器元素
    
      for (let i = 0; i < 1000000; i++) {
        const element = document.createElement('div');
        element.textContent = i;
        container.appendChild(element);
      }
    }
    
    // 使用requestIdleCallback来安排渲染函数的执行
    if ('requestIdleCallback' in window) {
      console.log(1111111)
      window.requestIdleCallback(renderElements);
    } else {
      // 如果浏览器不支持requestIdleCallback，可以回退到使用setTimeout
      setTimeout(renderElements, 0);
    }

##### ES5--严格模式

    消除js语法不严谨之处、消除代码运行不安全之处、提高编译器效率、为新版本js做铺垫
    进入严格模式：use strict； 
    将严格模式放在当前作用域顶部，声明之前不允许有任何代码； 
    全局环境下，表示全局都采用严格模式；

# 数据基础结构

##### JavaScript 数据类型

    值类型(基本类型)：
    字符串（String）、数字(Number)、布尔(Boolean)、对空（Null）、未定义（Undefined）、符号（Symbol）、大数据（BigInt）。
    		js小数计算精度问题，是由于IEEE754标准下存储精度64位不能很好的表示一些小数，存在精度丢失问题。	
    
    引用数据类型：
        对象(Object)。
    
    基本数据类型存储在栈中，引用数据类型（对象）存储在堆中，指针放在栈中。

##### JavaScript 类型判断

    1. 使用`typeof`操作符：`typeof`操作符可以返回一个值的类型的字符串表示。例如：
    
    typeof 42; // "number"
    typeof "Hello"; // "string"
    typeof true; // "boolean"
    typeof undefined; // "undefined"
    typeof null; // "object"（这是一个历史遗留问题，实际上null是一个原始值）
    typeof {} // "object"
    typeof [] // "object"
    typeof function() {} // "function"
    
    
    需要注意的是，`typeof`对于数组、对象以及null的判断结果都是"object"，而对于函数的判断结果是"function"。
    
    2. 使用`instanceof`操作符：`instanceof`操作符可以判断一个对象是否属于某个特定的类型。例如：
    
    const arr = [];
    arr instanceof Array; // true
    
    const obj = {};
    obj instanceof Object; // true
    
    const func = function() {};
    func instanceof Function; // true
    
    
    需要注意的是，`instanceof`操作符只能用于判断对象的类型，不能用于判断原始值的类型。
    
    3. 使用`Object.prototype.toString.call()`方法：这是一个通用的方法，可以返回一个值的详细类型信息。例如：
    
    Object.prototype.toString.call(42); // "[object Number]"
    Object.prototype.toString.call("Hello"); // "[object String]"
    Object.prototype.toString.call(true); // "[object Boolean]"
    Object.prototype.toString.call(undefined); // "[object Undefined]"
    Object.prototype.toString.call(null); // "[object Null]"
    Object.prototype.toString.call({}); // "[object Object]"
    Object.prototype.toString.call([]); // "[object Array]"
    Object.prototype.toString.call(function() {}); // "[object Function]"
    
    Object.prototype.toString.call() 方法返回的是一个字符串，其中包含了具体的类型信息。
    
    这些方法可以根据不同的需求来选择使用，通常使用`typeof`操作符和`instanceof`操作符就可以满足大部分的类型判断需求。

##### JavaScript 数据类型转换

    Number()        + 一元加
      将一个string解析成number类型  如果无法解析则返回NaN；
      (Object)转换为数值：任意对象转换成数字的结果都是NaN;
    parseFloat()
      用法：a = parseFloat(a)
      将一个字符串解析出浮点数据(带有小数的数值)；如果没有可解析的部分则返回NaN
    parseInt()
      用法：a = parseInt(a)
      将一个字符串解析出整数部分的数据；如果没有可解析的部分 则返回NaN        
    
    转化为字符串：任意对象转化为字符串都是[object Object]；null NaN undefined true false 转换成字符串类型，都是原样转换；
    当+号被看做是字符连接符时，另外一边不是字符串类型的数据会被自动转换成字符串类型，然后进行连接
    toString()     使用连接符连接空字符串  data + ''
      JS中除了 null 和 undefined 以外 都有toString函数；toString函数操作number类型时可以转换进制数
    var num = 17;
    console.log(num.toString(2));   //转化为二进制
    toFixed():保留几位小数;
    
    转化为布尔值：
    Boolean()        ！！逻辑非；将操作的值转成布尔值，任何对象转换成布尔值都得到ture  

##### 真假值

    false       ：布尔值 false
    undefined   ：未定义的值
    null        ：空值
    0           ：数字 0
    -0          ：负零
    NaN         ：非数字值
    ''          ：空字符串
    
    // 其他值（包括对象、数组、函数等）在转换为布尔值时都会返回 true

##### JavaScript 隐式转换

    null == null; // true
    +0 == -0; // true
    {} == {}; // false

    null == undefined; // true

    NaN == NaN;   // false

    '5' == 5;   // true，将字符串 '5' 转换为数字 5 进行比较

    true == 1;  // true，将布尔值 true 转换为数字 1 进行比较
    false == '123'; // false，将布尔值 false 转换为数字 0 ，将字符串 '123' 转换为数字 123 进行比较

    如果其中一个是对象，另一个是原始类型，将对象通过 ToPrimitive 转换为原始类型，然后进行比较。
      （即如果原始类型为字符串，则对象转换成字符串再比较；如果原始类为布尔值，则将布尔值与对象都转换成数字进行比较；如果原始类为数字，则将对象转换成数字进行比较。）
    {} == 1;  //false
    首先{}先被ToPrimitive转换成字符串"[object Object]"，就相当于直接判断 "[object Object]" == 1，
    字符串与数字的比较中，又要将字符串转换成数字，"[object Object]"转换成数字为 NaN，而NaN 与任何值比较都为 false。

##### 链表与数组的区别

    （1）物理存储结构不同。链表与数组在计算中存储元素采用不同的存储结构，数组是顺序存储结构，链表是链式存储结构；
    （2）内存分配方式不同。数组的存储空间一般采用静态分配，链表的存储空间一般采用动态分配；
    （3）元素的存取方式不同。数组元素为直接存取，链表元素的存取需要遍历链表；
    （4）元素的插入和删除方式不同。数组进行元素插入和删除时，需要移动数组内的元素，链表进行元素插入和删除时无需移动链表内的元素。

##### JavaScript 值传递和引用传递

    es6 以前，js 都是值传递（对于对象来说，传递的是一个对象的引用地址，并非直接引用了上一个对象的内存空间）；
    
    var a = {a:1}   // a 变量记录了内存空间的地址
    var b = a       // 将地址复制了一次
    b = {b:1}       // 改变b并不会改变 a -> {a:1}
    
    es6 以后，基于 es 的导入导出采用了引用传递（符号绑定）。
# JavaScript 对象

## 1\. 内置对象

### BOM&DOM 对象

##### BOM 模型

    window对象是BOM的根对象，其它对象都是window对象的属性；浏览器环境全局对象，表示一个标签页（窗口）；
    在全局作用下，this关键字指向window；所有子对象或子属性都可以省略'window.'；
    var 声明的对象，都是window的子属性；
    function 声明的全局函数，也是window的子属性；

    location.href:用于获得或设置路径值；
    location.hash：用于获得或设置锚点值（url从#开始的部分）；
    location.host：用于获得或设置主机名和端口号；
    location.pathname：用于获得或设置路径名；
    location.port：用于获得或设置端口号；
    location.protocol:用于获得协议；
    location.search：用于获得地址栏中从？开始的部分；
    
    改变地址的锚点值；
    window.onhashchange = function(){}  //捕捉锚点改变

##### DOM 模型

方法

描述

getElementById ()

返回带有指定 ID 的元素。

getElementsByTagName ()

返回包含带有指定标签名称的所有元素的节点列表（集合/节点数组）。

getElementsByClassName ()

返回包含带有指定类名的所有元素的节点列表。

appendChild ()

把新的子节点添加到指定节点。

removeChild ()

删除子节点。

replaceChild ()

替换子节点。

insertBefore ()

在指定的子节点前面插入新的子节点。

createAttribute ()

创建属性节点。

createElement ()

创建元素节点。

createTextNode ()

创建文本节点。

getAttribute ()

返回指定的属性值。

setAttribute ()

把指定属性设置或修改为指定的值。

##### 节点和元素操作

    html文件的根节点为html，获取方式为document.documentElement；
    childNodes：获取所有子节点（包含空文本换行）；类数组对象（不是数组），获取一个元素的所有子节点；元素有序排列，可以通过做引访问；
    children：所有子元素；
    parentNode：获得一个元素节点的父节点；最高级别节点是document；
    parentElement：父元素；
    firstChild：第一个子节点；
    firstElementChild：第一个子元素；
    lastChild：最后一个子节点；
    lastElementChild：最后一个子元素；

    previousSibling：获得上一个兄弟节点；
    previousElementSibling：上一个兄弟元素；
    nextSibling：下一个兄弟节点；
    nextElementSibling：下一个兄弟元素；

    节点名：
    nodeName：返回一个string类型的值，只读属性（不能赋值）；
    
    节点值：
    nodeValue：（节点的内容）
    
    节点类型：
    nodeType：number类型值；

    innerHTML：获得/设置对象内全部的HTML代码，字符串类型
    textContent：获得或设置元素的文本内容，不能识别标签；

##### 属性集合 attribute

通过元素的 attributes 可以获得属性集合；属性集合是一个类数组；

可以通过索引或属性名获得元素对应的属性节点；

    1、a.attributes[index].value;
    2、a.attributes['属性名'].value;
    3、a.getAttributeNode('属性名').value;
    4、a.getAttribute('属性名');     //常用法

    1、a.attributes['属性名'].nodeValue = value;
    2、a.setAttributeNode();
    3、a.setAttributeNode('name','value');   //可以新增，常用法

    1、a.removeAttributeNode();
    2、a.removeAttribute('属性名')；

    操作数组方法增删改
    HTML5新增：classList
    a.classList.add('');
    a.classList.remove('');
    a.classList.replace('','');    //修改
    a.classList.toggle('');        //切换类名

    document.getElementById():通过id选择元素；
    document（node）.getElementsByTagName():通过元素名选择元素集合，集合是类数组对象；
    document.getElementsByName():通过name属性选择元素（一般情况用来选择表单-radio/checkbox--checked属性），选择结果是类数组对象；
    document（node）.getElementsByClassName():通过类名选择元素，结果是类数组对象；
    document.documentElement():选择整个HTML；
    document.querySelector():通过css选择器选择第一个匹配的元素，结果是一个元素节点；
    document.querySelectorAll():通过css选择器选择所有匹配的元素，结果是一个类数组对象；

    创建元素：document.createElement('标签名')；
    在结尾追加节点：parentNode.appendChild(childNode);
    在指定父节点的某个子节点之前插入节点：parentNode.insertBefore(newChild,existingChild);

    1、parentNode.removeChlid(childNode);    //返回被删除的元素
    2、DOM.remove();          //没有返回值
       li.remove();

    parentNode.replaceChild(newNode,oldNode);

##### 自定义属性

    HTML5新增，方便保存和操作数据；
    语法要求：
    所有自定义属性要求 data-  前缀；属性为dataset;
    语法：box.dataset;
         box.dataset.name/id/index;
         box.dataset.name/id/index = '';
    删除：delete box.dataset.name/id/index;    
    
    设置css：
    <style>
        div[data-class]{
            width: 100px;
            height: 100px;
            background: #8959a8;
            border: 1px solid #cccccc;
        }
        div[data-class="my"]{
            box-shadow: 0 0 5px 5px #CCCCCC;
        }
    </style>
    <div id="div1" data-class = "myClass"></div>
    <div id="div2" data-class = "my" ></div> 
    
    1.如何设置
            通过JavaScript内置的setAttribute('data属性名','新内容')即可设置
            通过该数据类型的 dataset 方法设置data值，IE10以上才支持；
                var button = document.queryselector('button')
                button.dataset.data属性名 = '新内容' ; 这里的data属性名是指data-后面的名字
    
    2.如何获取
            通过JavaScript内置的getAttribute('data属性名') 即可获取
            通过该数据类型的 dataset 方法设置data值，IE10以上才支持；
                var button = document.queryselector('button')
                data = button.dataset.data属性名 ; 这里的data属性名是指data-后面的名字

##### DOM 事件

**一般事件**

**事件**

**描述**

**onclick**

鼠标点击事件，多用在某个对象控制的范围内的鼠标点击

**onDblClick**

鼠标双击事件

**onMouseDown**

鼠标上的按钮被按下了

**onMouseUp**

鼠标按下后，松开时激发的事件

**onMouseMove**

鼠标移动时触发的事件

**onContextMenu**

当浏览者按下鼠标右键出现菜单时或者通过键盘的按键触发页面菜单时触发的事件 \[试试在页面中的<body>中加入 onContentMenu="return false"就可禁止使用鼠标右键了\]

**onMouseOver**

当鼠标移动到某对象范围的上方时触发的事件

**onMouseOut**

当鼠标离开某对象范围时触发的事件

**onKeyPress**

当键盘上的某个键被按下并且释放时触发的事件.\[注意: 页面内必须有被聚焦的对象\]

**onKeyDown**

当键盘上某个按键被按下时触发的事件\[注意: 页面内必须有被聚焦的对象\]

**onKeyUp**

当键盘上某个按键被按放开时触发的事件\[注意: 页面内必须有被聚焦的对象\]

**页面相关事件**

**事件**

**描述**

**onAbort**

图片在下载时被用户中断

**onBeforeUnload**

当前页面的内容将要被改变时触发的事件 (刷新或者关闭）

**onUnload**

当前页面将被改变时触发的事件（关闭）

**onError**

捕抓当前页面因为某种原因而出现的错误，如脚本错误与外部数据引用的错误

**onLoad**

页面内空完成传送到浏览器时触发的事件，包括外部文件引入完成

**onMove**

浏览器的窗口被移动时触发的事件

**onResize**

当浏览器的窗口大小被改变时触发的事件

**onScroll**

浏览器的滚动条位置发生变化时触发的事件

**onStop**

浏览器的停止按钮被按下时触发的事件或者正在下载的文件被中断

**表单相关事件**

**事件**

**描述**

**onBlur**

当前元素失去焦点时触发的事件 \[鼠标与键盘的触发均可\]

**onChange**

当前元素失去焦点并且元素的内容发生改变而触发的事件 \[鼠标与键盘的触发均可\](多选框）

**onFocus**

当某个元素获得焦点时触发的事件

**onReset**

当表单中 RESET 的属性被激发时触发的事件

**onSubmit**

一个表单被递交时触发的事件

**滚动字幕事件**

**事件**

**描述**

**onBounce**

在 Marquee 内的内容移动至 Marquee 显示范围之外时触发的事件

**onFinish**

当 Marquee 元素完成需要显示的内容后触发的事件

**onStart**

当 Marquee 元素开始显示内容时触发的事件

**编辑事件**

**事件**

**描述**

**onBeforeCopy**

当页面当前的被选择内容将要复制到浏览者系统的剪贴板前触发的事件

**onBeforeCut**

当页面中的一部分或者全部的内容将被移离当前页面\[剪贴\]并移动到浏览者的系统剪贴板时触发的事件

**onBeforeEditFocus**

当前元素将要进入编辑状态

**onBeforePaste**

内容将要从浏览者的系统剪贴板传送\[粘贴\]到页面中时触发的事件

**onBeforeUpdate**

当浏览者粘贴系统剪贴板中的内容时通知目标对象

**onCopy**

当页面当前的被选择内容被复制后触发的事件

**onCut**

当页面当前的被选择内容被剪切时触发的事件

**onDrag**

当某个对象被拖动时触发的事件 \[活动事件\]

**onDragDrop**

一个外部对象被鼠标拖进当前窗口或者帧

**onDragEnd**

当鼠标拖动结束时触发的事件，即鼠标的按钮被释放了

**onDragEnter**

当对象被鼠标拖动的对象进入其容器范围内时触发的事件

**onDragLeave**

当对象被鼠标拖动的对象离开其容器范围内时触发的事件

**onDragOver**

当某被拖动的对象在另一对象容器范围内拖动时触发的事件 \[活动事件\]

**onDragStart**

当某对象将被拖动时触发的事件

**onDrop**

在一个拖动过程中，释放鼠标键时触发的事件

**onLoseCapture**

当元素失去鼠标移动所形成的选择焦点时触发的事件

**onPaste**

当内容被粘贴时触发的事件

**onSelect**

当文本内容被选择时的事件

**onSelectStart**

当文本内容选择将开始发生时触发的事件

**数据绑定**

**事件**

**描述**

**onAfterUpdate**

当数据完成由数据源到对象的传送时触发的事件

**onCellChange**

当数据来源发生变化时

**onDataAvailable**

当数据接收完成时触发事件

**onDatasetChanged**

数据在数据源发生变化时触发的事件

**onDatasetComplete**

当来子数据源的全部有效数据读取完毕时触发的事件

**onErrorUpdate**

当使用 onBeforeUpdate 事件触发取消了数据传送时，代替 onAfterUpdate 事件

**onRowEnter**

当前数据源的数据发生变化并且有新的有效数据时触发的事件

**onRowExit**

当前数据源的数据将要发生变化时触发的事件

**onRowsDelete**

当前数据记录将被删除时触发的事件

**onRowsInserted**

当前数据源将要插入新数据记录时触发的事件

**外部事件**

**事件**

**描述**

**onAfterPrint**

当文档被打印后触发的事件

**onBeforePrint**

当文档即将打印时触发的事件

**onFilterChange**

当某个对象的滤镜效果发生变化时触发的事件

**onHelp**

当浏览者按下 F1 或者浏览器的帮助选择时触发的事件

**onPropertyChange**

当对象的属性之一发生变化时触发的事件

**onReadyStateChange**

当对象的初始化属性值发生变化时触发

    window. onscroll: 窗口滚动条事件；
    window. onresize: 窗口大小改变事件；
    window. onscroll = window. onresize = function (){}   //同时触发；
    距离定位父元素的竖直距离：document. documentElemt. scrollTop;
    react 获取点击元素的左边距：e.currentTarget. offsetLeft
    距离滚动元素的可视范围距离： document.getElementById (index). offsetTop - document.getElementById (index). parentElement. scrollTop

    1. offsetTop 当前对象到其上级层顶部的距离。
    
    2. offsetLeft 当前对象到其上级层左边的距离。
    
    3. offsetWidth
      当前对象的宽度。(包括边线的宽) 与 style. width 属性的区别在于:
    
    4) ) 如对象的宽度设定值为百分比宽度, 则无论页面变大还是变小, style. width 都返回此百分比。
    
    5) ) 而 offsetWidth 则返回在不同页面中对象的宽度值而不是百分比值
    
    6. offsetHeight
    	当前对象的高度。(包括边线的高)
    
      1）与 style. height 属性的区别在于: 如对象的宽度设定值为百分比高度, 则无论页面变大还是变小, style. height 都返回此百分比
    
      2）而 offsetHeight 则返回在不同页面中对象的高度值而不是百分比值
    
    7. clientWidth 是对象可见的宽度，不包滚动条等边线，会随窗口的显示大小改变。
    
    8. clientHieght 网页可见区域高（clientHieght+scrollTop > offsetTop => 元素可见）
    
    9. scrollLeft 对象的最左边到对象在当前窗口显示的范围内的左边的距离，即是在出现了横向滚动条的情况下，滚动条拉动的距离。
    
    10. scrollTop 对象的最顶部到对象在当前窗口显示的范围内的顶边的距离，即是在出现了纵向滚动条的情况下，滚动条拉动的距离。
    
    11. window. screenTop 网页正文部分上 
    
    12. window. screenLeft 网页正文部分左
    
    13. window. screen. height 屏幕分辨率的高
    
    14. window. screen. width 屏幕分辨率的宽
    
    15. window. screen. availHeight 屏幕可用工作区高度

    1、HTML 事件处理：直接添加到 html 结构中；，
    2、DOM 0 级事件处理：事件绑定，将一个事件处理函数赋值给一个元素的事件处理属性；只能为元素绑定一个事件处理函数；（将事件处理属性赋值为 null 就可以解绑）
        document.getElementById ("btn"). onclick = function（）{ alert ("hello"); } //脚本里面绑定
    3、DOM 2 级事件处理：事件监听，
        node.addEventListener (eventType, callback, bool=false):
        eventType (事件类型)：click, input.....（没有 on)
        callback：事件监听函数
        boll：默认值 false  冒泡（false）/捕获（true)
        事件监听允许一个元素添加多个事件处理函数；与添加顺序有关；
        事件移除：
        node.removeEventListener (eventType, fnname/arguments. callee);    //arguments. callee 当前函数引用
    4、IE 事件处理：attachEvent (eventType, callback);
       IE 事件移除：detachEvent (eventType, callback);
       eventType (事件类型)：click, input.....（有 on)

    在 DOM 标准中，事件处理周期分三个阶段：
    1、事件捕获从最不具体的事物到最具体的事物，事件沿 DOM 树向下传播
    2、目标触发运行事件监听函数
    3、事件冒泡从最具体的事物到最不具体的事物，事件沿 DOM 树向上传播
    DOM 0 只能使用事件冒泡，低版本 IE 只有冒泡；
    DOM 2 级事件处理：事件监听，
        node.addEventListener (eventType, callback, bool=false):
        eventType (事件类型)：click, input.....（没有 on)
        callback：事件监听函数 a
        boll：默认值 false  事件冒泡（false）/ 事件捕获（true)

    IE8 以下 event 不属于 DOM，属于 BOM，使用 event 时需要写全称；
    
    DOM 标准方法阻止事件捕获/冒泡（react 可用）：event.stopPropagation ()；
    IE 中阻止事件捕获/冒泡：event. canceBubble = true;

    阻止默认事件（react 可用）：event.preventDefault ();  - event. returnValue = false;  //兼容 IE

    将事件处理函数添加给事件目标的祖先元素；
    通过事件冒泡的特性，判断事件的源，为目标添加事件；
    每个事件处理函数都有一个 event 对象用于描述事件信息；
    在 event 对象中，有一个 target / srcElement 属性指向事件目标；
    示例：
    box. onclick = function (event) {
        event = event || window. event;
        // console.log (event. target); // 标准
        // console.log (event. srcElement); // IE
        var target = event. target || event. srcElement; // 兼容
        if (target. nodeName === 'BUTTON') {
            box. innerHTML += '<button>按钮</button>';
        }
    }

    type: 事件类型；-contextmenu (鼠标右键点击)
    button：鼠标按键编号；
    鼠标事件对象属性：
    clientX \clientY : 根据浏览器可视区域左上角计算坐标；
    pageX \ pageY : 根据页面左上角计算坐标；
    layerX \ layerY ：根据页面左上角计算坐标；
    offsetX \ offsetY : 根据（父）元素左上角计算点击坐标；
    screenX \ screenY ：根据屏幕左上角计算点击坐标；

    keydown-按下（返回最后一个输入值）
    keycode/which: 键盘按键编码（回车 13、空格 32、ctrl7、数字 48-57、字母 65-90）；
    altkey/shiftkey/ctrlkey: 返回布尔值，表示是否同时按下；
    input：获得用户输入内容；（动态显示输入值，每次变化都可以输出前面的全部）

    wheelDelta：判断鼠标滚轮方向，+向上，-向下    ||   / detail: 火狐判断鼠标滚轮方向，+向下，-向上；

### Math 对象

方法

描述

[abs(x)](https://www.w3school.com.cn/jsref/jsref_abs.asp)

返回数的绝对值。

[acos(x)](https://www.w3school.com.cn/jsref/jsref_acos.asp)

返回数的反余弦值。

[asin(x)](https://www.w3school.com.cn/jsref/jsref_asin.asp)

返回数的反正弦值。

[atan(x)](https://www.w3school.com.cn/jsref/jsref_atan.asp)

以介于 -PI/2 与 PI/2 弧度之间的数值来返回 x 的反正切值。

[atan2(y,x)](https://www.w3school.com.cn/jsref/jsref_atan2.asp)

返回从 x 轴到点 (x, y) 的角度（介于 -PI/2 与 PI/2 弧度之间）。

[ceil(x)](https://www.w3school.com.cn/jsref/jsref_ceil.asp)

对数进行上舍入。

[floor(x)](https://www.w3school.com.cn/jsref/jsref_floor.asp)

对数进行下舍入，超出精度四舍五入。

[cos(x)](https://www.w3school.com.cn/jsref/jsref_cos.asp)

返回数的余弦。

[exp(x)](https://www.w3school.com.cn/jsref/jsref_exp.asp)

返回 e 的指数。

[log(x)](https://www.w3school.com.cn/jsref/jsref_log.asp)

返回数的自然对数（底为 e）。

[max(x,y)](https://www.w3school.com.cn/jsref/jsref_max.asp)

返回 x 和 y 中的最高值，可以存在多个参数。

[min(x,y)](https://www.w3school.com.cn/jsref/jsref_min.asp)

返回 x 和 y 中的最低值，可以存在多个参数。

[pow(x,y)](https://www.w3school.com.cn/jsref/jsref_pow.asp)

返回 x 的 y 次幂。

[random()](https://www.w3school.com.cn/jsref/jsref_random.asp)

返回 0 ~ 1 之间的随机数。

[round(x)](https://www.w3school.com.cn/jsref/jsref_round.asp)

把数四舍五入为最接近的整数。

[sin(x)](https://www.w3school.com.cn/jsref/jsref_sin.asp)

返回数的正弦。

[sqrt(x)](https://www.w3school.com.cn/jsref/jsref_sqrt.asp)

返回数的平方根。

[tan(x)](https://www.w3school.com.cn/jsref/jsref_tan.asp)

返回角的正切。

[toSource()](https://www.w3school.com.cn/jsref/jsref_tosource_math.asp)

返回该对象的源代码。

[valueOf()](https://www.w3school.com.cn/jsref/jsref_valueof_math.asp)

返回 Math 对象的原始值。

##### 自定范围随机数

    function random (min, max) {
                // return Math.round (Math.random () * (max - min) + min);
                return Math.floor (Math.random () * (max - min + 1) + min);
            }

### Date 日期对象

##### 常用方法：

方法

描述

[Date()](https://www.w3school.com.cn/jsref/jsref_Date.asp)

返回当日的日期和时间；传参时间戳还原时间。

[getDate()](https://www.w3school.com.cn/jsref/jsref_getDate.asp)

从 Date 对象返回一个月中的某一天 (1 ~ 31)。

[getDay()](https://www.w3school.com.cn/jsref/jsref_getDay.asp)

从 Date 对象返回一周中的某一天 (0 ~ 6)。

[getMonth()](https://www.w3school.com.cn/jsref/jsref_getMonth.asp)

从 Date 对象返回月份 (0 ~ 11)。

[getFullYear()](https://www.w3school.com.cn/jsref/jsref_getFullYear.asp)

从 Date 对象以四位数字返回年份。

[getYear()](https://www.w3school.com.cn/jsref/jsref_getYear.asp)

请使用 getFullYear () 方法代替。

[getHours()](https://www.w3school.com.cn/jsref/jsref_getHours.asp)

返回 Date 对象的小时 (0 ~ 23)。

[getMinutes()](https://www.w3school.com.cn/jsref/jsref_getMinutes.asp)

返回 Date 对象的分钟 (0 ~ 59)。

[getSeconds()](https://www.w3school.com.cn/jsref/jsref_getSeconds.asp)

返回 Date 对象的秒数 (0 ~ 59)。

[getMilliseconds()](https://www.w3school.com.cn/jsref/jsref_getMilliseconds.asp)

返回 Date 对象的毫秒 (0 ~ 999)。

[getTime()](https://www.w3school.com.cn/jsref/jsref_getTime.asp)

返回 1970 年 1 月 1 日至今的毫秒数。

[getTimezoneOffset()](https://www.w3school.com.cn/jsref/jsref_getTimezoneOffset.asp)

返回本地时间与格林威治标准时间 (GMT) 的分钟差。

[getUTCDate()](https://www.w3school.com.cn/jsref/jsref_getUTCDate.asp)

根据世界时从 Date 对象返回月中的一天 (1 ~ 31)。

[getUTCDay()](https://www.w3school.com.cn/jsref/jsref_getUTCDay.asp)

根据世界时从 Date 对象返回周中的一天 (0 ~ 6)。

[getUTCMonth()](https://www.w3school.com.cn/jsref/jsref_getUTCMonth.asp)

根据世界时从 Date 对象返回月份 (0 ~ 11)。

[getUTCFullYear()](https://www.w3school.com.cn/jsref/jsref_getUTCFullYear.asp)

根据世界时从 Date 对象返回四位数的年份。

[getUTCHours()](https://www.w3school.com.cn/jsref/jsref_getUTCHours.asp)

根据世界时返回 Date 对象的小时 (0 ~ 23)。

[getUTCMinutes()](https://www.w3school.com.cn/jsref/jsref_getUTCMinutes.asp)

根据世界时返回 Date 对象的分钟 (0 ~ 59)。

[getUTCSeconds()](https://www.w3school.com.cn/jsref/jsref_getUTCSeconds.asp)

根据世界时返回 Date 对象的秒钟 (0 ~ 59)。

[getUTCMilliseconds()](https://www.w3school.com.cn/jsref/jsref_getUTCMilliseconds.asp)

根据世界时返回 Date 对象的毫秒 (0 ~ 999)。

[parse()](https://www.w3school.com.cn/jsref/jsref_parse.asp)

返回 1970 年 1 月 1 日午夜到指定日期（字符串）的毫秒数。

[setDate()](https://www.w3school.com.cn/jsref/jsref_setDate.asp)

设置 Date 对象中月的某一天 (1 ~ 31)。

[setMonth()](https://www.w3school.com.cn/jsref/jsref_setMonth.asp)

设置 Date 对象中月份 (0 ~ 11)。

[setFullYear()](https://www.w3school.com.cn/jsref/jsref_setFullYear.asp)

设置 Date 对象中的年份（四位数字）。

[setYear()](https://www.w3school.com.cn/jsref/jsref_setYear.asp)

请使用 setFullYear () 方法代替。

[setHours()](https://www.w3school.com.cn/jsref/jsref_setHours.asp)

设置 Date 对象中的小时 (0 ~ 23)。

[setMinutes()](https://www.w3school.com.cn/jsref/jsref_setMinutes.asp)

设置 Date 对象中的分钟 (0 ~ 59)。

[setSeconds()](https://www.w3school.com.cn/jsref/jsref_setSeconds.asp)

设置 Date 对象中的秒钟 (0 ~ 59)。

[setMilliseconds()](https://www.w3school.com.cn/jsref/jsref_setMilliseconds.asp)

设置 Date 对象中的毫秒 (0 ~ 999)。

[setTime()](https://www.w3school.com.cn/jsref/jsref_setTime.asp)

以毫秒设置 Date 对象。

[setUTCDate()](https://www.w3school.com.cn/jsref/jsref_setUTCDate.asp)

根据世界时设置 Date 对象中月份的一天 (1 ~ 31)。

[setUTCMonth()](https://www.w3school.com.cn/jsref/jsref_setUTCMonth.asp)

根据世界时设置 Date 对象中的月份 (0 ~ 11)。

[setUTCFullYear()](https://www.w3school.com.cn/jsref/jsref_setUTCFullYear.asp)

根据世界时设置 Date 对象中的年份（四位数字）。

[setUTCHours()](https://www.w3school.com.cn/jsref/jsref_setutchours.asp)

根据世界时设置 Date 对象中的小时 (0 ~ 23)。

[setUTCMinutes()](https://www.w3school.com.cn/jsref/jsref_setUTCMinutes.asp)

根据世界时设置 Date 对象中的分钟 (0 ~ 59)。

[setUTCSeconds()](https://www.w3school.com.cn/jsref/jsref_setUTCSeconds.asp)

根据世界时设置 Date 对象中的秒钟 (0 ~ 59)。

[setUTCMilliseconds()](https://www.w3school.com.cn/jsref/jsref_setUTCMilliseconds.asp)

根据世界时设置 Date 对象中的毫秒 (0 ~ 999)。

[toSource()](https://www.w3school.com.cn/jsref/jsref_tosource_boolean.asp)

返回该对象的源代码。

[toString()](https://www.w3school.com.cn/jsref/jsref_toString_date.asp)

把 Date 对象转换为字符串。

[toTimeString()](https://www.w3school.com.cn/jsref/jsref_toTimeString.asp)

把 Date 对象的时间部分转换为字符串。

[toDateString()](https://www.w3school.com.cn/jsref/jsref_toDateString.asp)

把 Date 对象的日期部分转换为字符串。

[toGMTString()](https://www.w3school.com.cn/jsref/jsref_toGMTString.asp)

请使用 toUTCString () 方法代替。

[toUTCString()](https://www.w3school.com.cn/jsref/jsref_toUTCString.asp)

根据世界时，把 Date 对象转换为字符串。

[toLocaleString()](https://www.w3school.com.cn/jsref/jsref_toLocaleString.asp)

根据本地时间格式，把 Date 对象转换为字符串。

[toLocaleTimeString()](https://www.w3school.com.cn/jsref/jsref_toLocaleTimeString.asp)

根据本地时间格式，把 Date 对象的时间部分转换为字符串。

[toLocaleDateString()](https://www.w3school.com.cn/jsref/jsref_toLocaleDateString.asp)

根据本地时间格式，把 Date 对象的日期部分转换为字符串。

[UTC()](https://www.w3school.com.cn/jsref/jsref_utc.asp)

根据世界时返回 1970 年 1 月 1 日到指定日期的毫秒数。

[valueOf()](https://www.w3school.com.cn/jsref/jsref_valueOf_date.asp)

返回 Date 对象的原始值。

## 2\. 函数（本质是对象）

##### 函数的创建

    函数的申明：(小括号里面的称为形参)
    function name (参数 1, 参数 2){
      语句；
    } ；
    
    表达式创建（赋值创建）（先申明，后使用）：
    var myFun = function {
        语句；
    }；

##### if-else 语句

    if (){ }
    else{ }

##### switch 语句

    swich 在不碰到 break 的时候发生穿透执行进行累加
    switch (){
        case ():      ;
        case ():      ;
        case ():      ;
        break;    //终止循环
        default;  //默认值, 找不到匹配项输出的结果
    }
    break 语句：跳出当前循环（最近的），后面代码将不执行
    continue 语句：跳过本次循环进入下一次循环

##### while 循环

    while (){ }

##### do-while 循环

    do{ }
    while ();   //满足条件循环

##### for 循环

    for (表达式 1；表达式 2；表达式 3){
        循环语句
    }
    表达式 2 多条件，以最后一个条件为准；
    
    for... in
    MDN：for... in 语句以任意顺序迭代一个对象的除 Symbol 以外的可枚举属性，包括继承的可枚举属性。
    	for... in 用于获取对象的属性名，包括自身属性和继承属性
    	for... in 遍历对象时，顺序并不是固定的
    
    for... of （ES6）
    MDN：for... of 语句在可迭代对象（包括 Array, Map, Set, String, TypedArray, arguments 对象等等）上创建一个迭代循环，调用自定义迭代钩子，并为每个不同属性的值执行语句（for... of 可以直接遍历 Set 和 Map）。
    说到可迭代对象，就要讲到迭代器了，迭代器是一种对象，它提供统一的接口，为不同的集合（Object、Array、Set、Map）提供了统一的访问机制。总的来说，可迭代对象就是实现 Symbol. iterator 方法的对象。
    
    for await... of （ES9，使用了 for await... of ，外层需要 async）
    MDN：for await... of 语句创建一个循环，该循环遍历异步可迭代对象以及同步可迭代对象，包括：内置的 String，Array，类似数组对象 (例如 arguments 或 NodeList)，TypedArray，Map，Set 和用户定义的异步/同步迭代器。它使用对象的每个不同属性的值调用要执行的语句来调用自定义迭代钩子。

##### arguments 对象

    保存了调用函数传入的实参；类数组；为每个参数提供了索引；
    用[]进行索引：arguments[1]
    length: 表示长度，参数个数；
    callee：返回当前函数的引用；
    return：函数的返回值，默认为 undefined；可以出现多次，但是只执行一次；接收时将函数整体赋值给一个变量;

##### 递归函数

    function fn (){
        if (){
            return   ;
        }
        else{
            return fn ();
        }
    }

##### 匿名函数：定义函数时未给函数命名

    优点：
    1、有效隔绝作用域，避免作用域污染
    2、仅在执行时创建作用域链对象
    两种使用方式：
    1、自执行函数（自调用函数、一次性函数）：
    (function (形参){})(实参);
    !function (){}();
    ~function (){}();
    2、回调函数（将一个匿名函数作为参数使用）：
    function fn (){
        callback ();
    }
    fn (function (){});

##### 计时器

    setInterval (callback, delay)：会在每次时间间隔为 delay 时执行一次 callback；返回值是 id（计时器编号）；
                          delay: 延迟时间 ms
            clearInterval (name): 清除计时器
    
    var timer = setInterval (function () {console.log ('1')}, 2000);
    clearInterval (timer);

    setTimeout (callback, delay): 只执行一次函数；返回值是 id（计时器编号）；
                         delay: 延迟时间 ms  
    
    var timer = setTimeout (function () {console.log ('1')}, 2000);
    clearTimeout (timer);

    1、硬件层面：
      浏览器实现中的计时器基于操作系统的时钟，而操作系统时钟本身可能存在精度问题。
    JavaScript 在浏览器环境中执行，其计时依赖于 CPU 时间片的分配和调度，因此无法做到原子钟级别的精确计时。
    2、系统层面：
      当浏览器处于忙碌状态（如执行复杂的 JavaScript 代码、渲染页面或执行其他任务）时，可能延迟计时器函数的调用，导致实际触发的时间晚于预期。
      不同浏览器对计时器的精度处理也存在差异，例如某些浏览器可能会将最小时间间隔限制在 4 毫秒左右。
    3、单线程执行模型：
      JavaScript 主线程是单线程的，这意味着即使到了预定的时间点，如果当前有其他任务正在执行，计时器回调函数必须等待主线程空闲后才能被调用。

## 3\. this 指向和闭包

##### 3.1. 修改 this 指向三种方法 (call、apply、bind)

    //call 和 apply 都可以用于修改函数中的 this 指向；他们的区别在于参数的传递
    1、call 用于立即调用函数并修改函数中的 this 指向；函数的参数按原有顺序依次传入
      	fn.call ({});
    2、apply 用于立即调用函数并修改函数中的 this 指向；函数的参数是 apply 第二个参数 (数组或类数组)，数组或类数组对象会自动展开成为函数的参数
      	fn.apply ([]);
    3、function.prorotype.bind (thisObj，arg): 修改 this 指向为 thisObj，并为函数绑定实参；返回一个新函数，需要手动执行；
        参数：thisObj：函数中 this 指向的对象； arg：实参；
     		fn.bind (obj, arg); 
    //apply 和 call 方法在使用时，会改变 this 指向然后传参后立即执行函数，返回结果
    //bind 方法是创建了一个新的函数，在这个被创建的新的函数中，this 的指向被改变，并接收了 bind 传递的参数。需要另外手动调用后，函数才会被执行。

##### 3.2. 闭包

    从语法结构来说闭包是一种 JS 特有的函数嵌套结构
    具体的表现行为在一个较大的作用域内访问一个较小作用域中的变量
    
    行成闭包的三个必要条件：
    1. 函数嵌套 (至少有两个函数)
    2. 内层函数中使用了外层函数的变量或参数
    3. 内层函数被返回到外部在外部使用
    
    闭包的作用：
    4. 保护具有共享意义的变量
    5. 隔离作用域避免作用域污染
    6. 为变量提供对外访问接口
    
    闭包的缺点：
    7. 概念复杂不易理解
    8. 占用过多资源 (内存) 大量使用不利于代码优化
    
    内层函数引用了外层函数的变量 (参数) 导致垃圾回收机制没有销毁变量行成新的闭包作用域；
    闭包作用域中的值不会随垃圾回收机制销毁；销毁闭包的方式是将闭包的函数赋值为 null
    
    实例：
    let fn = (function () {
        let a = 10;
        return fn2;
        function fn2 () {
            a++;
            console.log (a);
        }
    })();
    fn ();      

##### 3.3. 闭包引起的内存泄漏

    闭包内多个函数共享词法环境，导致词法环境膨胀，从而导致无法触达也无法回收的内存空间

##### 3.4. 闭包的应用-防抖和节流

    // 给高频事件降频
    1. 函数防抖
     // 核心思想最后一次事件结束后等待 N 秒，执行函数；如果在 N 这个时间范围内多次触发事件则从新计时
     实例：
    function debounce (callback, delay) {
      let timer = null; // 用于存放计时器 id
    
      return function () {
        let arg = arguments; // 保存实参
    
        if (timer) {
          // 之前如果有开启过计时器 (之前有任务)
          clearTimeout (timer); // 关闭计时器
        }
    
        timer = setTimeout (() => {
          // 到达时间
          callback.apply (this, arg); // 执行任务
        }, delay);
      };
    }
                
    2. 函数节流
     // 核心思想每隔 N 秒执行函数；想要知道间隔时间就需要记录上一次的执行时间
     实例：
    function throttle (func, delay) {
      let timeoutId;
      let lastExec = 0;
    
      function wrapper () {
        const context = this;
        const args = arguments;
        const currentTime = Date.now ();
    
        // 如果上次执行后至今未达到延迟时间，则立即执行
        if (currentTime - lastExec >= delay) {
          func.apply (context, args);
          lastExec = currentTime;
        } else if (! timeoutId) {
          // 如果没有计时器正在运行，设置一个
          timeoutId = setTimeout (() => {
            func.apply (context, args);
            lastExec = currentTime;
            // 清除计时器
            timeoutId = null;
          }, delay - (currentTime - lastExec));
        }
      }
    
      return wrapper;
    }
    
    注意：sessionStorage 不能在多个窗口或标签页之间共享数据，但是当通过 window. open 或链接打开新页面时 (不能是新窗口)，新页面会复制前一页的 sessionStorage。

## 4.