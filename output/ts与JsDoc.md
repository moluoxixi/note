# JsDoc

一种无需编译即可定义类型的编辑器内置工具,如果需要类型检查,需要在配置中添加js检查

## 配置使ts支持JsDoc

```
{
    //编译配置
    "compilerOptions":{
        ...,
        "allowJs":true,     //允许编译 JS
        "checkJs":true,     //编译 JS 的时候也做类型检查
        "declaration":true, //不影响使用,是否编译后生成对应的.d.ts
        ""
    },
    //配置需要检查的文件
    "iclude"["src/**/*.js",...]
}
```

## 定义函数参数(类型+可选+默认值)

```javascript
/**
* @param {string}p1           参数p1的注释
* @param {string=}p2          可选参数
* @param {string}[p3]         可选参数的第二种写法
* @param {string?}p4          可选参数的第三种写法
* @param {string} [p4="test"] 可选+默认值
*/
const func=(p1,p2,p3,p4){}
```

## 定义变量类型

```javascript
/**@type {Promise<string>}**/
let func;
/**@type {(a:string,b:boolean)=>number}*/
let func=(a,b)=>1;
```

## 类型别名

```javascript
//用于类型被多处用到,可以放在.d.ts文件中供全局使用
//定义
**@typedef {(s:string,b:boolean)=>number} 别名名称*/
​
//使用
/** @type {别名名称} */
let func;
​
​
//放在guang.d.ts
export interface MyFunc{
    (s:string,b:boolean):number
}
//使用
/*@type {import("./guang").MyFunc}*/
let func2 = (s,b)=>1;
```

## 定义泛型

```javascript
//通过 @template 声明泛型
/**
* @template P
* @typedef {P extends Promise<infer T>T:never} TiCao
*/
```

## class写法(继承+泛型)

```
/**
*@template T
*@extends {Set<T>}
*/
class Guang extends Set{
    /**@type{T}*/
    name;
    /**
    * @param {T} name
    */
    constructor(name){
        super()
        this.namename;
    }
}
```

# ts有什么作用?

方便更准确的检查错误。给程序带来稳定性和可预测性。静态类型检查。项目中不再需要typeof检查类型，数据类型之前就规定好的。比如react传过来的props就不需要写proptypes。

# 装饰器

一种特殊类型的声明，它可以被附加到类声明、方法、属性或参数上，从而修改类的行为。装饰器是ES7的一个提案特性，TypeScript 提供了装饰器的实验性支持,但是js并未实现

它的写法是一个函数,通过`@函数名`调用,可以进行封装,使它可以接受参数

## 成员装饰器

```javascript
function mySetMetadata(key: string, value: any) {
  //target     : 类本身
  //propertyKey: 成员才有,成员的名称
  return function (target: any, propertyKey?: string | symbol) {  
    // 检查是否有 propertyKey，如果有，则应用于属性  
    if (propertyKey !== undefined) {  
      Reflect.defineMetadata(key, value, target, propertyKey);  
    } else {  
      // 否则，应用于类  
      Reflect.defineMetadata(key, value, target);  
    }  
  };  
}

@mySetMetadata('aaa','123')
class Demo {
    constructor() { }
    @mySetMetadata('aaa','123')
    getUser(userId: string) { }
}
```

## 参数装饰器

```javascript
function PathParam(paramDesc: string) {
    //target     :对于静态成员来说是类的构造函数，对于实例成员是类的原型对象。
    //methodName :对于成员来说是函数名,对于constructor是undefined(因为constructor没有名字)
    //paramIndex :参数的下标
    return function (target: any, methodName: string, paramIndex: number) {
        !target.$meta && (target.$meta = {});
        target.$meta[paramIndex] = paramDesc;
    }
}

class Demo {
    constructor() { }
    getUser( @PathParam("userId") userId: string) { }
}

console.log((<any>Demo).prototype.$meta);
```

# 类型

xx的父类就是xx可以赋值给这个类型

xx的子类就是类型可以赋值给xx

