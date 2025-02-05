---
title: electron
description: electron
date: 2025-01-28
ptags:
	- 前端
tags:
	- electron
---
# 创建electron应用
接口文档
	https://www.electronjs.org/zh/docs/latest/api/app

```javascript
//npm create vue 项目名
-->1.下载electorn,及其依赖包
	npm install --save-dev electron


-->2.创建electron
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

-->3.运行
    package.json的scripts添加electron启动命令，"start":"指令"
    //electron-prebuild
	//如果你已经用 npm 全局安装了 electron-prebuild，指令为：
	electron .

	//如果你是局部安装，那指令为：
	./node_modules/.bin/electron .

    // 如果使用vite-plugin-electron/simple，指令为：
    vite
    
-->5.打包

	-->vite-plugin-electron/simple
			
		
		
	-->electron-forge,使用make
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
# ipcRenderer通信
用于主进程和渲染进程之间相互通信
1. 主进程：创建electron应用的那个进程，对应着package.json中main指定的那个文件
2. 渲染进程：创建前端应用的那个进程，也就是前端文件的入口文件，例如src/main.js

| api                                | 说明                                                                        |
| ---------------------------------- | ------------------------------------------------------------------------- |
| ipcRenderer.send("名称",参数)          | 主进程和渲染进程之间单向发送消息，没有返回                                                     |
| ipcRenderer.on("名称",(event,参数)=>…) | 接受指定名称发送的参数                                                               |
| ipcRenderer.invoke("名称",参数)        | 渲染发送参数。返回promise接受主应用的响应。它的响应来自于ipcMain.handle("名字",(event,参数)=>返回值)中的返回值 |
|                                    |                                                                           |
|                                    |                                                                           |
```js
//渲染进程
//通常这些方法会被在preview.js中封装，并挂载到window上
const { ipcRenderer } = require('electron');

// 假设你有一个名为 'some-function' 的处理器在主进程中注册
ipcRenderer.invoke('some-function', arg1, arg2, ...)
  .then(result => {
    // 处理从主进程返回的结果
    console.log(result);
  })
  .catch(error => {
    // 处理错误
    console.error(error);
  });


//主进程
const { ipcMain } = require('electron');

ipcMain.handle('some-function', async (event, arg1, arg2, ...) => {
  // 在这里执行一些逻辑
  const result = // ... 你的逻辑结果
  return result; // 这个返回值将会被传递到渲染进程的 .then() 方法中
});

```
