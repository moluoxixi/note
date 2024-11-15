# qiankun 子应用接入文档
## 子应用注入生命周期
### vue2

```js
//main.js
import Vue form 'vue';
import { getRouter } from './router';
import App from './App.vue';
import store from './store';
let app;

function render(props) {  
	const { container } = props;  
	
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
  
function render(props) {  
  const { container } = props;  
  app = createApp(App);  
  ...
  const router = getRouter(props);
  app.use(router)
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
  publicPath: `/residentdoctor/`,
  ...,
}
```

### vite

```javascript
// vite.cofing.js

// 基础路径需要与 activeRule 相同, 用于主应用匹配子应用并激活, 和 nginx 代理
import qiankun from "vite-plugin-qiankun";
export default ({ mode }: ConfigEnv): UserConfig => {
    return {
        //publicPath将服务本来是 http://172.18.120.209:3333/的变为 http://172.18.120.209:3333/residentdoctor/
        base: "/residentdoctor/",,
        plugins:[
            qiankun("residentdoctor", {
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
    base = '/residentdoctor'  
  }  
  const router = createRouter({  
    history: createWebHistory(base),  
    routes
  })
}  
  
export default getRouter
```

## bug 修复
### 子应用的 ui 组件会存在部分 body.appendChild
```js
//一些ui库会将元素添加到body中,会导致这部分元素样式丢失

//解决方案:
// 将子应用appendBody的元素,挂载到子应用根元素身上  
const proxy = (container) => {  
  console.log(document.body.appendChild);  
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


// main.js

export function mount(props) {
  proxy(props.container);
  ...
}
```

### vue 3 作为子应用, 路由切换出现 undefined
https://github.com/umijs/qiankun/issues/2254
```javascript
// vue3作为子应用,路由来回切换会出现undefined(好像是跳子路由)


// 解决方法
import { isEmpty,assign } from 'radash'
router.beforeEach((to, from, next) => {  
  if (_.isEmpty(history.state.current)) {  
    _.assign(history.state, { current: from.fullPath });  
  }  
  next();
});
```

### 子应用开启 experimentalStyleIsolation 后, 局部样式未添加前缀, 会导致权重问题
```js
//experimentalStyleIsolation用于样式隔离,会给全局style加上div[data-qiankun=`${appName}`] 前缀
//但是<style scoped></script>中的样式不会添加


// 解决方案: scoped中所有deep部分添加权重,或在vite或webpack打包时进行css处理
```