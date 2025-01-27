# 一些坑
## vue 3 作为子应用,路由跳转使不同子应用来回切换,vue3子应用多次挂载问题
https://github.com/umijs/qiankun/issues/2254
```javascript
// 路由跳转使不同子应用来回切换,vue3子应用多次挂载问题


// 解决方法
import { isEmpty,assign } from 'radash'
router.beforeEach((to, from, next) => {  
  if (_.isEmpty(history.state.current)) {  
    _.assign(history.state, { current: from.fullPath });  
  }  
  next();
});
```
## 子应用部分元素挂载在 body 上
```js
//一些ui库会将元素添加到body中,会导致这部分元素样式丢失

//解决方案:
// 将子应用appendBody的元素,挂载到子应用根元素身上  
const proxy = (container) => {
  //**检查是否已代理
  if (document.body.appendChild.__isProxy__) return;
  //创建可撤销的proxy对象,返回{proxy,revoke},proxy是代理对象,revoke是撤销方法
  const revocable = Proxy.revocable(document.body.appendChild, {  
    apply (target, thisArg, [node]) {  
      if (container) {  
        container.appendChild(node);  
      } else {  
        target.call(thisArg, node);  
      }  
    }  
  });  
  if (revocable.proxy) {  
    document.body.appendChild = revocable.proxy;  
  }  
  document.body.appendChild.__isProxy__ = true;  
};
```
## 子应用开启experimentalStyleIsolation后, 若存在样式覆盖, 会导致样式解析失败
暂无解决方案,只能强写样式覆盖错误样式

```js
//experimentalStyleIsolation用于样式隔离,会给全局style加上div[data-qiankun=`${appName}`] 前缀

// element-plus中,部分样式覆盖导致qiankun的style解析失败导致样式丢失  
// 例如border:var(--el-border-color); border-left:0;
//例如:
.residentdoctor-button{
	border-color: var(--residentdoctor-button-border-color);
	border-left: 0;
}

//解析为:
div[data-qiankun="residentdoctor"] .residentdoctor-button {
    border-top-style: ;
    border-top-width: ;
    border-right-style: ;
    border-right-width: ;
    border-bottom-style: ;
    border-bottom-width: ;
    border-left-style: ;
    border-left-width: ;
    border-image-source: ;
    border-image-slice: ;
    border-image-width: ;
    border-image-outset: ;
    border-image-repeat: ;

	border-left:0;
}
```


```js
//fixQiankun.scss
//将这个文件引入放在element样式引入之后,
.el-button {  
  border: 1px solid var(--border-color-1);  
  &--text{  
    border-color: transparent;  
  }  
}  
  
.el-radio-button__inner {  
  border: 1px solid var(--border-color-1);  
}
```
## 子应用开启 experimentalStyleIsolation 后, 局部样式未添加前缀, 会导致权重问题

