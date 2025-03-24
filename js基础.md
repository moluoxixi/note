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