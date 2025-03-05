---
title: vue原理
description: 一个vue原理笔记
date: 2025-03-05
hidden: false
tags:
  - vue原理
ptags:
  - vue
---
## 原理
### MVVM 与 MVC

```javascript
//MVC
Model-View-Constroller
    Model代表数据模型,定义数据操作及业务逻辑
    View代表视图层,也就是前端页面
    Constroller 控制层,接收view层的操作调用Model层的逻辑
    
//MVVM
Model-View-ViewModel,
    是MVC的升级版,Model与View层都相同,不同是ViewModel层
    ViewModel 视图模型层 作为中间人,同步Model与View,像翻译一样，把Model的数据翻译成View能理解的语言并绑定到View上,当用户与视图进行交互时，视图模型会处理用户输入并更新模型中的数据。
```


### 响应式原理

```js
//总结:
-->vue2调用beforeCreate钩子,
-->初始化阶段代理和劫持，vue2 defineProperty,vue3 proxy
-->vue2调用created钩子,
-->vue3调用setup函数，在调用过程中，再执行代理和劫持，setup script会在vite插件的作用下，解析为setup函数

-->解析配置项，创建Watcher,分为:
		-->每个组件的渲染Watcher,computed计算属性Watcher,
		-->watch侦听器Watcher,
		-->$watch(vue2)/watch函数(vue3)创建的Watcher,
-->编译阶段解析指令->AST抽象语法树->遇动态绑定创建Dep并注入当前组件的watcher中(依赖收集)
	complier 主要分为 3 大块：
	parse：接受 template 原始模板，按着模板的节点和数据生成对应的 ast
	optimize：遍历 ast 的每一个节点，标记静态节点，这样就知道哪部分不会变化，于是在页面需要更新时，通过 diff 减少去对比这部分DOM，提升性能
	generate 把前两步生成完善的 ast，组成 render 字符串，然后将 render 字符串通过 new Function 的方式转换成渲染函数
-->渲染阶段，生成vNode树，diff比较，开始渲染,读取响应式属性时，将dep存于Watcher的deps中，watcher存于dep的subs中
-->更新阶段，触发set,Watcher的dep依赖比较，再次执行渲染阶段
​
Vue响应式的核心分为三大模块:Obsever,Compile,Watcher
​
​数据劫持:
	初始化阶段Obsever将数据 深度代理+劫持,3用proxy

数据监测:
	创建Watcher进行检测,
		组件渲染Watcher,监听组件data、computed等选项中的响应式数据的变化,
		computed计算属性Watcher,
		watch侦听器Watcher,
		$watch创建的Watcher,

依赖收集:
	依赖即dep,利用dep连接Obsever和Watcher,
	编译阶段,调用compile解析指令，生成AST抽象语法树,
		每遇到一个动态绑定就创建一个dep对象，
		解析完毕后生成渲染函数

	渲染阶段读取这个动态绑定的属性时，触发proxy,将dep存到使用到的Watcher对象中
	触发mounted钩子

派发更新:
	Watcher的deps数组存dep, dep的subs数组存watcher
	数据更新触发代理,对比两个Watcher中deps(存dep)变化,
	变化了就把dirty设置为true更新,
	触发update钩子,
	通过`watcher.update`调用渲染函数，生成新的vNode树(虚拟dom)

diff阶段:
	比较新旧虚拟dom变化，触发视图更新
​
Watcher
收集依赖,通知视图更新
```

![](./images/WEBRESOURCE75b04692a14bb8baedd5f5d53d6b3092截图.png)

### nextTick 作用及原理

```js
作用：vue 更新 DOM 是异步更新的，数据变化，DOM 的更新不会马上完成，nextTick 的回调是在下次 DOM 更新循环结束之后执行的延迟回调。
实现原理：
​
nextTick会将通知视图更新的函数和$nextTick的回调放在callbacks队列中,在一次异步任务中顺序执行,
例如我们在vue中同时执行修改动态数据和调用$nextTick在回调中修改动态数据,修改动态数据和$nextTick的回调会在一次异步任务中执行,
$nextTick的回调导致的动态数据修改会被推入下一个异步任务中执行
​
inputHanlder(e){
    this.$nextTick(()=>{
        this.b+=1;
        console.log('aaa',this.b);
    });
    this.b+=3;
    console.log('bbb',this.b);
}
//异步环境
Promise
MutationObserver
setImmediate
setTimeout
```