| 类型        | 例子                                                                                  | 描述                                                                                                                       |
| --------- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Any       | x:any                                                                               | 除unknown所有类型的父类 , <br>除never外所有类型的子类<br> 一般禁用,<br>**任何类型都可以赋值给它(除了unknown)**，<br>**它也可以赋值给任何类型（除了 never）**               |
| Unknown   | x:unknown                                                                           | 未知类型 , 类型安全的any , 除any外所有类型的父类                                                                                           |
| Number    | x:number                                                                            | 任意数字                                                                                                                     |
| String    | x:string                                                                            | 任意字符串                                                                                                                    |
| Boolean   | x:boolean                                                                           | 布尔值true或false                                                                                                            |
| 字面量       | x:'123'                                                                             | 限制x的值为'123'等等,可以用联合类型限制多个值                                                                                               |
| Array     | x:Array<泛型>                                                                         | 泛型和类型处可以写 `类型 联合类型 类型别名 接口 泛型`                                                                                           |
| Set       | x:Set<泛型>                                                                           | 与数组泛型写法一致                                                                                                                |
| Map       | x:Map<泛型1,泛型2>                                                                      | 泛型1代表键,泛型2代表值                                                                                                            |
| Tuple     | x:[string, number]                                                                  | 元组，TS新增类型，指定长度和值的数组                                                                                                      |
| Symbol    | x:symbol                                                                            |                                                                                                                          |
| Promise   | x:Promise<promise的结果>                                                               |                                                                                                                          |
| void      | x:void                                                                              | 空值<br>**非严格模式**下undefined和null是任意类型的子类,任意类型都能赋值为null和undefined <br>**严格模式**下仅void能作为undefined子类,其他类型都不能赋值为null和undefined |
| Null      | x:null                                                                              |                                                                                                                          |
| Undefined | x:undefined                                                                         |                                                                                                                          |
| Never     | 没有值                                                                                 | 无任何类型,由于js中仅报错情况下无返回值,<br>**用于错误类型**                                                                                     |
| Enum      | enum Color {<br> Red = 1,<br> Green = 4 <br>} <br>Color[Red]-->1 <br>Color[1]-->Red | 枚举，TS中新增类型,键值相互映射的对象,<br>**用于数据字典**                                                                                      |
| Function  | 函数的包装类型                                                                             | ts有以下包装类型Number、String、Boolean、Symbol、Array、Function、Object                                                              |


## never

完全没值,用于函数未完全执行时 指定返回值

**never 是所有类型的子类型**

与void区别:never表示无任何类型,void可以是null/undefined

```javascript
 function error(message: string): never {
   throw new Error(message);
 }
const fn=(a:string,b:string):never=>{
  throw Error();
}
```

## Array

```javascript
 //由指定类型组成的数组
   let list: number[] = [1, 2, 3];  
 //泛型
 let list: Array<泛型> = [1, 2, 3];
​
​
//由接口指定类型对象组成的数组
interface Person {
  name: string
  age: number
}
const people: Person[] = [
    { name: "Alice", age: 30 },
    { name: "Bob", age: 25 },
    { name: "Charlie", age: 35 },
];
const people: Array<Person> = [
    { name: "Alice", age: 30 },
    { name: "Bob", age: 25 },
    { name: "Charlie", age: 35 },
];
```

## Set

同Array的泛型写法

```javascript
 //泛型
 const list: Set<泛型> = [1, 2, 3];

//由接口指定类型对象
interface Person {
  name: string
  age: number
}
const people: Set<Person> = new Set([
    { name: "Alice", age: 30 },
    { name: "Bob", age: 25 },
    { name: "Charlie", age: 35 },
]);
```

## Map

双泛型写法,分别对应键和值

```javascript
interface Person {
  name: string
  age: number
}
const a:Map<Person,string> = new Map([[{ name: 'Alice', age: 30 },'Alice']]);
```

## tuple

元组

指定个数和类型的数组

```javascript
 let x: [string, number];
 x = ["hello", 10]; 
//元组的越界,元组通过数组方法可以新增未受元组限制的类型
x.push(1);
```

## enum

枚举

```javascript
 enum Color {
   Red,
   Green
 }
 let c: Color = Color.Green;
//编译为
var Color;
(function(Color){
   Color[Color['Red']=0]='Red',
   Color[Color['Green']=1]='Green'
})
var c = Color.Green;

 enum Color {
   Red = 1,
   Green
 }
 let c: Color = Color.Green;

//编译为
var Color;
(function(Color){
   Color[Color['Red']=1]='Red',
   Color[Color['Green']=2]='Green'
})
var c = Color.Green;

 enum Color {
   Red = 1,
   Green = 4
 }
 let c: Color = Color.Green;

//编译为
var Color;
(function(Color){
   Color[Color['Red']=1]='Red',
   Color[Color['Green']=4]='Green'
})
var c = Color.Green;
```

