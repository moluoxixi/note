# 创建electron应用
接口文档
	https://www.electronjs.org/zh/docs/latest/api/app

```javascript
//npm create vue 项目名
-->1.下载electorn,及其依赖包
	npm install --save-dev electron

-->2.package.json的scripts添加electron启动命令
	//"start": "electron ."

-->3.创建electron窗口及销毁函数
	//app 控制应用生命周期的模块。
	//BrowserWindow 创建原生浏览器窗口的模块
	const { app, BrowserWindow } = require('electron')
	
	
	
	const createWindow = () => {  
		const win = new BrowserWindow({  
			width: 800,  
			height: 600  
		})  
		win.loadFile('index.html')  
	}
	
	// 当 Electron 完成了初始化并且准备创建浏览器窗口的时候
	//app.on('ready', () => {})这个等同app.whenReady
	app.whenReady().then(() => {  
		//如果没有窗口打开,则创建一个窗口
		// 在 macOS 系统内, 如果没有已开启的应用窗口  
		// 点击托盘图标时通常会重新创建一个新窗口
		app.on('activate', () => {  
			if (BrowserWindow.getAllWindows().length === 0) createWindow()  
		})
	})
	
	app.on('window-all-closed', () => {  
		if (process.platform !== 'darwin') {  
			app.quit()  
		}
	})

-->4.运行
	//electron-prebuild
	//如果你已经用 npm 全局安装了 electron-prebuild，你只需要按照如下方式直接运行你的应用：
	electron .
	
	//如果你是局部安装，那运行：
	./node_modules/.bin/electron .

-->5.打包
	npm install --save-dev @electron-forge/cli  
	npx electron-forge import
	//执行完毕后会在package.json的scripts中添加三条指令
	"start": "electron-forge start",  
	"package": "electron-forge package",  
	"make": "electron-forge make"
	
	npm run make
```
# 常见 api

|     |     |
| --- | --- |
|     |     |