### computed 原理

```js
beforeCreate阶段会遍历所有计算属性并为他们单独创建lazy模式的Watcher,当我们首次使用这个计算属性时,会执行Watcher传入的函数,会收集依赖(读取动态属性触发get,将Watcher存在dep中,将dep存在Watcher中),并通过value存储计算的值和dirty判断依赖是否变化
​
当组件实例触发 beforeCreate 后，会对 computed 进行处理。
​
//遍历computed,为每个计算属性创建watcher用于收集依赖和通知变化,并传入一个函数,这个函数本质上是计算属性的get
​
它会遍历 computed 配置中的所有属性，为每一个属性创建一个 Watcher 对象，并传入一个函数，
​
//该函数的作用是收集依赖,计算结果
​
该函数的本质其实就是 computed 配置中的 getter，这样一来，getter 运行过程中就会收集依赖
但是和渲染函数不同，为计算属性创建的 Watcher 不会立即执行，因为要考虑到该计算属性是否会被渲染函数使用，如果没有使用，就不会得到执行。
​
//利用lazy配置项开启watcher的懒监视
//懒监视会启用dirty和value两个属性,value用于保存计算后的结果,dirty代表依赖是否变化
//首次绑定计算属性时,会触发计算属性的get,收集依赖,返回计算结果,并将结果保存在value中
//当依赖变化时,比较依赖的值是否变化,
    //变化会修改dirty为true,等待再次获取计算属性时,重新触发A函数,将dirty设为false,收集依赖,返回计算结果,更新value的值
    //没变化时,不会修改dirty的值,等待再次获取计算属性时,直接返回value
​
因此，在创建 Watcher 的时候，它使用了 lazy 配置，lazy 配置可以让 Watcher 不会立即执行。
收到 lazy 的影响，Watcher 内部会保存两个关键属性来实现缓存，一个是 value，一个是 dirty
value 属性用于保存 Watcher 运行的结果，受 lazy 的影响，该值在最开始是 undefined
dirty 属性用于指示当前的 value 是否已经过时了，即是否为脏值，受 lazy 的影响，该值在最开始是 true
Watcher 创建好后，vue 会使用代理模式，将计算属性挂载到组件实例中
当读取计算属性时，vue 检查其对应的 Watcher 是否是脏值,即dirty是否为true，如果是，则运行函数，计算依赖，并得到对应的值，保存在 Watcher 的 value 中，然后设置 dirty 为 false，然后返回。
如果 dirty 为 false，则直接返回 watcher 的 value
巧妙的是，在依赖收集时，被依赖的数据不仅会收集到计算属性的 Watcher，还会收集到组件的 Watcher
当计算属性的依赖变化时，会先触发计算属性的 Watcher 执行，此时，它只需设置 dirty 为 true 即可，不做任何处理。
由于依赖同时会收集到组件的 Watcher，因此组件会重新渲染，而重新渲染时又读取到了计算属性，由于计算属性目前已为 dirty，因此会重新运行 getter 进行运算
而对于计算属性的 setter，则极其简单，当设置计算属性时，直接运行 setter 即可。
```

### compile 原理

```js
complier 主要分为 3 大块：
parse：接受 template 原始模板，按着模板的节点和数据生成对应的 ast
optimize：遍历 ast 的每一个节点，标记静态节点，这样就知道哪部分不会变化，于是在页面需要更新时，通过 diff 减少去对比这部分DOM，提升性能
generate 把前两步生成完善的 ast，组成 render 字符串，然后将 render 字符串通过 new Function 的方式转换成渲染函数
```

### keep-alive 原理

```js
keep-alive维护一个 key 数组和一个缓存对象
​
key 数组记录目前缓存的组件 key 值，如果组件没有指定 key 值，则会为其自动生成一个唯一的 key 值
​
cache 对象以 key 值为键，vnode 为值，用于缓存组件对应的虚拟 DOM
​
在 keep-alive 的渲染函数中，其基本逻辑是判断当前渲染的 vnode 是否有对应的缓存，如果有，从缓存中读取到对应的组件实例；如果没有则将其缓存。
当缓存数量超过 max 数值时，keep-alive 会移除掉 key 数组的第一个元素。
```

### SSR 原理

