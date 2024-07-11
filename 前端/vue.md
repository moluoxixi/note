# 神奇的extends与mixins

vue提供了extends和mixins,mixins一个组件,可以直接在它的基础上进行扩展,需要注意的是,

extend功能上与mixins一样,但是会作为第一个mixins

react并没有直接扩展组件的方式,但是可以通过自定义hook,Context或高阶组件的方式进行扩展

```javascript
export default{
    mixins: [组件1,..],
    extends:组件1
}
```

# Vuex💩

## 使用示例

在任意 Vue 组件内通过 this.$store 访问 store

通过this.$store.state.模块名.对应像访问的state中的属性 访问store内的state通过...mapState('模块名',[state中属性的名字]) 访问store内的state

通过this.$store.commit('模块名/mutations中方法的名字',参数) 调用store内的mutations

通过this.$store.dispatch('模块名/actions中方法的名字',参数) 调用store内的actions通过...mapActions('模块名',[actions中方法的名字]) 调用store内的actions
通过...mapGetters('模块名',[getters中方法的名字]) 调用store内的getters

namespaced用于开启命名空间,modules用于将store分成一个个小模块state 会合并为{模块名:模块的 state 对象}actions,mutations会直接添加到 store 身上

**如果遇到同名的actions/mutations/getters,会发生命名冲突,需要开启namespaced**

```javascript
import Vue from 'vue'
import Vuex from 'vuex'

//处理操作
const actions={
    方法名({commit,state},传的参数){
        //注意,不需要带模块名
        commit('mutations中方法的名字',传给mutations中方法的参数)
    }
};
//修改状态
const mutations={
    方法名(state,payload){
        //payload就是传的参数
        state.count+=payload;
    }
};
const state={};
//同vue的computed,简化数据操作
const getters={
    方法名(state){
        return state.count;
    }
};
//划分模块
const countModules= {
    namespaced:true, //开启命名空间
    state,
    actions,
    mutations,
    getters
}

Vue.use(Vuex) //声明并使用官方插件
const store = new Vuex.Store({
    modules:{
        countModules:模块名
    },
    state,
    actions,
    mutations,
    getters
})
new Vue({
    ...,
    store
})
```

## 什么时候用 mutations,什么时候用 actions

没有异步操作时,使用 mutations

有异步操作时,使用 actions 进行异步操作,mutations 仅进行修改 state 操作

## Vuex.Store配置项

| Vuex 的核心概念 | 是什么                                                              | 怎么写                         | 怎么用                                                                                                                                |                                                           |     |
| ---------- | ---------------------------------------------------------------- | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | --- |
| modules    | 用于引入小 store,小 store 会合并为 store                                   |                             |                                                                                                                                    |                                                           |     |
| namespaced | 命名空间,避免命名冲突                                                      |                             |                                                                                                                                    |                                                           |     |
| state      | 共享状态数据                                                           | {状态 1:值,...}                | 在 Vue 组件内通过 `this.$store.state.状态名 ` 获取状态值                                                                                         |                                                           |     |
| getters    | 用于简化状态数据操作                                                       | {方法名:(state)=>新数据}          | 初始值}                                                                                                                               | 在 Vue 组件内通过 `this.$store.getters.方法名` 获取 getters 里面方法的返回值 |     |
| mutations  | 用于提供 `直接修改 state` 的方法不能出现在异步,循环和判断中进行操作 state                    | { 方法名 1(state,传的参数){},...}  | 通过 actions 里的方法中 `context.commit('方法名')` 触发 mutations 里的方法 <br>或Vue 组件内可以通过this.$sotre.commit('方法名')跳过 actions 直接触发 mutations 里的方法 | 两种思考方式:                                                   |     |
| actions    | 用于将 vue 操作与 vuex 连接,actions 中的方法接收操作后提交给 mutations 进而修改 vuex 的状态 | {方法名 1(context,传的参数){},...} | Vue 组件内通过                                                                                                                          | context 是一个对象,本质是 store 的阉割复制品,具有一些方法:                    |     |