```js
//experimentalStyleIsolation用于样式隔离,会给全局style加上div[data-qiankun=`${appName}`] 前缀
//但是<style scoped></script>中的样式不会添加

// 解决方案: 写一个vite插件,在每个scoped的样式上加上相同的前缀即可

// ./plugins/addScopedCssPrefixPostBuildPlugin.js
// 修改html中前缀的函数
function changeHtmlClassPrefix (htmlString, oldPrefix, newPrefix) {  
  const regex = new RegExp(  
    `(class|style)\\s*:\\s*((["']((${oldPrefix}\\b)-).*["'])|((_normalizeClass|_normalizeStyle)\\(.*(${oldPrefix}\\b)-.*\\)))`,  
    'g'  
  )  
  return htmlString.replace(regex, (match, p1, offset, string) => {  
    return match.replace(oldPrefix, newPrefix)  
  })  
}  

// 修改css中前缀的函数
function changeSelectorPrefix (cssString, oldPrefix, newPrefix) {  
  const regex = new RegExp(  
    `(\\.${oldPrefix}\\b|\#${oldPrefix}\\b|\--${oldPrefix}\\b)`,  
    'g'  
  )  
  return cssString.replace(regex, (match, p1, offset, string) => {  
    return match.replace(oldPrefix, newPrefix)  
  })  
}  
  
export default function addScopedCssPrefixPostBuildPlugin({ prefixScoped, oldPrefix, newPrefix }) {  
  return {  
    name: 'add-prefixScoped-or-changePrefix-css',  
    transform(code, id) {  
      if (!oldPrefix || !newPrefix) return  
      if (id.includes('node_modules')) return  
  
      const cssLangs = ['css', 'scss', 'less', 'stylus', 'styl']  
      let newCode = code  
      if (id.endsWith('.vue')) {  
        newCode = changeHtmlClassPrefix(newCode, oldPrefix, newPrefix)  
      }  
      // else if (id.includes('.vue') && id.includes('scoped')) {  
      else if (cssLangs.some((lang) => id.endsWith(`.${lang}`))) {  
        if (oldPrefix && newPrefix) {  
          newCode = changeSelectorPrefix(newCode, oldPrefix, newPrefix)  
        }
        // 给代码包裹一层指定前缀的选择器
        if (prefixScoped) {  
          newCode = `${newCode}${prefixScoped}{${newCode}}`  
        }  
        return newCode  
      }  
      return newCode  
    }  
  }  
}
// vite-config.js
import { defineConfig, loadEnv } from 'vite'  
import vue from '@vitejs/plugin-vue'  
import vueJsx from '@vitejs/plugin-vue-jsx'  
import qiankun from "vite-plugin-qiankun";  
  
import addScopedCssPrefixPostBuildPlugin from './plugins/addScopedCssPrefixPostBuildPlugin.js';  
// https://vitejs.dev/config/  
export default defineConfig((mode) => {  
  process.env = { ...process.env, ...loadEnv(mode, process.cwd()) }  
  return {  
	plugins: [  
		vue(),
		addScopedCssPrefixPostBuildPlugin({  
		  prefixScoped: "div[data-qiankun='residentdoctor']",  
		  oldPrefix: 'el',  //初始样式前缀
		  newPrefix: 'residentdoctor'   // 传入你想要添加的前缀,这个前缀需要与子应用注册时的name相同
		}),
		...
	],  
	...
  }  
})
```
## 使用 css 变量,部分样式丢失

```js
// 当使用css缩写,并且使用了css var,在该样式之后存在它的子属性,则会导致样式丢失
// 仅在使用 styleNode.textContent=styleNode.sheet.cssRules[0].cssText 时存在

// 例如:
html{
	--test:red;
}
.a{
	background: var(--test, blue);
	background-color: red;
}
//解析为:
.a{
	background-image: ;
	background-position-x: ;
	background-position-y: ;
	background-size: ;
	background-repeat: ;
	background-attachment: ;
	background-origin: ;
	background-clip: ;
	background-color: red;
}


<head>
	<style>  
			html{  
					--test: red  
			}  
	</style>  
</head>  
<body>  
<div class="ddd1">  
        22222  
</div>  
<script>  
	const textNode = document.createTextNode(`  
		.ddd1 {
			background: var(--test, blue); 
			background-color: red;
		}
	`);  
  const styleNode = document.createElement('style');  
  
  styleNode.appendChild(textNode);  
  document.body.append(styleNode);  
  
  const rule = styleNode.sheet.cssRules[0];  
  styleNode.textContent = rule.cssText;
</script>
```
乾坤源码部分:
![[Pasted image 20241114160854.png]]
## scoped 样式冲突

vue 的 scoped 样式其实也有问题，

它是通过. vue 文件基于项目根目录的相对路径 path+文件名进行计算 hash 值的，

当主子应用中同时存在一个 path 和文件名相同时的. vue 文件，

它的 data-v-XXXXX 算出来就是一样的，此时样式还是会冲突
# 乾坤配置
## 主应用

### 主应用注册并启动
通常主应用会做登录和菜单功能, 点击菜单的同时通过路由动态切换子应用
```js
import { loadMicroApp, start, registerMicroApps } from 'qiankun'
//任何一个项目都可以作为主应用,在主应用中,用对应元素作为容器容纳子应用
//qiankun通过配置项中activeRule加载对应子路由的entry
​
//手动注册可激活任意子应用,未满足匹配规则的也会在激活状态               调用loadMicroApp,接收一个对象
//自动注册只能激活当前匹配子应用,未满足匹配规则且不是手动注册的会被销毁   调用registerMicroApps,接收对象组成的数组
registerMicroApps([
  {
    name: 'react-app', 
    entry: '//http://192.168.211.180',  // 子应用的入口地址
    container: '#appContainer',         // 子应用挂在的容器元素
    activeRule: '/react-app',           // 子应用的激活规则
    props: {},                          // 传递给子应用的数据,子应用通过mount生命周期接收
    
  },
  ...
])
registerMicroApps([app])  
start({  
	singular: true,                     // 是否启用微应用的独立运行时
	prefetch: true, // 开启预加载关掉  
	//sandbox: true,                      // 是否启用沙箱隔离
	sandbox: {
		 // 开启严格样式隔离,其实就是给每个子项目的根元素attachShadow,并将子项目挂载在这个影子节点上
		 // 导致的问题:一些第三方库的样式会丢失,因为他们可能期望挂载的body上,还有些样式依赖body什么的
		 strictStyleIsolation: true,
		// scoped隔离,会给每个子应用的样式添加div[data-qiankun=`${appName}`] 前缀
		// 导致的问题: 样式权重会受到影响,需要提前规避
		experimentalStyleIsolation: true,
	},
})
```

## 子应用
### 声明子应用QIANKUN_APP
```js
//.env
// 该名称必须与子应用的entry名称相同
VITE_QIANKUN_APP_NAME = 'residentdoctor'
```
## 子应用注入生命周期
### vue2

```js
//main.js
import Vue form 'vue';
import { getRouter } from './router';
import App from './App.vue';
import store from './store';
let app;

/**  
 * @param container 主应用下发的props中的container,也就是子应用的根节点  
 * 将子应用appendBody的元素,挂载到子应用根元素身上  
 * 用于解决乾坤子应用开启如下样式隔离方案后,添加到body的元素样式失效  
 * sandbox: {  
 *    以下配置项只能开启一个,另一个要为false  
 *    strictStyleIsolation: true,        //严格模式,其实就是给子应用根节点改造为shadowRoot,也就是套上shadowDom  
 *    experimentalStyleIsolation: true,  //样式隔离,就是给子应用的全局样式加上div[data-qiankun=`${appName}`],会导致scoped中的样式权重变低  
 * },  
 */
const proxy = (container) => {
  if (document.body.appendChild.__isProxy__) return;  
  const revocable = Proxy.revocable(document.body.appendChild, {  
    apply (target, thisArg, [node]) {  
      if (container) {  
        container.appendChild(node);  
      } else {  
        target.call(thisArg, node);  
      }  
    }  
  });  
  if (revocable.proxy) {  
    document.body.appendChild = revocable.proxy;  
  }  
  document.body.appendChild.__isProxy__ = true;  
};

function render(props) {  
	const { container } = props;  
	proxy(container)  
	
	const router = getRouter(props);
	app = new Vue({  
		router,  
		store,  
		render: h => h(App)  
	})
	if(container){  
		const root = container.querySelector('#app');  
		app.mount(root);  
	}else{  
		app.mount('#app')  
	}  
}
if (!window.__POWERED_BY_QIANKUN__) {  
  render({});  
}else{
	/**
	 * bootstrap 只会在微应用初始化的时候调用一次，下次微应用重新进入时会直接调用 mount 钩子，不会再重复触发 bootstrap。
	 * 通常我们可以在这里做一些全局变量的初始化，比如不会在 unmount 阶段被销毁的应用级别的缓存等。
	 */
	export async function bootstrap() {}
	/** 应用每次进入都会调用 mount 方法，通常我们在这里触发应用的渲染方法 */
	export async function mount(props) {
	  render(props);
	}
	/** 可选生命周期钩子，仅使用 loadMicroApp 方式加载微应用时生效 */
	export async function update(props) {}
	​
	/**  应用每次 切出/卸载 会调用的方法，通常在这里我们会卸载微应用的应用实例*/
	export async function unmount() {
	  app.$destroy()
	}
}
```
### vue3
```js
// main.js

// 引入vue,样式等
...
import App from './App.vue'  
  
import getRouter from './router'  
  
let app;  
  
/**  
 * @param container 主应用下发的props中的container,也就是子应用的根节点  
 * 将子应用appendBody的元素,挂载到子应用根元素身上  
 * 用于解决乾坤子应用开启如下样式隔离方案后,添加到body的元素样式失效  
 * sandbox: {  
 *    以下配置项只能开启一个,另一个要为false  
 *    strictStyleIsolation: true,        //严格模式,其实就是给子应用根节点改造为shadowRoot,也就是套上shadowDom  
 *    experimentalStyleIsolation: true,  //样式隔离,就是给子应用的全局样式加上div[data-qiankun=`${appName}`],会导致scoped中的样式权重变低  
 * },  
 */
const proxy = (container) => {
  if (document.body.appendChild.__isProxy__) return;  
  const revocable = Proxy.revocable(document.body.appendChild, {  
    apply (target, thisArg, [node]) {  
      if (container) {  
        container.appendChild(node);  
      } else {  
        target.call(thisArg, node);  
      }  
    }  
  });  
  if (revocable.proxy) {  
    document.body.appendChild = revocable.proxy;  
  }  
  document.body.appendChild.__isProxy__ = true;  
};  

function render(props) {  
  const { container } = props;  
  proxy(container)  
  app = createApp(App);  
  // 注册指令  
  directives(app)  
  // 注册组件  
  for (const [key, component] of Object.entries(ElementPlusIconsVue)) {  
    app.component(key, component)  
  }  
  const pinia = createPinia()  
  pinia.use(piniaPluginPersistedstate)  
  app.provide('getUtils', utils)  
  app.use(pinia)  
  
  // 测试主题变更  
  // const themeStore = useThemeStore()  
  // themeStore.setTheme('red');  const router = getRouter(props);  

  const router = getRouter(props);
  app.use(router)  
  app.use(ElementPlus)  
  if(container){  
    const root = container.querySelector('#app');  
    app.mount(root);  
  }else{  
    app.mount('#app')  
  }  
}

// 独立运行时  
if (!qiankunWindow.__POWERED_BY_QIANKUN__) {  
  render({});  
}else{  
	renderWithQiankun({  
		/** 应用每次进入都会调用 mount 方法，通常我们在这里触发应用的渲染方法 */
		mount (props) {  
			render(props);  
		},
		/**
			* bootstrap 只会在微应用初始化的时候调用一次，下次微应用重新进入时会直接调用 mount 钩子，不会再重复触发 bootstrap。
			* 通常我们可以在这里做一些全局变量的初始化，比如不会在 unmount 阶段被销毁的应用级别的缓存等。
		*/
		bootstrap () {},
		/** 可选生命周期钩子，仅使用 loadMicroApp 方式加载微应用时生效 */
		update(props){},
		/**  应用每次 切出/卸载 会调用的方法，通常在这里我们会卸载微应用的应用实例*/
		unmount (props) {  
			app.unmount();  
			app = null;  
		},  
	});  
}
```
## 子应用设置服务基础路径

基础路径需要与 activeRule 相同, 用于主应用匹配子应用并激活, 和 nginx 代理
### vue2

```javascript
// vue.config.js或webpack.config.js中

// 基础路径需要与 activeRule 相同, 用于主应用匹配子应用并激活, 和 nginx 代理
module.exports = {
  //publicPath将服务本来是 http://172.18.120.209:3333/的变为 http://172.18.120.209:3333/residentdoctor/
  publicPath: `/${process.env.VITE_QIANKUN_APP_NAME}`,
  ...,
}
```

### vite

```javascript
// vite.cofing.js

// 基础路径需要与 activeRule 相同, 用于主应用匹配子应用并激活, 和 nginx 代理
import qiankun from "vite-plugin-qiankun";
export default ({ mode }: ConfigEnv): UserConfig => {
	const VITE_QIANKUN_APP_NAME=process.env.VITE_QIANKUN_APP_NAME
    return {
        //publicPath将服务本来是 http://172.18.120.209:3333/的变为 http://172.18.120.209:3333/residentdoctor/
        base: `/${VITE_QIANKUN_APP_NAME}$`,
        plugins:[
            qiankun(VITE_QIANKUN_APP_NAME, {
              useDevMode: true, // 开发环境必须配置
            }),
        ]
    }
}
```

## 子应用设置路由
### vue2
```js
import VueRouter from 'vue-router';
const routes=[...]
export const getRouter = function(props) {  
  let base = '';  
  if (window.__POWERED_BY_QIANKUN__) {  
    const { activeRule='/' } = props.data;  
    ... 
    base = activeRule;
  } else {  
    base = process.env.BASE_URL;
  }  
  const router = new VueRouter({  
    base,  
    mode:'history',  
    routes  
  });
```
### vue3

```js
import { createRouter, createWebHistory } from 'vue-router'  
import { qiankunWindow } from 'vite-plugin-qiankun/dist/helper'
import { isEmpty,assign } from 'radash'

const routes= [...]

function getRouter(props) {  
  let base;  
  const routes=_.cloneDeep(Routes);  
  if (qiankunWindow.__POWERED_BY_QIANKUN__) {  
    const { activeRule='/' } = props.data;  
    ... 
    base = activeRule;
  }  
  else {  
    base = `/${import.meta.env.VITE_QIANKUN_APP_NAME}`  
  }  
  const router = createRouter({  
    history: createWebHistory(base),  
    routes
  })

	
  router.beforeEach((to, from, next) => {
      _.assign(history.state, { current: from.fullPath })  
    }  
    next()  
  })  
  return router  
}  
  
export default getRouter
```
# 应用通信

## 乾坤提供的 globalState 通信方式

```js
//父应用通过在注册子应用时,添加props配置项,将actions传递给子应用,子应用则可脱离qiankun包
import {initGlobalState , MicroAppStateActions } from 'qiankun';
​
//初始化globalState
const actions:MicroAppStateActions = initGlobalState(state);
//监听globalState变化
actions.onGlobalStateChange((state,preState)=>{});
//更新globalState
actions.setGlobalState(newState);
//卸载globalState
actions.offGlobalStateChange();
```

## 事件流方式

```js
//因为qiankun父子应用在同一个页面上,可以通过事件流进行通信
//实例创建完毕后message不可变,如需要变化,需要重新创建事件实例
new CustomEvent('eventdemo', { detail: message })
window.dispatchEvent('eventdemo');
​
​
mounted() {
  window.addEventListener('eventdemo',res=>{}, false);
},
beforeDestroy() {
  window.removeEventListener('eventdemo', res=>{},false);
}
​
```

# 如何在本地连上远程的主应用 (壳子)

```javascript
远程主项目在http://192.168.18.228:9999/middle/
本地子项目在http://172.18.120.209:3333/TSIDS/ 本地服务器地址(本地IP+端口,在devsever配置)
​
​
// 子项目通过nginx代理转发请求,使请求能正常请求远程服务器,例如我现在代理83端口,
//  location ^~/middle/ {proxy_pass http://192.168.18.228:9999/middle/; #开发时运行访问地址}
'/middle路由对应主项目,代理middle到主项目所在的远程服务器地址http://192.168.18.228:9999/middle/,'
​
此时,我们访问localhost:83/middle,nginx帮我们代理转发到http://192.168.18.228:9999/middle/,获取到主应用,浏览器会将主应用下载到当前域名,也就是localhost:83下的middle目录(因为主项目的vue.config.js配置了publicPath: '/middle',)
​
//registerMicroApps([
//    {
//        name: 'app1',
//        entry: '/TSIDS/',
//        container: '#container',
//        activeRule: '/middle/TSIDS/',
//    },
//])
​
'主应用设置微应用时注意entry不能和activeRule一样,否则刷新则变成微应用'
'微应用的 webpack 打包和devserver的 publicPath和部署时的目录(相对于主应用所在目录的相对路径) 都需要跟entry一致,这里是 /TSIDS/'
    'publicPath将服务本来是 http://172.18.120.209:3333/的变为 http://172.18.120.209:3333/TSIDS/'
​
'子项目的activeRule会作为子项目的路由基础路径,activeRule为/middle/TSIDS/'
'由于主应用配置子应用时,entry仅指定了相对路径/TSIDS/'
'最终访问localhost:83/middle/TSIDS/会先访问http://192.168.18.228:9999/middle/获取主应用'
'主应用基于当前域名通过相对路径/TSIDS/访问子应用,即localhost:83/TSIDS/,'
'而/TSIDS/又被代理到http://172.18.120.209:3333/TSIDS/,'
'至此,完成了子应用本地连上远程的主应用'
```

![](./images/WEBRESOURCE8d9068a993116e9724ff3ffbc7061099bee332e41f444312d6ddf44eaaa60403.png)