# 断言

## 类型断言

`xx as 类型`或`<类型>xx`

有些情况下，变量的类型对于我们来说是很明确，但是TS编译器却并不清楚，此时，可以通过类型断言来告诉编译器变量的类型，断言有两种形式：

- 第一种

```javascript
 let someValue: unknown = "this is a string";
 let strLength: number = (someValue as string).length;
```

- 第二种

```javascript
 let someValue: unknown = "this is a string";
 let strLength: number = (<string>someValue).length;
```

## 非空断言

!

```javascript
//a一定为number,不能为空
let fn:(a:number|undefined)=>void=(a!){}
```

# 类型运算

## 条件extends ? :

```javascript
type isTwo<T,B> = T extends B ? true: false;

type res = isTwo<1,1|2>;
const a:res=true; //正确
```

## 推导infer

通过推导获取类型

```javascript
//获取数组中的最后一个元素类型
type GetLast<Arr extends unknown[]> = Arr extends [...unknown[], infer Last] ? Last : never;
```

## 联合|

一个变量或参数可以限制为多种类型

```javascript
let type:number|string;
```

## 交叉&

在 TypeScript 中交叉类型是将多个类型合并为一个类型。通过 `&` 运算符可以将现有的多种类型叠加到一起成为一种类型，它包含了所需的所有类型的特性。

```javascript
type PartialPointX = { x: number; };
type Point = PartialPointX & { y: number; }; //也可用于接口

let point: Point = {
  x: 1,
  y: 1
}

```

在上面代码中我们先定义了 `PartialPointX` 类型，接着使用 & 运算符创建一个新的 `Point` 类型，表示一个含有 x 和 y 坐标的点，然后定义了一个 `Point` 类型的变量并初始化。

# 可选?

可传可不传

变量或参数后面加?

```javascript
function(a:number,b?:string):void{}
```

# 索引签名

给 对象/数组/元组/枚举 的键声明类型

```javascript
interface Okay {
  [x: string]: Animal;
  [x: number]: Dog; // OK
}
```

```javascript
type a={
    [x: string]: Animal;
    [x: number]: Dog; // OK
}
```

## 不定数量属性的对象

```javascript
interface a{
  [key:string]:string
}
const obj:a={
  b:'2',
  c:'1',
  d:'1'
}
```

# 类型(变量/模块)声明declare

执行命令 `tsc xx.ts --declaration `,`ts`编译后,会生成`xxx.d.ts`和`js`产物

`xxx.d.ts`就是全局类型声明,也可以手动写这种文件

`ts`执行时,遇到未定义类型的变量或方法时,会去ts所在目录下查找所有的`xxx.d.ts`文件,在文件中查找该未定义类型的变量或方法

在ts文件所在目录下新建`xxx.d.ts`文件,内容如下:

```javascript
//xxx.d.ts文件中定义的是全局变量、函数、接口、模块和类型定义,declare也可用于定义局部的
//ts遇到未定义类型的$变量时,会使用该类型定义
declare var $:(selector:string)=>any

declare function myFunction(): void;
```

```js
//当我们使用外部js模块时,外部js模块通常无法获取全局文件xx.d.ts中的类型定义,这时候就需要模块定义
declare module "my-library" {
  export function doSomething(): void;
  export function doSomethingElse(): void;
}

//use
import * as MyLibrary from "my-library";

MyLibrary.doSomething(); // TypeScript 知道 doSomething 函数的存在和返回类型
MyLibrary.doSomethingElse();

```

# 类型别名type

类型别名,给类型起一个名字

可以给基本类型,联合类型起别名

```javascript
type 别名 = number|string;
type 别名2={val:string,num:number}
function fn(a:别名,b:别名2):void{
}
fn(2,{val:"",num:1})
```

# interface

用来限制一个对象必须且只能拥有的属性/方法的工具

接口（Interfaces）来定义对象的类型。
**接口是对象的状态(属性)和行为(方法)的抽象(描述)**

## 属性合并

如果多个类通过&进行合并,具有相同属性名时:

如果是基本类型,会报错

如果是对象类型,会将对象中的属性进行二次合并,重复以上过程

```javascript
interface a{
	a:string
}
interface b{
	a:string
}
type c=a&b //错误

interface a{
  a:{
    b:string
  }
}
interface b{
  a:{
    c:string
  }
}
type c= a&b //正确
```

## 函数类型