## mapState/mapMutations/mapActions/mapGetters

返回一个对象,这四个用法一样,其中 mapMutations 和 mapActions 几乎不用

mapState 和 mapGetters 是简化数据的操作,将 vuex 中的数据映射为组件中的数据

mapMutations 和 mapActions 是简化方法的操作,将 vuex 中的方法映射为组件中的方法(用的很少)

### 数组写法

```
computed:{
    //...mapGetters(['方法名',...])
    ...mapState(['状态名',...])
    //...mapGetters('小store名',['方法名',...])
    ...mapState('小store名',['状态名',...])
}
//等同于以下的简写
computed:{
    方法名(){
        return this.$store.getters.方法名
    },
    状态名(){
        return this.$store.state.状态名
    },
    小store方法名(){
        return this.$store.getters.小store名.小store方法名
    },
    小store状态名(){
        return this.$store.小store名.state.状态名
    },
    ...
}

methods:{
    ...mapMutations(['方法名',...]),
    ...mapActions(['方法名',...]),
    ...mapMutations('小store名',['方法名',...]),
    ...mapActions('小store名',['方法名',...]),
}
//等同于以下的简写
methods:{
    mutations方法名(payLoad){
        return this.$store.commit('mutations方法名',payLoad)
    },
    actions方法名(){
        return this.$store.dispatch('actions方法名')
    },
    小store的mutations方法名(payLoad){
        return this.$store.dispatch('小store名/mutations方法名',payLoad)
    }
    小store的actions方法名(){
        return this.$store.dispatch('小store名/actions方法名')
    },
    ...
}

```

### 对象(取别名)写法

```
computed:{
    //...mapGetters({方法名的别名:'方法名',...})
    ...mapState({状态名的别名:'状态名',...})
    //...mapGetters('小store名',{方法名的别名:'方法名',...})
    ...mapState('小store名',{状态名的别名:'状态名',...})
    ...mapState({状态名的别名:state=>state.状态名,...})
    
    ...mapActions({方法名:'别名'})
}

```

## vue3hook

### createStore

替换 VueX 中的 Vuex.Store

```
import {createStore} from 'vuex';
export createStore(config)

```

### useStore

供 setup 使用

返回 store 对象的函数

```
const store=useStore()
store.commit()
store.dispatch()

```

# 响应式

vue2数组因为一般情况下数据量很大,Object.defineProperty代理太消耗性能,因此提供七个方法提供响应式:

- push

- unshift

- pop

- shift

- splice

- sort

- reverse

# router

vue-router

## 注册路由器

在 src 文件夹内创建 router 文件夹,并在其内创建 index.js

index.js 中

```javascript
import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter) //声明并使用官方插件
import { staticRoutes } from 'router文件夹的目录' //获取静态路由配置表

export default new VueRouter({
    ...,
    mode:'history', //or hash
    routes:staticRoutes,
    //savedPosition存储来时页面的位置,如果是初始化则为undefined
    scrollBehavior (to, from, savedPosition) {
       //跳转路由后页面移动到y:0的位置
       return { y: 0 }
    }
})

```

在 main.js 中注入 router,注入后,可以在任意 Vue 组件内通过 this.$router 获取路由器对象

通过 this.$route 获取当前匹配的路由对象

```
new Vue({
    ...,
    router
})

```

## routes

```javascript
routes:[
    {
        path:'/',
        redirect:'重定向的路由地址',
    },
    {
        path:'/路由地址',
        component:路由组件,
        name:'路由名',
        //可以为布尔值,为true会将解析出来的params对象的属性作为属性传参,在路由组件内通过props接收
        //eg:不能接query
        //可以为对象,对象的属性作为属性传参,在路由组件内通过props接收
        //可以为方法,方法的第一个参数是匹配的路由对象,其返回的对象的属性作为属性传参,在路由组件内通过props接收
        props:$route=>({}),
        children:[{
                //可简写为path:'自己的路由名',用于拼接地址
                path:'/父路由名/自己的路由名',    //直接使用该路由地址
                component:路由组件
            },
            {
                //可简写为path:''
                path:'/父路由名',
                redirect:'重定向的路由地址',
            }
        ],
    },
    ...
]

```

