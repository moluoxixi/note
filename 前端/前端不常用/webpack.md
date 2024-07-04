# 命令解析

```
cross-env NODE_ENV=development  webpack-dev-server --config src/common/config/webpack.config.dev.js  --progress --watch --colors --profile
```

我们分析如上命令:

1. cross-env

：

1. NODE_ENV=development

：这将环境变量

1. webpack-dev-server

：这是Webpack的开发服务器。它提供Webpack捆绑文件，并通常在开发过程中使用，以提供热重载和其他开发功能。

1. --config src/common/config/webpack.config.dev.js

：此标志指定Webpack用于开发构建的配置文件。在这种情况下，它指向

1. --progress

：此标志表示应在控制台中显示构建进度。它提供有关构建过程的反馈。

1. --watch

：此标志指示Webpack监视源代码的更改，并在检测到更改时自动重新编译。这是开发服务器的常见做法，以监视代码更改并在需要时触发重新构建。

1. --colors

：此标志启用控制台中的带颜色输出。它通过使用颜色来区分输出的不同部分，有助于使构建日志更易阅读。

1. --profile

：此标志告诉Webpack生成并显示构建配置文件。构建配置文件可以帮助您了解构建过程中花费时间的地方，这对优化构建时间很有用。

# 自定义插件

```
const MyCustomPlugin = require('./MyCustomPlugin');
​
module.exports = {
  // ...其他配置...
  plugins: [
    new MyCustomPlugin({ option1: 'value1', option2: 'value2' })
  ]
};
```

```
export default class MyCustomPlugin {
  //options接受new该插件时传入的配置项
  constructor(options = {}) {}
  apply(compiler) {}
}
​
//apply在插件实例被创建时触发,结构如下:
//apply->{
//  options:webpack的配置,例如entry,output
//  hooks:一个对象,包括所有webpack的钩子
//  ...
//}
```

# webpack介绍

## webpack运行过程

告诉webpack打包的起点        ===>入口文件

分析依赖关系图,根据顺序依次将资源引入形成代码块(chunk)

将代码块进行各项处理,比如将less解析成css        ===>这一过程称为打包

将处理好的东西输出,输出的东西称为 bundle        ==>打包生成静态资源

## 常用配置项

```
module.exports = {
    //入口,可以配置多个入口
    entry: {
      main: './src/main.js',
      app: './src/app.js'
    },
    //出口
    output: {
      filename: '[name].bundle.js', //name对应entry中的main/app
      path: path.resolve(__dirname, 'dist')
    },
    //告诉webpack应该如何解析模块
    resolve:{
        ////用于配置 Webpack 模块的查找目录。默认Webpack会从当前目录的 node_modules文件夹中查找模块
        modules:['node_modules', 'src/vendor'], 
        //用于配置可以省略文件扩展名的文件,webpack会自动补全
        extensions:['.js', '.jsx', '.json', '.vue'],
        //用于创建路径别名
        alias:{
            '@': path.resolve(__dirname, 'src'),
        },
    },
    //指定哪些模块不被打包,而由外部提供
    externals:{
        // 键是库名，值是全局变量名
        vue : 'var window.Vue',
        vuex : 'var window.Vuex',
    },
    //配置输出的优化策略
    optimization:{
        minimize:true, //是否启用代码压缩,如果配置了gzip则不需要
        //配置代码分割策略,具体配置参考性能优化md
        splitChunks:{}
    },
    //指定模块的处理方式
    mode:{
        rules:[
            {
               test: /\.css$/,// 匹配需要处理的文件
               exclude: /node_modules/, // 排除的文件夹
               use: ['style-loader', 'css-loader'] //规定使用哪些loader,顺序从右到左,从下到上
            },
            {
                test: /\.js$/, // 匹配需要处理的文件
                use: {
                    loader: 'babel-loader',
                    //loader配置
                    options: {
                        //指定@babel/preset-env作为babel-loader的预设,让它可以解析js特性
                        presets: ['@babel/preset-env']
                    }
                }
            },
        ]
    },
    //指定使用哪些插件
    plugins:[]
}
```

## webpack五个核心概念