```javascript
interface 接口{
    (x:类型,y:类型):返回值类型
}

let fn:fntype= (x:类型,y:类型):返回值类型=>{return x+y}
```

## 类的类型

检查类的类型

```javascript
interface 接口1{
    属性: 类型;
    
}
interface 接口2 {
  方法():返回值类型;
}

class 类名 implements 接口1{
    属性: 1;
}
class 类名 implements 接口1,接口2{
    属性: 1;
    方法() {
        return 1
    }
}
```

## 对象类型

```javascript
interface 接口{
    属性1: 类型;
    方法1():返回值类型;
}

function fn(参数: 接口){
    参数.方法();
}
```

# interface 和 type 的区别

1. 
	- interface 只能声明 函数/对象
	- type 除了能声明 对象/函数 以外，还能为基础类型声明别名

2. 
    - type声明的变量已是最终状态,不可变
    - interface可以进行声明合并,为之前的接口添加新的类型/索引签名

# 工具函数

## typeof

可以得到某个变量的类型,用于声明

```javascript
a<typeof b>()
```

## 实例工具InstanceType

得到某个类/构造函数的实例类型,比如获取组件实例

```javascript
//type InstanceType<T extends new (...args: any) => any> = T extends new (...args: any) => infer R ? R : any;
    //T 是一个类构造函数类型。
    //T 必须是一个可以用 new 关键字实例化的构造函数类型。
    //infer R 用于推断构造函数返回的实例类型 R。

InstanceType<typeof 组件>;

class MyClass {}
InstanceType<typeof MyClass>;
```

## 可选工具Partial

接收一个对象类型，并将这个对象类型的所有属性都标记为可选

```javascript
//typePartial<T> = { [P in keyof T]?: T[P] };
    //T 是一个对象。
    //[P in keyof T] 遍历 T 的所有属性。
    //? 标记属性为可选。
    //T[P] 表示属性 P 的类型。


type User = {
  name: string;
  age: number;
  email: string;
};

type PartialUser = Partial<User>;
//正常情况下,需要所有属性都写
const user: User = {
  name: 'John Doe',
  age: 30,
  email: 'john.doe@example.com'
};

//可以不实现全部的属性了！
const partialUser: PartialUser = {
  name: 'John Doe',
  age: 30
};
```

## 必选工具Required

接收一个对象类型，并将这个对象类型的所有属性去掉可选

```javascript
type User = {
  name?: string;
  age?: number;
  email?: string;
};

type RequiredUser = Required<User>;

const user: User = {
  name: 'John Doe'
};

// 现在你必须全部实现这些属性了
const requiredUser: RequiredUser = {
  name: 'John Doe',
  age: 30,
  email: 'john.doe@example.com'
};
```

## 只读工具Readonly

接收一个对象类型，并将这个对象类型的所有属性改为只读,即readonly

```javascript
//type Readonly<T> = { readonly [P in keyof T]: T[P]};
    //T 是一个对象类型。
    //P in keyof T 表示遍历 T 的所有属性键。
    //readonly 关键字使每个属性变为只读。

type User = {
  name: string;
  age: number;
  email: string;
};

type ReadonlyUser = Readonly<User>;

const user: User = {
  name: 'John Doe',
  age: 30,
  email: 'john.doe@example.com'
};

const readonlyUser: ReadonlyUser = {
  name: 'John Doe',
  age: 30,
  email: 'john.doe@example.com'
};

// 修改 user 对象的属性
user.name = 'Jane Doe';
user.age = 25;
user.email = 'jane.doe@example.com';

// 修改 readonlyUser 对象的属性
// readonlyUser.name = 'Jane Doe';  // 报错
// readonlyUser.age = 25;  // 报错
// readonlyUser.email = 'jane.doe@example.com';  // 报错
```

## 键值束缚工具Record

接收一个键和值的类型,限制键和值的类型

```javascript
//type Record<K extends keyof any, T> = {[P in K]: T};
    //K 是键的类型，必须是字符串、数字或符号。
    //T 是值的类型。

type UserProps = 'name' | 'job' | 'email';
//限制键的类型只能是'name' | 'job' | 'email'
type User = Record<UserProps, string>;

const user: User = {
  name: 'John Doe',
  job: 'fe-developer',
  email: 'john.doe@example.com'
};

//限制值的类型只能是'name' | 'job' | 'email',较常见
type Recordable<T = any> = Record<string, T>;
type User=Recordable<UserProps>
const user: User = {
  name: 'John Doe',
  job: 'fe-developer',
  email: 'john.doe@example.com'
};
```