```
const routes = [{
    path: '/new-route1',
    component: NewRouteComponent1,
    children:[{
    path:'/父路由名/自己的路由名',    //直接使用该路由地址
    	component:路由组件
    }]
}]

```

## 动态路由

在特定操作时,改变注册的路由表,一般是在登录的时候获取路由

```javascript
//router.options一般是VueRouter(options)的options
//缓存静态路由
const staticRoutes = router.options.routes;

const addRoutes=(route,parentPath = '')=>{
	//还原初始化的静态路由
	router.options.routes = staticRoutes;
	route.forEach(item => {
		if(route.children){
			addRoutes(route.children,route.path + '/');
		}else{
			router.addRoute(item);
		}
	});
}

const initRoutes=(router)=>{
	const newRouter = new VueRouter();
	router.matcher = newRouter.matcher;
}
//例如现在退出登录
initRoutes(router);

//例如现在登录拿到了动态路由asyncRoutes
addRoutes(asyncRoutes);

//route的来源来自于路由守卫,路由守卫中判断,在跳转登录页时,缓存from路由信息作为route
const route={};
router.beforeEach(form,to,next)=>{
	if(to.path==='\login'){
		route=form||{};
	}
    return hasPermission(router,to)?next():next('/login');
}

//登录完毕后如果需要重定向到之前的页面,需要判断是否还存在权限
const hasPermission=(router,route)=>{
	const routes=router.matcher.options.routes; //3.0x
	//const routes=router.getRoutes() //4.0x
	const hasRoute=(item,route)=>{
		//路由匹配规则
		const matchRule=item.path===route.path||item.name===route.name;
		//如果有子路由,则匹配子路由和当前路由,否则只匹配当前路由
		return item.children?item.children.find(el=>hasRoute(el,route)||matchRule:matchRule;
	}
	return routes.find(el=>hasRoute(el,route));
}
hasPermission(router,route);
//可以在路由守卫中通过next跳转,也可以通过router.replace跳转
```

## 路由导航

name用于匹配路由名称

path对应路由地址

params不能和path共存

## 声明式路由导航

跳转路由使用

<router-link to="{name:'路由名',params:{参数键值对},query:{参数键值对}}" />

对象写法需要在路由表中给想匹配的路由写 name

对象写法传的 params 参数如果不在路由表中使用/:key 占位接收,就不会在路径上显示

但仍然可以在路由组件中通过 this.$route.params 获取 params 参数

## 编程式路由导航

this.$router.push

this.$router.replace

this.$router.replace/push

```javascript
this.$router.replace('路由地址')
//对象写法需要在路由表中给想匹配的路由写name
//对象写法传的params参数如果不在路由表中使用/:key占位接收,就不会在路径上显示
//但仍然可以在路由组件中通过this.$route.params获取params参数
this.$router.replace({
    name:'路由名',
    params:{参数键值对}, //注意写params参数,需要在路由配置中命名路由参数（如 :name 或 :port）
    query:{参数键值对}
})

```

## 展示路由

在要展示路由组件的地方写

或

二级/多级路由就是在

## scrollBehavior

- 需要body设置100%,并开启y滚动条,html不能设置height:100%

- 4.0以上是top,left,el; 4.0以下是x,y,selector

- 如果keepalive路由组件,scrollBehavior会失效

### 滚动到固定距离

该函数可以返回一个 ScrollToOptions 位置对象：

```javascript
const router = createRouter({
    scrollBehavior(to, from, savedPosition) {
        // 始终滚动到顶部
        return { top: 0 } //4.0以上是top,left;4.0以下是x,y
    },
})
```

### 滚动到元素位置

可以通过 el 传递一个 CSS 选择器或一个 DOM 元素。在这种情况下，top 和 left 将被视为该元素的相对偏移量。

