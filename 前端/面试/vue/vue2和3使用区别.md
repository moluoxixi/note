---
title: vue2和3使用区别
description: 一个vue2和3使用区别笔记
date: 2025-03-05
hidden: false
tags: vue2和3使用区别
ptags: 
---

## 2/3 使用区别

```js
app.config.globalProperties.$set = (obj,key,value)=>{  
  obj[key]=value  
}
```

### 组件懒加载

Vue 2

```js
<template>
    <div>
        <异步组件名 />
    </div>
</template>
<script>
    const 异步组件名 = () => import('组件路径');
    const 异步组件名 = {
      component: () => import('组件路径'),
      delay: 200,
      timeout: 3000,
      error: ErrorComponent,
      loading: LoadingComponent
    }
    export default {
      components: {
        异步组件名,
      },
      delay: 200,
      timeout: 3000,
      error: ErrorComponent, //错误UI组件
      loading: LoadingComponent //加载UI组件
    };
</script>
```

Vue 3

```js
<template>
    <异步组件名 />
</template>
<script setup>
    import {defineAsyncComponent} from 'vue';
    const 异步组件名 = defineAsyncComponent({
        loader: () => import('./views/home.vue'),
        delay: 200,
        timeout: 3000,
        error: ErrorComponent, //错误UI组件
        loading: LoadingComponent //加载UI组件
    })


	const asyncModalWithOptions = defineAsyncComponent({ 
		loader: () => import('./Modal.vue'),
	 	  delay: 200, timeout: 3000,
	    errorComponent: ErrorComponent,
	    loadingComponent: LoadingComponent 
	})
</script>
```

### 路由懒加载

打包时忽略该路由组件当访问该路由时, 该路由组件才会被单独打包成一个 js 文件, 并加载

#### Vue 2

通过 import () 函数动态引入路由组件

```js
const 组件名=() => import('路由组件所在路径');
const routes = [
  {
    path: "路由地址",
    name: "路由别名",
    component: 组件名,
    meta: {
      //路由元信息,该对象会挂载至该路由对象的meta属性身上
    },
  },
```

#### Vue 3

```js
//也可以用vue2的写法
const 组件名=defineAsyncComponent(() => import('路由组件所在路径'));
const routes = [
  {
    path: "路由地址",
    name: "路由别名",
    component: 组件名,
    meta: {
      //路由元信息,该对象会挂载至该路由对象的meta属性身上
    },
  },
```

### Jsx

#### attrs&props&listeners

在 vue 2 中 attrs 和 props 属性用于传递自定义属性,

```js
attrs属性和props属性都可以通过props配置项接收为`$props`
​
被props配置项接收的作为`$props`,
​
仅仅attrs中未被接收的作为`$attrs`
```

Vue 3 中不在存在 props 属性和 attrs 属性, 全部通过像 react 一样的属性绑定方式传递响应式属性

```js
被props配置项接收的作为`$props`,
​
未被接收的作为`$attrs`
//vue2
--父
<Child props={{a:1}} attrs={{b:1,c:2}} on={...$listeners} {...otherCoustomProps} />
​
--子
{
    props:{
        b:{
            type:Number,
            default:0
        }
   },
   render(){
       console.log('kl',this.$attrs,this.$props);  //$attrs:{c:2} $props:{b:1}
       return [{}];
   }
}
​
​
//vue3,props和attrs不在作为专门传递响应式属性的功能
--父
// $attrs:{a:1,b:2,c:3,onChange=()={}}
<Child {...this.$attrs} {...otherCoustomProps} />
​
--子
{
    props:{
        a:{
            type:Number,
            default:0
        }
   },
   mounted(){
       //$attrs:{props:{a:1}} $props:{attrs:{b:1,c:2}}
       console.log('kl',this.$attrs,this.$props);  
       return [{}];
   }
}
```

#### slot

插槽->vue 2 中采用 scopeSlots 传递, slots 接收, vue 3 中采用 v-slot 传递, slots 接收

Vue 2