## 属性提取工具Pick

提取一个对象类型中的部分属性及其类型

```javascript
//type Pick<T, K extends keyof T> = { [P in K]: T[P] };
    //T：这是你要从中挑选属性的对象。keyof T返回对象的属性组成的联合类型。
    //K：这是你要挑选的属性名的联合类型。
type User = {
  name: string;
  age: number;
  email: string;
  phone: string;
};
//interface User {
//  name: string
//  age: number
//  email: string
//  phone: string
//}

// 只提取其中的 name 与 age 信息
type UserBasicInfo = Pick<User, 'name' | 'age'>;

const userBasicInfo: UserBasicInfo = {
  name: 'John Doe',
  age: 30
};
```

## 属性排除工具Omit

排除掉对象类型中的部分属性及其类型

```javascript
//type User = {
//  name: string;
//  age: number;
//  email: string;
//  phone: string;
//};
interface User {
  name: string
  age: number
  email: string
  phone: string
}
type UserDetailedInfo = Omit<User, 'name' | 'age' | 'email'>;

const userDetailedInfo: UserDetailedInfo = {
  phone: '1234567890'
};
const userDetailedInfo: UserDetailedInfo = { name: '1234567890'}; //报错
```

## 差集提取工具Exclude

接收两个联合类型,返回两个类型的差集,即完全不同的部分

```javascript
type UserProps = 'name' | 'age' | 'email' | 'phone' | 'address';
type RequiredUserProps = 'name' | 'email';

// OptionalUserProps = UserProps - RequiredUserProps
type OptionalUserProps = Exclude<UserProps, RequiredUserProps>;

const optionalUserProps: OptionalUserProps = 'age' | 'phone' | 'address';
```

## 交集提取工具Extract

接收两个联合类型,返回两个类型的交集,即相同部分

```javascript
type UserProps = 'name' | 'age' | 'email' | 'phone' | 'address';
type RequiredUserProps = 'name' | 'email';

type RequiredUserPropsOnly = Extract<UserProps, RequiredUserProps>;

const requiredUserPropsOnly: RequiredUserPropsOnly = 'name' | 'email';
```

## 返回值提取工具ReturnType

接收一个函数类型,返回其返回值的类型

```javascript
const getPromise=():void=>{}
type res=ReturnType<typeof getPromise> // void
```

## promise结果获取工具Awaited

```javascript
// 定义一个函数，该函数返回一个 Promise 对象
const getPromise = (): Promise<string> => {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('Hello, World!')
    }, 1000)
  })
}

type Result = Awaited<ReturnType<typeof getPromise>> // string 类型
```

# 五种修饰符

## 访问修饰符

通过访问修饰符定义的成员最终都挂载在实例身上,在外部通过`实例.成员`访问,除私有外在类和子类中通过`this.成员`访问
1. public公有属性（默认值），可以通过类、子类和实例中访问和修改
2. protected受保护的属性 ，可以通过类、子类中访问和修改
3. private私有属性 ，可以在类中访问和修改 , 2022年js添加 `#`成员 代表私有属性

## 静态修饰符

static 该修饰符声明的属性叫静态成员

静态成员无需实例化，因为成员绑定在类自身 通过 `类名.属性` 访问

## 只读修饰符

readonly 只读属性 如果在声明属性时添加一个readonly，则属性便成了只读属性无法修改

## 用法示例

```javascript
class Person{
    修饰符 属性: 类型 = 值; // 类中什么都不写默认是public
}
type User = {
  修饰符 属性: 类型;
};
interface a{
    修饰符 属性: 类型;
}
```

# 继承

## 泛型的继承

```javascript
//使用K extends  keyof T表示泛型T必须keyof T的子类，keyof T表示T泛型中的所有可用属性键的联合类型
function getProperty<T, K extends keyof T>(obj: T, key: K) {
  return obj[key];
}

const person = { name: "Alice", age: 30 }; //keyof person-->'name'|'age'
const name = getProperty(person, "name"); // 正确
const age = getProperty(person, "address"); // 错误，因为 "address" 不是 person 对象的属性
```

## 接口的继承

```javascript
//接口2将具有接口1的所有类型限制
interface 接口1{}
interface 接口2 extends 接口1{}
```

## 类的继承

通过继承父类生成的类叫子类