```javascript
const router = createRouter({
    scrollBehavior(to, from, savedPosition) {
        // 始终在元素 #main 上方滚动 10px
        return {
            // el: document.getElementById('main'),
            el: '#main',//4.0以前用selector
            top: -10,
        }
    },
})
```

### 滚动到锚点位置

```javascript
const router = createRouter({
    scrollBehavior(to, from, savedPosition) {
        if (to.hash) {
            return {
                el: to.hash, //4.0以前用selector
            }
        }
    },
})
```

### 滚动到之前的位置

```javascript
const router = createRouter({
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0, behavior: 'smooth' }
    }
  },
})
```

# 路由守卫

(1) 使用该方法时，应该把项目的body的高度设定为100%，y轴方向滚动条显示；（我把html的高也设定100%了，于是导致功能无效）所以html的高度不用设定；

## **完整的路由守卫流程**

导航开始，路由离开。

对应路由组件调用 beforeRouteLeave 守卫并失活。

全部失活后，调用全局的 beforeEach 守卫。

beforeEach结束后，

如果路由的参数发生变化调用 beforeRouteUpdate 守卫 (2.2+)。

在路由配置里调用 beforeEnter。

解析异步路由组件及普通组件。

解析完毕调用组件内部的 beforeRouteEnter。

调用全局的 beforeResolve 守卫 (2.5+)。

导航完毕。

调用全局的 afterEach 钩子。

触发 DOM 更新。

## 全局导航守卫

只要有路由跳转就会拦截

分为前置守卫,解析守卫,后置守卫

在路由配置文件中配置--->router.js | router/index.js

前置守卫

路由开始匹配前拦截(组件未复用)

```javascript
//全局,只挂载在router实例上的
router.[钩子写在这里]

from:当前路由对象
to:目标路由对象
next:一个函数
    next()                        无条件放行
    next(false)                   全部拒绝放行
    next('路径'或一个路由对象)    跳转到指定路由 eg:跳转到新路由后也会触发路由守卫,可能会栈溢出
​
const router=new VueRouter({})
router.beforeEach((to,from,next)=>{
​
})
```

解析守卫

路由匹配完毕后,解析未完成时拦截(组件未复用)

```
router.beforeResolve((to,from,next)={})
```

后置守卫

路由解析完毕后,路由组件未创建时拦截(组件未复用)

```
router.afterEach((to, from) => {})
```

## 路由独享守卫

只有往指定路由跳转时会拦截

路由匹配解析完毕,组件未创建时拦截(组件未复用)

在路由表中指定的路由内配置---router.js|router/index.js--->routes--->指定的路由

```
//路由配置内指写在router配置内的
const router = new VueRuter({
 routes: [
    {
      path: '/admin',
      component: Admin,
      beforeEnter: (to, from, next) =&gt; {
        // 进行权限验证等操作
        if (localStorage.getItem('admin')) {
          next();
        } else {
          next({
            path: '/login',
            query: {redirect: to.fullPath}
          })
        }
      }
   ]
 })
```

## 组件内守卫

只有往指定路由跳转时会拦截

路由匹配并解析完毕,组件未创建时拦截(组件未复用)

配置在组件内

beforeRouterEnter 路由匹配解析完毕,组件即将开始创建时拦截,

beforeRouterUpdate 路由组件开始创建,

beforeRouterLeave 组件创建完毕,即将离开时拦截(组件销毁)

```javascript
//组件内指写在组件配置内的
<template></template>
export default {
  name: "",
  //钩子写在这里
  data:()=>{
  	return {
  
  	}
  },
};

```

# 图片懒加载

```
npm i vue-lazyload@1 -S
import Vue from 'vue'
import App from './App.vue'
import VueLazyload from 'vue-lazyload'
​
Vue.use(VueLazyload,{
失败的图片
error: require('../src/assets/image/error.png'),
加载中的替代图片
loading: require('../src/assets/image/loading.gif'),
})
<img v-lazy="图片路径" />
​
如果有div包裹着img
<div v-lazy-container="{ selector: 'img' }">
  <img data-src="图片路径">
</div>
```

# 组件懒加载