| 五个核心概念 | 叫法 | 作用 | 
| -- | -- | -- |
| Entry | 入口 | 打包时，第一个被访问的源码文件，指示 webpack 应该使用哪个模块（webpack中一切都是模块），来作为构建其内部依赖图的开始。 webpack可以通过入口,加载整个项目的依赖,默认是src/index.js | 
| output | 出口 | 打包后输出到哪个文件夹中,默认是dist/main.js | 
| loader | 加载器 | 将非js资源处理成webpack能识别的资源(js资源), | 
| plugin | 插件 | 执行更加强大的功能,比如压缩等 | 
| module | 模式 | 指示webpack使用本地运行调试的环境(development)还是代码优化上线运行的环境(production) | 


## 什么是构建工具

如果想解析ts,less等,需要一个个小的工具,非常麻烦,于是前端提出了一种概念,把这些小的工具集成成一种大的工具,称之为构建工具,

webpack是一种构建工具,(静态模块打包器)

# 错误

unable to locate

路径错误

# webpack使用流程

## 初始化 package.json 

输入指令: 

npm init

输入webpack包名,然后疯狂回车

## 下载并安装 webpack 和Jquery

输入指令: 

```
npm install webpack webpack-cli -g //下载webpack和webpack-cli并安装到全局,webpakc-cli可以让我们通过指令使用webpack;
​
npm install webpack webpack-cli -D //本地安装
//使用本地安装的webpack-cli,运行时,需要使用npx webpack
```

```
npm  i  jquery            //通过import $ from 'jquery'引入
```

## 本地安装的webpack-cli注意

```
使用本地安装的webpack-cli,运行时,不能直接使用webpack指令,需要使用npx webpack指令
```

## 1.新建各种文件

### 新建src和build文件夹

- src    ==> 项目的源代码目录

- build  ==>通过webpack打包处理后输出的目录

### 在src下新建index.js

- index.js  ==>入口起点文件

## 2.运行打包指令

### 开发环境指令：

```
webpack src/js/index.js -o build/js --mode=development 
```

#### 代码解析:

webpack会以 src/js/index.js为入口文件开始打包,打包后会build/js目录下新建main.js,并将打包后的内容输出到main.js文件中

--mode指定整体打包环境为开发环境

#### 功能：

webpack 能够编译打包 js 和 json 文件，并且能将 es6 的模块化语法转换成浏览器能识别的语法。 

### 生产环境指令：

```
webpack src/js/index.js -o build/js --mode=production 

```

#### 代码解析:

webpack会以 src/js/index.js为入口文件开始打包,打包后会build/js目录下新建main.js,并将打包后的内容输出到main.js文件中

--mode指定整体打包环境为生产环境

#### 功能：

在开发配置功能上多一个功能，压缩代码。 

### 终端输出结果需注意项:

hash:  打包后输出的结果,每次打包时都会生成一个唯一的hash值

### 结论

webpack 能够编译打包 js 和 json 文件。 

能将 es6 的模块化语法转换成浏览器能识别的语法。 

能压缩代码。 

### 问题

不能编译打包 css、img 等文件。 

不能将 js 的 es6 基本语法转化为 es5 以下语法。 

## 3.创建配置文件 

### 创建webpack配置文件

作用:指示webpack应该干什么

### 配置内容如下 

```
//resolve 用来拼接绝对路径的方法
const {resolve}=require('path');
module.exports={
    //入口
    entry:'./src/js/index.js',
    // 输出
    output:{
        //文件名
        filename:'built.js',
        //js文件被node启动时,这个js文件被称作一个模块
        //__dirname是node.js创建模块时所传入的参数,代表当前文件所在文件夹的绝对路径
        //打包后输出的目录,会在xxx/build/js文件夹下新建main.js,并将打包后的内容输出到main.js文件中
        path:resolve(__dirname,'build/js'),
        //查找路径默认相对于出口目录(可选),可用于多级路由不再相对于上一级路由而是相对于/
        publicPath:'/'
    },
    //loader的配置
    module:{
        rules:[
            //详细loader配置
            // 不同文件必须配置不同 loader 处理 
            {
                // 匹配符合正则规则的所有文件
                test:正则(不用加引号),
                //使用哪些 loader 进行处理
                //使用多个loader模块用use:[],
                //使用一个loader模块用loader:
                // use 数组中 loader 执行顺序：从右到左，从下到上 依次执行
                use:[
                    '模块1',
                    ...
                    '模块n'
                ]
            }
        ]
    },
    //plugins的配置(插件)
    plugins:[
        // plugins的详细配置
    ],
    //模式配置
    //开发环境
    mode:'development', 
    //生产环境
    // mode:'production'
}

```

### 运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

### 结论: 此时功能与上节一致

## 4.打包css

### 将css打包成js