```javascript
class 子 extends 父{
	constructor(prop){
		super(); //通过super触发父类构造器的同时,基于父类this对象构造自己的this对象(不会影响父类)
	}
}
```

# 函数

## 定义函数类型

两种定义方式

```javascript
//先定义变量的类型,再赋值函数
let fn:(参数x:类型,参数y:类型)=>返回值类型 = function(参数x,参数y){return x+y}

let fn:(参数x:类型,参数y:类型):返回值类型 = (参数x,参数y)=>{return x+y}

interface 接口{
    (参数x:类型,参数y:类型):返回值类型
}
let fn:接口=>(参数x,参数y)=>{return x+y}
```

## 剩余参数类型

剩余参数是一个数组,当作Array定义即可

```javascript
function(a:string,...rest:number[]){}
```

## 函数的重载

```javascript
//重载1
function add(a:number,b:string):string;
//重载2
function add(a:string,b:string):string;
function add(a:number|string,b:string):string{
    //满足条件使用重载1
    if(typeof a=='number'&&typeof b=='string'){
        return a+b;
    }
    //满足条件使用重载2
    if(typeof a=='string'&&typeof b=='string'){
        return a+b;
    }
}

```

# 泛型

用于给函数,接口和类定义类型

定义的时候不确定类型,使用的时候才确定

泛型（Generic）定义一个函数或类时，有些情况下无法确定其中要使用的具体类型（返回值、参数、属性的类型不能确定），此时泛型便能够发挥作用。

## 声明并使用泛型

使用<泛型>声明泛型

**与形参类似,定义时不确定,使用时确定**

```javascript
function test<T>(arg: T): T{
    return arg;
}
type Type{
    a:number,
    b:string
}
//使用时确定泛型的值
test<Type,string>({a:1,b:""})

```

  这里的

  使用泛型时,传入具体类型,泛型的类型被确定,所有使用该泛型的地方,都会指定为该类型

## 函数中的泛型

  可以同时指定多个泛型，泛型间使用逗号隔开：

```javascript
function test<T, K>(a: T, b: K): K{
    return b;
}
type Type{
    a:number,
    b:string
}
test<number, string>(10, "hello");
test<Type,string>({a:1,b:""},"")

```

## 类中的泛型

```javascript
class MyClass<T>{
    prop: T;
    constructor(prop: T){
        this.prop = prop;
    }
}
const numberBox = new MyClass<number>(42);

```

## 接口中的泛型

```javascript
interface 接口<T>{
    prop:T
}
const pair: 接口<number> = { prop: 1};

```

# 类

## 定义

```javascript
  class 类名 {
      属性名: 类型;
      constructor(参数: 类型){
          this.属性名 = 参数;
      }
      方法名(){
          ....
      }
  }

```

## 抽象类（abstract class）

抽象类是**专门用来被其他类所继承的类，它只能被其他类所继承不能用来创建实例**

```javascript
abstract class Animal{
    abstract run(): void;
    bark(){
        console.log('动物在叫~');
    }
}

class Dog extends Animals{
    run(){
        console.log('狗在跑~');
    }
}

```

  使用abstract开头的方法叫做抽象方法，抽象方法没有方法体只能定义在抽象类中，继承抽象类时抽象方法必须要实现

## 属性存取器

- 对于一些不希望被任意修改的属性，可以将其设置为private

- 直接将其设置为private将导致无法再通过对象修改其中的属性

- 我们可以在类中定义一组读取、设置属性的方法，这种对属性读取或设置的属性被称为属性的存取器

- 读取属性的方法叫做setter方法，设置属性的方法叫做getter方法

```javascript
    class Person{
        private _name: string;
    
        constructor(name: string){
            this._name = name;
        }
    
        get name(){
            return this._name;
        }
    
        set name(name: string){
            this._name = name;
        }
    
    }
    
    const p1 = new Person('孙悟空');
    console.log(p1.name); // 通过getter读取name属性
    p1.name = '猪八戒'; // 通过setter修改name属性

```

## 重写

发生继承时，如果子类中的方法会替换掉父类中的同名方法，这就称为方法的重写

在子类中可以使用super来完成对父类的引用

```javascript
class Animal{
    run(){
        console.log(`父类中的run方法！`);
    }
}

class Dog extends Animal{
    run(){
        console.log(`子类中的run方法，会重写父类中的run方法！`);
    }
}
const dog = new Dog();
dog.bark();

```

