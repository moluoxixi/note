## 核心组成

前端部分：依赖系统内置Webview组件。例如，在Windows上使用Edge/Webview2，在macOS上使用WebKit，在Linux上使用WebKitGTK。

后端部分：采用rust编写，负责与操作系统交互、处理系统事件、安全控制和API调用。

> v8将js转成机器码执行,且具有多种优化策略
> webview基于webkit引擎,在执行js上性能不佳


## 项目构建及相关依赖下载
https://tauri.app/zh-cn/v1/guides/getting-started/prerequisites

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

-->rust写函数,前端接收
	//src/server/demo.rs
	//固定声明,
	#[tauri::command]  
	fn greet(name: &str) -> String {  
		format!("Hello, {}!", name)  
	}

     fn main() {
       //
       tauri::Builder::default()
         .invoke_handler(tauri::generate_handler![greet])
         .run(tauri::generate_context!())
         .expect("error while running tauri application");
     }

	//前端页面中
	import { invoke } from '@tauri-apps/api'  
	const demo=async ()=> {  
		//调用rust抛出的方法
		const res=aawit invoke('greet', { name: 'World' }) 
  		console.log(res) // "Hello, World!"！  
	}
  
```
