```
{
  /*
        //tsconfig.json是ts编译器的配置文件，ts编译器根据它的配置来编译ts文件
    "include"用来指定 哪些ts文件/文件夹内的ts文件 要进行编译
    "exclude"用来指定 哪些ts文件/文件夹内的ts文件 不需要编译
        //默认值 ["node_modules","bower_components","jspm_packages"]
        
    "extends" 用于继承另一个tsconfig.json文件的配置
    
    "files"指定需要被解析的ts的文件,注意:是.ts文件
*/
    写法示例:
    // "include": ["./index.ts","./test.ts"]  //表示这两文件
    //一般使用下面的做法
    "include": ["./src/*"],  //'*'表示任意文件 。'**'表示任意文件夹
    // "exclude": ["./src/index.ts"],  //表示不对index.ts文件进行编译
    // "files": []
​
/*
      
  "compilerOptions": {
    "target": "ES6",
    "module": "system",
    // "lib": [],
    "outDir": "./dish",
    "outFile": "./dish/app.js",
    "allowJs": false,
    "checkJs": false,
    "removeComments": false,
    "noEmit": false,
    "noEmitOnError": true,
    "alwaysStrict": true,
    "noImplicitAny": true,
    "noImplicitThis": true,
    "strictNullChecks": true,
    "strict": false,
    "composite": false,//指定项目是否为子项目
    "jsx": "preserve",//指定jsx的处理方式,preserve保留不处理
  },
}
```

## compilerOptions

### target

指定要编译的ts文件编译成什么版本的js，默认是ES3（原因是它老，所有的浏览器多兼容）,在ES3中会将let编译成var

  而在ES6版本中let将会编译成let，ESNext表示最新版本的ES

```
"target": "ES6",
```

### module

指定使用什么个是来进行，模块化，它有这几个值：

'none', 'commonjs', 'amd','system', 'umd', 'es6', 'es2015', 'es2020', 'es2022', 'esnext', 'node12', 'nodenext'. 

es6与es2015是一样的

```
module:"system"
```

### allowJs

指定是否编译js文件，在任意文件当中* 如果我们模块使用js写的，那么我们需要将allowJs设置为true,默认为false

### checkJs

检查js是否符合js语法,默认为false，checkJs与allowJs一般是一起用的

### removeComments

是否移除注释，默认false

### alwaysStrict

（strict严格的）js有一种严格模式，也就是比之前的语法更加严谨  浏览器运行的效率更好，我们在单独的js文件中在文件开头部分添加一个“use strict”  表示了我们开启了js的严格模式，而在ts中使用alwaysStrict来进行开启，默认为false  12.noImplicitAny（implicit：隐式）检查隐式的any类型，我们不提倡使用any类型，更不提倡使用隐式的any  此时我们可以将noImplicitAny改为true来对隐式的any类型进行检查  13.noImplicitThis检查不明确的this类型，我们知道在单独的函数（也就是函数外边没有指定以的对象）时  在函数体调用this,这个this指向window，当我们在指定以对象的里面调用this,此时这个this指向我们定义  的对象，  比如：  function fn(this){    alert(this)  }  若是函数是在指定义对象外调用，这this指向window  若是函数是在指定义对象里面调用，这this指向这个对象  此时我们可以在函数的形参部分进行声明明确的类型  function fn(this: window){    alert(this)  }

### strictNullChecks

 严格的检查空值，默认为false

### strict

是所有严格检查的总开关，默认false，一般开发打开

```
"target": "ES6",
```

### alwaysStrict

（strict严格的）js有一种严格模式，也就是比之前的语法更加严谨浏览器运行的效率更好，我们在单独的js文件中在文件开头部分添加一个“use strict”表示了我们开启了js的严格模式，而在ts中使用alwaysStrict来进行开启，默认为false

```
alwaysStrict:"false",
```

### types

用来指定需要包含的模块，只有在这里列出的模块的声明文件才会被加载进来。

默认情况下，

### composite

指定项目是否为子项目

```
"composite": false,
```

### jsx

指定jsx的处理方式,preserve保留不处理

```
"jsx": "preserve",//指定jsx的处理方式,preserve保留不处理
```

### 很少见

#### noEmitOnError

当有错误时不生成文件，默认为false

#### outDir

指定编译后的文件输出的目录

```
 "outDir": "./dish",
```

#### noEmit

编译但不产生编译后的代码，这个一般使用在不想使用tsc编译生成代码，只想使用它来检查一下代码是否有错，默认为false

#### lib

(libary库)指定项目中要使用的库,一般情况下不需要去更改

#### outFile

将多个相互依赖的文件生成一个文件,可以用在 

```
"outFile": "./dish/app.js",
```

### 