```
<template>
    <div>
        <异步组件名 />
    </div>
</template>
<script>
    const 异步组件名 = () => import('组件路径');
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

# 路由懒加载

打包时忽略该路由组件当访问该路由时,该路由组件才会被单独打包成一个 js 文件,并加载

通过 import()函数动态引入路由组件

```
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

# vue自定义

## 自定义过滤器**(vue3没有)**

xx|过滤器名

xx|过滤器名(参数)

### 定义全局过滤器

Vue内都能用

```
//参数1代表xx,arg即过滤器字段传入的一个或多个参数
Vue.filter('过滤器字段',(参数1,..arg)=>{})
```

### 定义局部过滤器

**一般不用局部过滤器**

只在过滤器所在的组件内有用

```
//在配置项中添加filters属性
filters:{
    过滤器名(参数1,..arg){}
}

```

## 自定义指令

指令名不以v-开头,指令名必须全小写,使用v-指令名使用该指令

el代表使用该指令的真实DOM元素

### vue2和3中都有的binging属性

```javascript
{
	value,           //这是指令的绑定值,例如指令是v-lazy="someValue"，value就是"someValue"
	arg,             //这是指令的参数,例如指令是v-lazy:nb，arg就是"nb"
	modifiers:obj,   //这是指令的修饰符,例如指令是v-lazy.nb，modifiers就是{nb:true}
	oldValue,        //这是指令的前一个绑定值
}

```

### vue2

```javascript
//定义全局指令
Vue.directive('指令名',{
    bind(el,binding){},             //初次加载绑定的元素时发现有指令绑定时调用
    inserted(el,binding){},         //绑定的元素插入到父节点时调用
    update(el,binding){},           //当VNode更新时,调用,可理解为响应式数据更新
    componentUpdated(el,binding){}, //当组件及其子组件的VNode全部更新后执行操作
    unbind(el,binding){},           //指令与元素解绑时调用,例如元素/组件被销毁
})

```

简写

```
//当bind函数和update函数体中的逻辑代码相同时,可以简写为:
Vue.directive('指令名',(el,binding)=>{})

```

### vue3

```javascript
//定义全局指令
app.directive('指令名',{
	//包含vue3除setup外的所有生命周期
    mounted(el,binding, vnode, prevVNode){}
})

```

### 定义局部指令

**一般不用**

只在局部指令所在的组件内有用

```javascript
//在配置项中添加directives属性
directives:{
    //写法同全局指令
}
```

## vue2/3自定义插件与使用

### 使用自定义插件

Vue.use本质是在调用函数,函数式插件直接调用函数,对象式插件调用对象中的install函数

Vue.use(自定义插件)

### 自定义插件

自定义插件分为函数式插件和对象式插件

```javascript
//函数式插件
vue.use(install函数,options);
//对象式插件
vue.use({install,...},options);

//install函数,app是Vue实例
install(app,options){}
//install中options的属性
{
    components,  //全局组件
    directives,  //全局指令
    mixins,      //全局混入
    methods,     //全局方法
    filters,     //全局过滤器
    config,      //全局配置
    store,       //全局store实例
    router,      //全局router实例
}

```

# 获取DOM**/组件实例**

```
<p ref='xx'></p>
配置项中通过this.$refs.x获取

```

# 动态组件

vue2 is是组件name,vue3是组件本身

```
<script setup>
import Foo from './Foo.vue'
import Bar from './Bar.vue'
</script>
​
<template>
  <component :is="Foo" />
  <component :is="someCondition ? Foo : Bar" />
</template>
```

# 配置代理

```javascript
//vue.config.js
devServer: {
  host: '0.0.0.0', // 会映射多个域名地址
  port: 8000, // 默认起始端口号
  open: true, // 自动打开浏览器访问
  proxy: {
    '/app-dev': { // 代理所有以 '/app-dev'开头的请求路径
      // 后台接口地址
      target: '代理服务器访问的目标地址',
      // 服务器得到的就不是当前应用的域名了, 而是后台的域名
      changeOrigin: true,
      // 重写路径: 去掉路径中开头的'/dev-api'
      rewrite: (path) => path.replace(/^\/app-dev/, ''),
      //or
      pathRewrite:{
        '^/api-dev':''
      }
  },
}
```