#### 1.将需要打包的样式文件引入到入口文件中(index.js)

```
//引入样式资源
import './index.css'

```

#### 2.下载安装 loader 包 

```
//安装到开发环境中
//less包用于让webpack能识别less资源,xxx-loader包用于解析xxx资源
npm i css-loader style-loader less-loader less -D

```

#### 3.在webpack配置文件中的loader配置模块中进行配置

```
module: { 
    rules: [ 
    { 
        test: /\.css$/,        //匹配以.css结尾的所有文件 
        use: [ 
            // 创建 style 标签，将 js 中的样式资源插入进行，添加到 head 中生效 
            'style-loader', 
            // 将 css 文件变成 commonjs 模块加载到js 中，里面内容是样式字符串 
            'css-loader' 
        ] 
    },
    { 
        test: /\.less$/, 
        use: [
            //将样式解析为js代码(生成一个style标签)
            'style-loader', 
            'css-loader', 
            // 将 less 文件编译成 css 文件 
            // lessloader模块需要下载 less-loader 和 less 
            'less-loader' 
        ]
    }] 
},

```

#### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 将css打包成独立的文件

#### 1.下载安装 plugin 包

```
npm i mini-css-extract-plugin -D

```

#### 2.在webpack.config.js配置文件中引入mini-css-extract-plugins模块

```
const{miniCssExtractPlugin}=require('mini-css-extract-plugin');

```

#### 3.在webpack配置文件中的plugins配置模块中进行配置

```
plugins: [ 
// plugins 的配置 
// mini-css-extract-plugin 
// 功能：将css单独打包后输出到指定目录
    new miniCssExtractPlugin({ 
        //输出后的文件名保持与原文件同名
        // [name]取图片本来的名字
        // [ext]取文件原来扩展名
        //相对于出口文件所在文件夹
        filename: "css/[name].css"
        //是否删除冲突警告
        ignoreOrder:true/false
    })
]

```

#### 4.在webpack配置文件中的loader配置模块中进行配置

```
module: {
    rules: [{
        test: /\.css$/,
        use: [
            //提取js中的css成单独文件 
            {
                loader: MiniCssExtractPlugin.loader,
                options: {
                    //指定打包后的输出目录,默认是出口文件目录
                    publicPath: "输出目录",
                },
            },
            //将 css文件整合到js文件中
            "css-loader",
            "less-loader"
        ],
    }]
},

```

#### 5.运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 5.打包HTML资源 

### 1.下载安装 plugin 包 

```
npm i html-webpack-plugin -D

```

### 2.在webpack配置文件中引入html-webpack-plugins模块

```
const{HtmlWebpackPlugin}=require('html-webpack-plugin');

```

### 3.在webpack配置文件中的plugins配置模块中进行配置

```
plugins: [ 
// plugins 的配置 
// html-webpack-plugin 
// 功能：默认会创建一个空的 HTML，自动引入打包输出目录的所有资源（JS/CSS） 
    new HtmlWebpackPlugin({ 
        // 参考模板,在创建的空HTML中复制  template指定的 文件
        template:path.resolve(__dirname, "../public/index.html"),
        //压缩
        minify: {
            //清理html中的空格、换行符
            collapseWhitespace: true,
            keepClosingSlash: true,
            //清理html中的注释
            removeComments: true,
            removeRedundantAttributes: true,
            removeScriptTypeAttributes: true,
            removeStyleLinkTypeAttributes: true,
            useShortDoctype: true
        }
    })
]

```

### 4.运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包图片资源

### 打包以模块方式引入的图片

import dog from './image/01.jpg'

#### 1.在webpack配置文件中的loader配置模块中进行配置

```
module: { 
    rules: [{
        test: /\.(png|jpg|gif|svg)$/,
        //asset 在导出一个 data URI 和发送一个单独的文件之间自动选择。代替之前的url-loader和file-loader
        type: "asset",
        parser: {
            dataUrlCondition: {
            // base64优点: 减少请求数量（减轻服务器压力） 
            // base64缺点：图片体积会更大（文件请求速度更慢） 
            //小于15kb以下的图片会被打包成base64格式
                maxSize: 30 * 1024, 
            },
        },
        generator: {
            // 给图片进行重命名
            // [name]取图片本来的名字
            // [ext]取文件原来扩展名
            //相对于出口文件所在文件夹
            filename: 'images/[name][ext]'

        }
    }]
}

```

#### 2.运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 打包html中引入的图片

#### 1.在webpack配置文件中的loader配置模块中进行配置