```js
//看性能优化中的SSR
VueSSR 的原理，主要就是通过 vue/server-renderer 把 Vue 的组件输出成一个完整 HTML，输出到客户端，到达客户端后重新展开为一个单页应用。
​
app.js 作为客户端与服务端的公用入口，导出 Vue 根实例，供客户端 entry 与服务端 entry 使用。客户端 entry 主要作用挂载到 DOM 上，服务端 entry 除了创建和返回实例，还需要进行路由匹配与数据预获取。
​
webpack 为客服端打包一个 ClientBundle，为服务端打包一个 ServerBundle。
服务器接收请求时，会根据 url，加载相应组件，获取和解析异步数据，创建一个读取 Server Bundle 的 BundleRenderer，然后生成 html 发送给客户端。
​
客户端混合，客户端收到从服务端传来的 DOM 与自己的生成的 DOM 进行对比，把不相同的 DOM 激活，使其可以能够响应后续变化，这个过程称为客户端激活（也就是转换为单页应用）。为确保混合成功，客户 端与服务器端需要共享同一套数据。在服务端，可以在渲染之前获取数据，填充到 store 里，这样，在客户端挂载到 DOM 之前，可以直接从 store 里取数据。首屏的动态数据通过 window.INITIAL_STATE 发送到客户端
```

### vue 是如何保障生命周期钩子顺序执行的
```
```
### 数据频繁变化为毛只更新一次

```js
//(这就是只会更新一次的原因,因为一个组件的更新函数只会对应一个watcher,watcher被去重后,只会导致一次更新,例如更新数据)
因为vue将所有watcher存在queue队列,而同一个watcher只会被推入一次,
​
//由于更新函数和nextTick的回调在两个函数中,如果nextTick的回调在更新函数之后,也就是数据更新之后,会导致更新多次
等待本次微任务执行完毕后,在微任务环境下callbacks队列中遍历执行所有的nextTick回调,以及视图更新函数
```

### 每个生命周期阶段做了什么

```
//在beforeCreate-created阶段进行初始化计算属性,数据代理,数据劫持
初始化计算属性
遍历computed中的所有计算属性,为每个计算属性new watcher,并传入函数(这个函数本质上是计算属性的get),和lazy配置项
​
数据代理
将data中的所有属性,所有计算属性和$attrs,$listeners代理到组件实例身上
​
数据劫持
将data,$attrs,$listeners进行深度代理,为其中的每个属性创建dep实例,每个dep中维护subs队列存储watcher用于通知依赖更新
在3中采用Proxy实现Obsever,但是Proxy只能代理一层操作,内部会判断如果是对象/数组的话,会进行深层代理处理
​
//在created-beforeMount阶段进行模板解析和编译渲染函数
//从created阶段可以开始操作数据,created阶段操作不会触发update,用于数据初始化
模板解析
根据template或者render函数中的dom结构生成虚拟DOM,将挂载点对应的虚拟dom赋值给$el
    
编译渲染函数
根据虚拟DOM编译渲染函数,new Watcher的同时传入渲染函数
​
//在beforeMount-mounted阶段进行依赖收集
//从mounted开始可以访问真实dom
依赖收集
调用渲染函数,当读取响应式属性时,触发代理,通过dep的subs队列将编译阶段的watcher存储起来
当读取计算属性时,触发代理,通过dep的subs队列将计算属性对应的watcher存储起来,并调用计算属性的get将计算结果存在value中
​
//在beforeUpdate-updated阶段进行计算属性重计算和视图更新
计算属性重计算
当依赖变化时,触发计算属性对应的watcher,比较依赖的值是否变化,变化则修改dirty为true
​
视图更新
依赖变化时,调用渲染函数,经过diff比较后进行视图更新,
更新过程中遇到计算属性,
    如果dirty是true,调用计算属性的get,然后将dirty设为false,重新收集依赖,计算结果后保存到value中
    如果dirty是false,读取value
```

### data 为毛得是函数

```
避免组件复用时,重复使用data中的对象,如果是函数,每次复用都会产生新的对象
```

### diff

`双端比较` 就是**新列表**和**旧列表**两个列表的头与尾互相对比，在对比的过程中指针会逐渐向内靠拢，直到某一个列表的节点全部遍历过，对比停止。
Vue 2 的 Diff 算法