```js
子组件(接受插槽的地方):
    <组件名>
        <template slot="名字">1</template> //已被遗弃
        <template #名字>1</template>
    </组件名>
​
    //this.$scopedSlots会接收所有slot,$slots只会接收除scopedSlots之外的slot
    jsx写法:
    <div>{ this.$scopedSlots.插槽名字?.(this.value)}</div>
    <div>{this.$slots.插槽名字}</div>
​
父组件(即传递html结构的地方/对应写template #插槽名):
    //scoped对应组件传递给插槽的参数,即this.value,
    //scopedSlots同样可以传递给<slot>标签
    <组件名 scopedSlots={{
            插槽名字: scoped =><span>{scoped.name}</span>
    }}>
    </组件名>
```

Vue 3

```js
子组件(接受插槽的地方):
    setup(props, { slots }) {
        return () =><button>{ slots.插槽名字?.() }</button>
    },
    //or
    setup(props, { slots }) {
        return () =><button>{ renderSlot(slots, '插槽名字') }</button>
    },
​
​
父组件(即传递html结构的地方/对应写template #插槽名):
    //scoped对应组件传递给插槽的参数
    //这种组件包裹插槽的写法不能在组件内写别的内容也就是default插槽的内容,例如:
    //<el-dropdown>
    //    你好
    //    {{dropdown: () =><span></span>}}
    //</el-dropdown>
    
    
    <组件名>
      {{
        插槽名字: scoped =><span>{scoped.name}</span>,
      }}
    </组件名>
​
    //or
    <组件名 v-slots={{
      插槽名字:  scoped =><span>{scoped.name}</span>,
    }}>
    </组件名>
```

### 新组件

#### Teleport

传送门

将包裹的元素传送到样式选择器对应的元素内

不能跨组件传送

```
<div id="teleport-target"></div>
​
<teleport to="#teleport-target">
    <div v-if="visible" class="toast-wrap">
      <div class="toast-msg">我是一个 Toast 文案</div>
    </div>
</teleport>
```

#### Suspense

与 react 的类似

```
//vue3
<Suspense>
    <template #fallback>
         padding状态下的替换
    </template>
    <LazyCompoent />
</Suspense>
//react
<Suspense fallback={padding状态下的替换} >
    <LazyCompoent />
</Suspense>
```

### 新指令

#### V-memo

用于缓存指定元素

```
//v-memo="[依赖项]" 仅当依赖项触发时,元素 及其 内部的子孙元素/组件 才会重新渲染
//v-memo="[表达式]" 仅当表达式为true时,元素 及其 内部的子孙元素/组件 才会渲染
​
<div v-memo="[points<1000]"> //表达式成立时才渲染
//<div v-memo="[points]">  // 除初始渲染外,仅points变化后重新渲染
  <myComponent :points="points" />
</div>
```

#### V-cloak

用于响应式未编译完成前的样式显示

```
//html
<div v-cloak>
  {{ message }} //{{message}}未编译成具体值时,div就不会移除v-cloak属性
</div>
//css
[v-cloak] {
  display: none;
}
```

### 静态提升

```
<div>
  <div>
    <span class="foo"></span>
    <span class="foo"></span>
    <span class="foo"></span>
    <span class="foo"></span>
    <span class="foo"></span>
  </div>
</div>
```

来看这样一个模板，符合静态提升的条件，但是如果没有静态提升的机制，它会被编译成如下代码：

```
return function render(_ctx, _cache) {
  return (_openBlock(), _createBlock("div", null, [
    _createVNode("div", null, [
      _createVNode("span", { class: "foo" }),
      _createVNode("span", { class: "foo" }),
      _createVNode("span", { class: "foo" }),
      _createVNode("span", { class: "foo" }),
      _createVNode("span", { class: "foo" })
    ])
  ]))
}
```

编译后生成的 render 函数很清晰，是一个柯里化的函数，返回一个函数，创建一个根节点的 div，children 里有再创建一个 div
元素，最后在最里面的 div 节点里创建五个 span 子元素。

如果进行静态提升，那么它会被编译成这样：

```
const _hoisted_1 = /*#__PURE__*/_createStaticVNode("<div><span class=\"foo\"></span><span class=\"foo\"></span><span class=\"foo\"></span><span class=\"foo\"></span><span class=\"foo\"></span></div>", 1)
​
return function render(_ctx, _cache) {
  return (_openBlock(), _createBlock("div", null, [
    _hoisted_1
  ]))
}
```