```
module: { 
    rules: [{
        test: /\.(htm|html)$/i,
        use: {
            loader: 'html-loader'
        }
    }]
}

```

#### 2.运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 打包css中引入的图片

#### 1.下载安装 plugin 包

```
npm i mini-css-extract-plugin -D

```

#### 2.在webpack.config.js配置文件中引入mini-css-extract-plugins模块

```
const{miniCssExtractPlugin}=require('mini-css-extract-plugin');

```

#### 3.在webpack配置文件中的loader配置模块中进行配置

```
module: { 
    rules: [{
        loader: MiniCssExtractPlugin.loader,
        options: {
            publicPath: '../'
        }
    }]
}

```

#### 2.运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包字体文件

### 1.在webpack配置文件中的loader配置模块中进行配置

```
module: { 
    rules: [{
        test: /\.(eot|svg|ttf|woff|woff2)$/i,
        //asset/resouce:发送一个单独的文件并导出URL（之前通过file-loader实现）
        type: 'asset/resource',
        generator: {
            // [name]取图片本来的名字
            // [ext]取文件原来扩展名 
            //相对于出口文件所在文件夹
            filename: 'font/[name][ext]'
        }
    }]
}

```

### 2.运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包公共资源

### 下载安装 plugin 包

作用就是将某文件或某文件夹下的文件复制到指定目录下

```
npm i copy-webpack-plugin -D

```

### 在webpack配置文件中的plugins配置模块中进行配置

```
plugins:[
    new CopyWebpackPlugin({
        patterns:[{
            //从某路径开始复制
            from: path.resolve(__dirname, "../public"),
            //复制到某路径,相对于出口目录
            to: "public"
        }],
        //额外配置
        globOptions:{
            //不能将文件忽略到没用需要拷贝的文件
            //配置拷贝时忽略的文件,**代表form的路径
            ignore:['**/index.html']
        }
    })
]

```

### 运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 每次打包前删除之前的打包文件

### 下载安装 plugin 包 

```
npm i clean-webpack-plugin -D

```

### 引入

```
const {CleanWebpackPlugin}= require('clean-webpack-plugin');

```

### 在webpack配置文件中的plugins配置模块中进行配置

```
plugins:[
    new CleanWebpackPlugin()
]

```

### 运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 7.打包除css|js|html|less之外的资源

### 1.下载安装 plugin 包 

```
npm i html-webpack-plugin -D

```

### 2.在webpack配置文件中引入path模块和html-webpack-plugin模块

```
const {resolve} = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

```

### 3.在webpack配置文件中的loader配置模块中进行配置

```
module: {
    rules: [
        {
            test: /\.css$/,
            use: ['style-loader', 'css-loader']
        },
        // 打包其他资源(除了 html/js/css 资源以外的资源) 
        {
            // 排除 css/js/html 资源 
            exclude: /\.(css|js|html|less)$/,
            loader: 'file-loader',
            options: {
                // 给资源进行重命名 
                // [hash:10]取资源的 hash 的前 10 位 
                // [ext]取文件原来扩展名 
                name: '[hash:10].[ext]'
            }
        }
    ]
},

```

### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## 打包ejs

### 下载loader包

```
npm i ejs-loader -D

```

### 在webpack配置文件的loader模块中配置

```
module:{
    rules:[{
      test:/\.ejs$/i,
      //不能使用use,use无法使用options配置
      loader:'ejs-loader',
      options:{
        //让ejs可以使用data代表传入ejs模块的参数
        variable:'data'
      }
    }]
}

```

## js 语法检查 

### 1.下载安装包 

- eslint 检验js代码格式的工具

- eslint-config-airbnb-base：最流行的js代码格式规范

- eslint-webpack-plugin：webpack中使用eslint

- eslint-plugin-import：用于在package.json中读取eslintConfig的配置

```
npm i eslint eslint-config-airbnb-base eslint-webpack-plugin eslint-plugin-import -D

```

### 2.webpack配置文件中引入

```
const ESLintPlugin = require('eslint-webpack-plugin')

```

### 2.在webpack配置文件中的plugins模块中进行配置

```
module: { 
    rules: [ 
    //语法检查： eslint-loader eslint 
    //注意：只检查自己写的源代码，第三方的库是不用检查的 
        { 
            test: /\.js$/, 
            exclude: /node_modules/, 
            loader: 'eslint-loader', 
            options: { 
            //自动修复 eslint 的错误,只能修复一些简单的错误,比如没打分号
                fix: true 
            } 
        } 
    ] 
},

```