1. 同级比较：只比较同一层级的节点，不跨层级比较。
2. 双端比较：Vue 2 的 Diff 算法采用双端比较策略，从列表的两端（头部和尾部）开始比较，以尽量减少节点的移动次数。
3. 更新策略：当头尾比较无法匹配时，Vue 2 会尝试复用旧节点，通过更新节点的属性或子节点来匹配新的虚拟节点，同时将其移动到正确的位置，以减少
   DOM 操作次数。
   Vue 2 的 Diff 算法有一些限制，比如：

4. 同级比较：不会进行跨层级的节点比较，这可能导致一些不必要的 DOM 操作。
5. 静态节点优化：对于静态节点，Vue 2 在构建虚拟 DOM 树时会有一些优化，但在更新时，这些优化不会重复利用。
   Vue 3 的 Diff 算法
3. Vue 3 引入了一个全新的编译策略和运行时优化，包括对 Diff 算法的改进。Vue 3 的 Diff 算法带来了更好的性能和更少的内存消耗，主要得益于以下几点：

4. 双端比较优化：Vue 3 继续使用了双端比较算法，但是在细节上进行了优化，比如对于相同节点的处理更加高效。
5. 静态节点提升：Vue 3 在编译时会对静态节点进行提升，这些节点在更新时不会被重新创建，而是直接复用，大大减少了渲染成本。
6. 支持碎片化 (Fragment)：Vue 3 支持碎片化，允许组件有多个根节点，这在 Vue 2 中是不支持的。
7. 区块树 (Block Tree)：Vue 3 引入了区块树概念，它可以跳过静态内容，快速定位到动态节点，减少了 Diff 时的比较次数。
8. 编译时优化：Vue 3 在编译时会对模板进行静态提升，将不会变化的节点和属性提取出来，避免在每次渲染时都重新创建。这样可以减少虚拟
   DOM 树的创建和销毁过程，提高性能。

```js
简单来说，diff 算法有以下过程
​
同级比较，再比较子节点
先判断一方有子节点一方没有子节点的情况(如果新的 children 没有子节点，将旧的子节点移除)
比较都有子节点的情况(核心 diff)
递归比较子节点
​
Vue2 的核心 Diff 算法采用了双端比较的算法，同时从新旧 children 的两端开始进行比较，借助 key 值找到可复用的节点，再进行相关操作。
​
Vue3.x 在创建 VNode 时就确定其类型,将静态内容提升，在 mount/patch 的过程中采用位运算来判断一个 VNode 的类型，在这个基础之上再配合核心的 Diff 算法
​
正常 Diff 两个树的时间复杂度是 O(n^3)，但实际情况下我们很少会进行跨层级的移动 DOM，所以 Vue 将 Diff 进行了优化，从O(n^3) -> O(n)，只有当新旧 children 都为多个子节点时才需要用核心的 Diff 算法进行同层级比较。
Vue2 的核心 Diff 算法采用了双端比较的算法，同时从新旧 children 的两端开始进行比较，借助 key 值找到可复用的节点，再进行相关操作。
相比 React 的 Diff 算法，同样情况下可以减少移动节点次数，减少不必要的性能损耗，更加的优雅。
Vue3.x 借鉴了 ivi 算法和 inferno 算法
在创建 VNode 时就确定其类型，以及在 mount/patch 的过程中采用位运算来判断一个 VNode 的类型，在这个基础之上再配合核心的 Diff 算法，使得性能上较 Vue2.x 有了提升。该算法中还运用了动态规划的思想求解最长递归子序列。
```

### scoped 原理与样式穿透

样式穿透与局部样式

加了 scoped 会给当前组件的所有原生 dom 标签和当前组件的所有子组件的根标签添加 data-v-唯一 hash 值属性

然后给一连串样式选择器的最后添加属性选择器

vue2 /deep/ :: v-deep : deep (选择器)

vue3 : deep (选择器)

将属性选择器移到 deep 之前那个样式身上, 如果没有, 放到 deep 所在的地方

`::v-deep` `/deep/` 使用:

.a .b .c-->. a .b .c[data-v-hash]

.a v-deep .b .c-->. a[data-v-hash] .b .c

v-deep .b-->[data-v-hash] .b

`:deep(类名)` 使用:
: deep (. a) .b .c-->[data-v-hash] a .b .c
