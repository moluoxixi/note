# tauri
前端部分：依赖系统内置 Webview 组件。例如，在 Windows 上使用 Edge/Webview2，在 macOS 上使用 WebKit，在 Linux 上使用 WebKitGTK。

后端部分：采用 rust 编写，负责与操作系统交互、处理系统事件、安全控制和 API 调用。

> v8 将 js 转成机器码执行, 且具有多种优化策略
> webview 基于 webkit 引擎, 在执行 js 上性能不佳

预先准备:https://tauri.app/zh-cn/v1/guides/getting-started/prerequisites
前端 api:https://tauri.app/zh-cn/v1/api/js/

```js
-->1.下载rust
	-->window下载
		  winget install --id Rustlang.Rustup
		  //或者去官网下载https://www.rust-lang.org/tools/install
	
	-->macOS下载
		  xcode-select --install
		  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf \| sh
		

-->2.rust更新/卸载/查看版本号
	rustup update
	rustup self uninstall
	rustc --version
	
-->3.下载相关依赖
	//一个前端包,提供一些类node的方法以供前端直接调用
	npm install @tauri-apps/api

-->4.rust写函数,前端接收
	//src/server/demo.rs
	//固定声明,
	#[tauri::command]  
	fn greet(name: &str) -> String {  
		format!("Hello, {}!", name)  
	}

     fn main() {
       //创建 Tauri 应用构建器
       tauri::Builder::default()
         //invoke_handler(tauri::generate_handler![处理器名]  ,设置greet为调用处理器,抛给前端调用
         .invoke_handler(tauri::generate_handler![greet])
         //运行应用
         .run(tauri::generate_context!())
         //错误处理
         .expect("error while running tauri application");
     }

	//前端页面中
	import { invoke } from '@tauri-apps/api'  
	const demo=async ()=> {  
		//调用rust抛出的处理器方法
		const res=aawit invoke('greet', { name: 'World' }) 
  		console.log(res) // "Hello, World!"！  
	}
  
```
