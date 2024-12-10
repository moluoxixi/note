# vue中如何使用SSR的

```javascript
// 第 1 步：创建一个 Vue 实例
const Vue = require('vue');
const app = new Vue({
  template: `<div>Hello World</div>`
});
// 第 2 步：创建一个 renderer
const renderer = require('vue-server-renderer').createRenderer();
// 第 3 步：将 Vue 实例渲染为 HTML
renderer.renderToString(app, (err, html) => {
  if (err) throw err;
  console.log(html);
  // => <div data-server-rendered="true">Hello World</div>
});
// 在 2.5.0+，如果没有传入回调函数，则会返回 Promise：
renderer
  .renderToString(app)
  .then(html => {
    console.log(html);
  })
  .catch(err => {
    console.error(err);
  });
```

# 安装并启动nuxt

## 创建项目

打开 Visual Studio Code , 打开内置终端并输入下面命令创建一个 nuxt 项目：

```js
//新建
npx create-nuxt-app <项目名>
npx nuxt init nuxt3-app
```

## 安装依赖

```
yarn
or
npm i
```

## 启动

以 开发模式启动 nuxt:

```
yarn dev
or
npm run dev
```

# 页面配置

| 属性名         | 描述                                                                                                                                                                                                                                                                                                                   | 示例                                                                                                                        |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| watchQuery  | 用于监视query参数变化并在更改时执行组件方法<br>(asyncData, fetch, validate, layout, ...)                                                                                                                                                                                                                                                | `watchQuery:true `, //监视所有query参数<br>`watchQuery:['aaa']`, //监视部分query参数                                                  |
| asyncData   | 使得你能够在渲染**pages中**的组件之前,<br>**异步获取数据，然后将这些数据注入到组件的 data 中。**<br><br>**无法使用this**<br><br>该方法的第一个参数为当前页面组件的上下文对象,对象中包括但不限于以下属性:<br>1. $axios（如果你安装了 @nuxtjs/axios 模块）<br>2. store（Vuex store 实例）<br>3. route（当前路由对象）<br>4. redirect（重定向到另一个路由）<br>5. error（触发错误，通常用于处理服务器端的错误）<br>6. params（路由参数）<br>7. query（查询字符串参数） | asyncData({params}{<br>  return {params}<br>}<br><br>async asyncData({params}){<br>  return $axios.get(path,params);<br>} |
| fetch       | 用于在渲染页面之前获取数据填充应用的状态树（store）。<br><br>**无法使用this<br><br>参数与asyncData相同**                                                                                                                                                                                                                                              | async fetch({ store, params }) {<br>  const res=await axios.get(path)<br>  store.commit('setStars', res)<br>}             |
| head        | 配置当前页面的head标签内容,使用[vue-meta库](https://github.com/nuxt/vue-meta)<br><br>**支持this**                                                                                                                                                                                                                                    | head(){<br>  return {<br>    title: '你好',<br>    meta:[],<br>    ...<br>  }<br>}![[Pasted image 20240718161443.png]]      |
| layout      | 指定当前页面使用的布局<br>**参数与asyncData相同**                                                                                                                                                                                                                                                                                    | layout(content){<br>  return 'default'<br>}                                                                               |
| middleware  | 指定页面的中间件，<br>中间件会在页面渲染之前被调用                                                                                                                                                                                                                                                                                          | middleware:'xxx', //在pages或layouts中<br><br>router:{<br>  middleware: 'xxx' //在  nuxt.config.js中<br>}                      |
| transition  | 指定页面切换的过渡动效, 详情请参考[页面过渡动效](https://www.nuxtjs.cn/api/pages-transition)                                                                                                                                                                                                                                               | transition:{name:'xx'}                                                                                                    |
| scrollToTop | 用于判定渲染页面前是否需要将当前页面滚动至顶部。<br>这个配置用于[嵌套路由](https://www.nuxtjs.cn/guide/routing#%E5%B5%8C%E5%A5%97%E8%B7%AF%E7%94%B1)的应用场景。                                                                                                                                                                                             | scrollToTop:true                                                                                                          |
| validate    | 用于校验当前路由是否有效<br>**参数同asyncData**                                                                                                                                                                                                                                                                                     | validate({params}{<br>  return true<br>}<br><br>async validate({params}{<br>  return !!$axios.get(path,params);<br>}      |


# 内置组件

| 组件              | 描述                        | 说明                                                                                                                                  |
| --------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `<nuxt/>`       | 用于显示pages中的组件             | nuxtChildKey:将什么作为,默认是$route.path                                                                                                   |
| `<nuxt-child/>` | 用于在pages页面中,展示child.vue组件 |                                                                                                                                     |
| `<nuxt-link/>`  | 可以理解为router-link          | `<NuxtLink to="{path:'/login',params:{参数键值对},query:{参数键值对}}" />`<br>`<NuxtLink to="{name:'login',params:{参数键值对},query:{参数键值对}}" />` |
| `<ClientOnly/>` | 用于包裹仅用于客户端渲染,不需要服务端渲染的组件  | `<ClientOnly>不需要ssr的内容</ClientOnly>`                                                                                                |
# 目录结构

| 目录                                                                                                                             | 描述                                          | 示例                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| .nuxt                                                                                                                          | 构建用于开发的程序,nuxt dev时会重新创建该目录                 |                                                                                                                                                                                                                                                                                      |
| .output                                                                                                                        | 构建用于生产的程序,nuxt build时会重新创建该目录               |                                                                                                                                                                                                                                                                                      |
| [static](https://www.nuxtjs.cn/guide/assets#%E9%9D%99%E6%80%81%E6%96%87%E4%BB%B6)&[assets](https://www.nuxtjs.cn/guide/assets) | 不需要构建编译的静态文件存放到static中,打包后会放在根目录            |                                                                                                                                                                                                                                                                                      |
| components                                                                                                                     | 存放公共组件,Nuxt会自动引入并注册该目录下的所有组件                | 组件的名称将基于自己的路径和文件名，并删除重复的段，异步组件需要添加Lazy前缀，比如：<br><br>1. an/an/Button.vue 组件名是 AnButton<br>2. base/foo/Button.vue 组件名是 BaseFooButton<br>3. base/foo/Button.vue 如果是异步组件,组件名是LazyBaseFooButton                                                                                           |
| [layouts](https://www.nuxtjs.cn/guide/views#%E5%B8%83%E5%B1%80)                                                                | 存放布局组件,Nuxt会自动引入并注册该目录下的所有组件                | 1. layouts/default.vue用来扩展应用的默认布局<br>2. layouts/error.vue 用来定义应用的错误页面<br><br>其他用于自定义布局,通过在组件配置项中使用layout配置项决定使用的布局:<br>export default {<br>    layout: 'error', //指定使用的布局<br>    ...<br>}                                                                                            |
| middleware                                                                                                                     | 存放中间件,                                      | 中间件执行流程顺序：<br><br>1. nuxt.config.js<br>2. 匹配布局<br>3. 匹配页面<br><br>export default function ({ route }) {} //组件内默认导出,以文件名作为中间件<br><br>export function xxx({ route }) {} //组件内具名导出,以fn名字作为中间件                                                                                            |
| pages                                                                                                                          | 存放路由组件,Nuxt会根据pages的目录结构自动生成vue-router的路由配置 | 1. pages/user/one.vue 普通路由,对应path为 /user/one<br>2. pages/users/_id.vue 动态路由,对应path为 /users/:id?<br><br>1. pages/users/_id/index.vue 动态路由,对应path为 /users/:id?<br>2. pages/users/_a/_b/index.vue 动态路由,对应path为 /users/:a?/:b?<br><br>4. pages/_slug/com.vue 动态路由,对应path为 /:slug/com.vue |
| composables                                                                                                                    | 存放公共方法,Nuxt会根据导出方式的不同,来注册对应名称的公共方法          | `<template><div>{{ 公共方法名() }}</div></template>`<br>export default function () {} //组件内默认导出,以文件名作为公共方法<br><br>export const useFoo = () => {} //组件内具名导出,以fn名字作为公共方法                                                                                                                    |
|                                                                                                                                |                                             |                                                                                                                                                                                                                                                                                      |
| [plugins](https://www.nuxtjs.cn/guide/plugins)                                                                                 | 存放插件                                        |                                                                                                                                                                                                                                                                                      |


# 拓展组件库

使用 `components:dirs` 钩子进行组件扩展

## 定义

```javascript
import { join } from 'pathe'
import { defineNuxtModule } from '@nuxt/kit'

export default defineNuxtModule({
  hooks: {
    'components:dirs'(dirs) {
      // Add ./components dir to the list
      dirs.push({
        path: join(__dirname, 'components'),
        prefix: 'awesome',
      })
    },
  },
})
```

## 注册

`nuxt.config` 文件中:

```
export default {
  buildModules: ['awesome-ui/nuxt'],
}

```

## 使用

```
<template>
  <div>
    My <AwesomeButton>UI button</AwesomeButton>!
    <awesome-alert>Here's an alert!</awesome-alert>
  </div>
</template>

```