# vue动态class

以下class里的值都来自于data

## 字符串用法

我们不知道是哪个类时,需要请求后台的数据确定

```javascript
<p :class='style里的类名'></p>
```

## 对象用法

我们不知道使用哪些类,需要请求后台数据确定

```javascript
<p :class='{style里的类名:布尔值,style里的类名:布尔值}'></p>
```

## 数组用法

一般不用

```javascript
<p :class='[style里的类名,style里的类名]'></p>
```

# vue组件通信

数据源在哪,修改数据的方法就在哪

兄弟组件传参:

采用发布订阅模式,一个消息池(共同的祖先组件,store,事件总线等)作为媒介

父子组件传参:

	父传子:prop v-on $children .sync

	子传父:$emit $parent

	v-model默认替代:value+@input

祖孙:

provide/inject

| 2自定义属性 | props,$attrs | 
| -- | -- |
| 2/3自定义事件 | $emit/$listeners/$on | 
| 2自定义事件+自定义属性 | v-model , .sync | 
| 3组件实例 | $refs,$parent,$children | 
| 1非响应式 | provide/inject | 


## props 组件通信

是 vue 中最基本,使用最多的组件通信方式

用于父子通信:父传子-->通过 props 传值,子传父-->通过函数的参数传值

通过 props 传递过来的数据,不能修改

通过给组件标签添加属性并赋值

props 写法

数组写法

对传递来的数据不做任何限制

```javascript
//接收对应属性名的值
props:['属性名']
```

对象写法

对传递来的数据进行限制

```javascript
//简单限制
props:{
    属性名:类型,
}
​
//复杂限制
props:{
    属性名:{
        type:类型,//还能写成数组,限制类型范围
        default:默认值,//**还能写成函数**并返回默认值
        required:是否必传,不能和default一起出现
    },
}
```

## 自定义事件组件通信