### 3.配置 package.json 

```
设置检查规则： package.json中eslintConfig中设置
"eslintConfig": { 
    "extends": "airbnb-base", 
    "env": { 
        "browser": true 
    } 
}

```

### 4.运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## js 兼容性处理 

### 1.下载安装包 

```
npm install --save-dev babel-loader @babel/core @babel/preset-env @babel/polyfill core-js 

```

### 2.在webpack配置文件的loader模块中配置

- @babel/preset-env只能转义基本语法（promise不能转换）

- @babel/polyfill（转换所有js语法）

- npm i @babel/polyfill -D

- import '@babel/polyfill'

(入口文件中引入)

```
module: { 
    rules: [{ 
        test: /\\.m?js$/, 
        exclude: /node_modules/, 
        loader: 'babel-loader', 
        options: { 
            // 预设：指示 babel 做怎么样的兼容性处理 
            presets: [ 
                [ 
                '@babel/preset-env', 
                { 
                // 按需加载 
                    useBuiltIns: 'usage', 
                    // 指定 core-js 版本 
                    corejs: { 
                        version: 3 
                    },
                    // 指定兼容性做到哪个版本浏览器 
                    targets: { 
                        chrome: '60', 
                        firefox: '60', 
                        ie: '9', 
                        safari: '10', 
                        edge: '17' 
                    } 
                }] 
            ] 
        } 
    }] 
},

```

### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

## webpack额外配置

### 配置默认识别的后缀和路径别名

#### 在webpack配置文件中添加新的配置模块

```
// 解析模块的规则 
resolve:{
    //按照顺序依次解析这些后缀名的文件,如果有同名但后缀不同的,只用第一次解析的
    extensions: [".js", ".json", ".ejs", ".html"],
    alias:{
        //给绝对路径起一个别名,可以直接用别名代替该绝对路径
        $v:path.resolve(__dirname,"../src/views")
    }
    // 告诉 webpack 解析模块是去找哪个目录 
    modules: [path.resolve(__dirname, '../../node_modules'), 'node_modules'] 
}

```

### 自动编译

#### 安装

```
npm i webpack-dev-server -D

```

#### 在webpack配置文件中添加新的配置模块

```
devServer: {
  port: 8080, // 端口号
  open: true,  // 自动打开浏览器
  compress: true, //启动gzip压缩
  liveReload:true,//启动自动更新
  historyApiFallback:true,    //启动history路由模式
  host:'localhost'    //域名
}

```

#### 运行指令:

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 压缩css

#### 安装

```
npm i css-minimizer-webpack-plugin

```

#### 引入

```
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin")
```

#### 在webpack中添加新的配置模块

```
 optimization: {
    minimizer: [
      new CssMinimizerPlugin(),
    ],
    //在开发环境下启用CSS压缩
    minimize: true
  },
```

#### 运行指令: 

全局安装的webpack-cli使用webpack命令

本地安装的webpack-cli使用npx webpack命令

自定义配置文件名使用

npx webpack --config ./config/webpack.config.prod.js(自定义配置文件名)

### 配置入口和资源的最大文件大小,忽略性能提示

```
  performance: {
    hints: 'warning', // 枚举 false关闭
    maxEntrypointSize: 100000000, // 最大入口文件大小
    maxAssetSize: 100000000, // 最大资源文件大小
    assetFilter: function (assetFilename) { //只给出js文件的性能提示
      return assetFilename.endsWith('.js');
    }
  }
```

### 配置代理服务器

**服务器向服务器发送请求不受同源策略限制**

**代理服务器代替用户访问目标服务器**

在webpack或各种脚手架中配置代理

```
//客户端请求:客户端域名/约定路由/要请求的路由
//服务器:服务端域名/要请求的路由
​
​
​
devServer:{
    //可以写多个代理
    proxy:{
        //约定,使用 域名/约定路由 开头的请求将会使用代理服务器
        '/约定路由1':{
            //代理服务器需要访问的目标服务器,遇到约定路由会请求目标服务器(以 代理服务器域名/约定路由/要请求的路由 的方式请求)
            target:'协议://ip:端口',
            //将 /约定路由 替换为"",使不带约定路由的请求可以使用该代理(以 代理服务器域名/要请求的路由 的方式请求)
            pathRewrite:{
                //以某某约定路由开头会替换为""开头
                '^/约定路由':""
            }
        },
        ...
    }
}
```