用于发布者向订阅者通信,需要订阅者(

普通的自定义事件通信

用于子向父通信

简单写法

给组件添加自定义事件

```javascript
<Header @自定义事件名='header'></Header>
```

在组件内调用自定义事件

```javascript
//Header组件中
this.$emit('自定义事件名',参数...);
```

麻烦写法

给组件标签添加 ref

```javascript
<Header ref='header'></Header>
```

给组件添加自定义事件

```javascript
mounted(){
    //获取的是组件对象
    this.$refs.header.$on('自定义事件名',事件回调函数)
}
```

在组件内调用自定义事件

```javascript
//Header组件中
this.$emit('自定义事件名',参数...);
```

## 全局事件总线通信

用于发布者向订阅者通信,需要订阅者(

**适用于任意组件间通信**

全局事件总线本质上是一个对象

要作为全局事件总线要符合两个要求:

1. 所有的组件对象都可以访问这个对象

1. 必须能调用

$on

因此,Vue 实例是最佳人选

why?

```javascript
首先,Vue实例与组件实例身上可调用`$emit`和`$bus`
组件实例=new VueComponent();
VueComponent.prototype=Object.create(Vue.prototype);
​
​
//因此
组件实例.__proto__===VueComponent.prototype;
VueComponent.prototype.__proto__===Vue.prototype;
​
//安装总线
const vm=new Vue();
Vue.prototype.$bus=this;
​
​
组件实例.__proto__.__proto__.$bus=vm
//因此
this.$bus可以拿到vm
```

安装总线

一般在 beforeCreate 阶段安装

即给 Vue 的显示原型添加一个属性,该属性指向 Vue 实例

```javascript
Vue.prototype.$bus=this    //这个this得是Vue实例
```

绑定事件

一般在接收数据的一方的 mount 阶段绑定事件

本质上是给$bus 所在的对象添加了事件,这里是给 Vue 实例添加了事件

因为事件函数在接收数据所在的组件,未来触发事件时,传的参会被接收数据所在的组件接收

```javascript
//给vm绑定事件
this.$bus.$on('自定义事件名',函数)
```

触发事件

触发$bus 所在对象上的方法,并给其传参

```javascript
this.$bus.$emit('自定义事件名',参数...)
```

vue.prototype 上的方法

$on

$emit

## 插槽 slot

父向子

用于父向子传递结构数据

slot 向结构数据传递 props(仅限于作用域插槽):看起来是子向父,其实还是父向子

**一个插槽可以接收多个 template 的结构数据**

本质是一个内置的组件-->已经被定义并注册了

插槽分为默认插槽,具名插槽,作用域插槽

插槽标签默认可以写内容

如果父组件标签内使用 template 给插槽填充内容,则使用 template 的内容

如果没有,使用插槽标签内写的内容

**v-slot 可以简写为#**

默认插槽

**默认插槽其实具有名字,名字就叫 default,可以通过 slot name='default'接收**

一个页面一般只有一个,且不写 name

```javascript
<template>
    <父组件标签名>
        //这个v-slot:default可以省略,不写默认就是默认插槽
        <template v-slot:default></template>
    </父组件标签名>
</template>
```

父组件标签内

```javascript
<template>
    <slot>aaa</slot>
</template>
```

具名插槽

具名插槽可以有多个,每个的 name 值不一样

根据 name 值给对应的插槽传结构数据

```javascript
<template>
    <父组件标签名>
        <template v-slot:name值></template>
    </父组件标签名>
</template>
```

父组件标签内

```javascript
<template>
    <slot name='name值'>aaa</slot>
</template>
```

作用域插槽

数据在父组件中,

数据需要传递给子组件并由子组件展示

父组件标签内

```javascript
<template>
    <子组件标签名 :属性名='属性值'>
        //注意,这个对象可以直接解构-->v-slot='{属性名}'
        //如需指定默认插槽或具名插槽,使用v-slot:default v-slot:name
        <template v-slot="对象别名">
            //得到插槽
            {{对象别名.插槽回传时使用的属性名}}
        </template>
    </子组件标签名>
</template>
```

子组件标签内,子组件通过给插槽绑定属性,回传数据,

这个数据会被子组件标签 v-slot 的值接收,形成一个对象,

在子组件标签的 template 内通过 对象.属性名访问回传的数据

```javascript
<template>
    <slot :属性名='a'></slot>
</template>
```

## v-model

父子之间

给 html 标签使用 v-model='xx',看具体情况

1. radio 和 checkbox 本身没有 value,需要手动写 value

1. radio 收集的是其 value 值

1. select 收集的是其选中的 option 的 value 值

1. checkbox 成组使用时(多个 checkbox 绑定同一个数据),需要使用数组收集其 value 值,最终是选中的 checkbox 的 value 值组成的数组

1. checkbox 单个使用时,收集的是其 checked 属性值

给组件标签使用 v-model='xx',默认情况下相当于

```javascript
可以在组件内通过添加model配置项更改
model:{
    props:'自定义属性名',
    event:'自定义事件名'
}
然后v-model='xx'会变成
:自定义属性名='xx' @自定义事件名='$event.target.value'
```

## .sync

父子之间

<组件标签名 :自定义属性名.sync='xx' />

等同于 

update:自定义属性名

组件内通过 

多个属性组成的对象的写法

:.sync 后的对象要定义好后赋值,不能直接在指令里写对象

```javascript
:.sync="{a:1}"    //报错
:.sync='xx'    正规写法
xx={a:1}
```

<组件标签名 :.sync='xx' />

xx --> {自定义属性名 1:'xx',自定义属性名 2:'xx'}

等同于 

## $attrs和$listeners

$attrs

父子之间

$attrs 会接收所有未被 props 接收的属性形成一个对象

$attrs-->{自定义属性名 1:'xx',自定义属性名 2:'xx'}

v-bind="obj"

v-bind="$attrs" --> :自定义属性名 1="xx" :自定义属性名 2='xx'

$listeners

子向父

$lisnteners 会接收组件身上所有的自定义事件形成一个对象

$lisnteners-->{自定义方法名 1:()=>{},自定义方法名 2:()=>{}}

v-on="obj"

v-on="$listeners" --> :自定义方法名 1="xx" :自定义方法名 2='xx'

## ref 和$children和 ​$parent

ref

父向子

ref='xx'给 html 标签使用,$refs.xx 获取的是挂载之后的真实 DOM

ref='xx'给组件标签使用,$refs.xx 获取的是组件实例对象

> 扩展:组件对象的$el 可以获取该组件对象的真实 DOM


```javascript
父组件内通过以下方式可以直接操作子组件内的属性
this.refs.xx.组件内的属性
```

$children

父向子,一般用于子组件的统一操作

$children 获取所有子组件实例对象组成的数组

```javascript
父组件内通过以下方式可以直接操作子组件内的属性
this.$children.forEach(item=>item.xx.组件内的属性)
```

$parent

子向父

$parent 获取父组件实例对象

```javascript
子组件内通过以下方式可以直接操作父组件内的属性
this.$parent.xx.组件内的属性
```

## provide 和 inject

祖先组件通过 provide 向其所有子孙后代注入一个依赖,子组件通过 inject 接收

provide

但 provide 可以传响应式数据,使其具有响应式,原理是利用 provide 和 inject 使用的同一地址的响应式对象

例子:

祖先组件:

```javascript
data(){
    return {
        a:1,    -->a=3,不具有响应式
        b:{c:1}    -->b.c=3,-->具有响应式
    }
}
provide(){
    return {
        a:this.a,
        b:this.b
    }
}
```

后代组件:

```javascript
inject:["a","b"]
a=2    -->不具有响应式
b.c=2    -->具有响应式,注意,一定要是响应式对象传递下去才有响应式,provide里拼出来的不具有响应式
```

provide

provide 是组件配置对象的一个配置项

provide 对象写法

```javascript
provide:{}
```

provide 函数写法

```javascript
//函数写法相比对象写法优点:可以通过this操作vm中的数据
provide函数返回一个对象,该对象可以被后代组件inject获取
provide(){return {}}
```

inject

inject 会接收 最近的 与 inject 数组中 属性同名 的 provide 对象的属性

```javascript
inject:['属性1',..]
```

# 生命周期

创建阶段和挂载阶段统称初始化阶段

常用 beforeUpdate 和 mounted 这两个钩子

| 创建 Vue 实例--->new Vue() |   | 
| -- | -- |
| 初始化事件对象和生命周期 |   | 
| beforeCreate | 只执行一次 | 
| 初始化事件代理与事件劫持, |   | 
| created | 只执行一次 | 
| 创建 Vue 实例的 |   | 
| 判断是否有 template, |   | 
| beforeMount |   | 
| 将虚拟 DOM 变成真实 DOM |   | 
| mounted | 只执行一次 | 
| 当虚拟 DOM 或动态数据更新时 |   | 
| beforeUpdate | 执行 0~n 次 | 
| 新旧虚拟 DOM 比较,页面重新渲染( |   | 
| updated | 执行 0~n 次 | 
| 重复以上过程 |   | 
| 当 Vue 实例.$destroy 被调用 |   | 
| beforeDestroy | 只执行一次 | 
| 移除数据代理,事件监听等 |   | 
| destroyed | 只执行一次 | 


# 挂载到根元素并渲染

```javascript
import Vue from "vue";
import App from "./App.vue";
new Vue({
    el:'#root',    //挂载根节点
    render:(h)=>h(App)//渲染根元素
    或
    components:{App}//需要具有模板解析器vue.js使用,默认引入的是不具有的,需要手动更改(vue/dist/vue.esm.js)
})
​
或
new Vue(config).$mount('#root')//挂载根节点
```

# 创建项目

脚手架2版本和之后版本的区别:

2的webpack配置是暴露的,使用dev启动

之后的webpack配置是隐藏的,使用serve启动

```javascript
npm i @vue/cli -g
vue create 项目文件名
```