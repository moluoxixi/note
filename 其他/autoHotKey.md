---
title: autoHotKey
description: 一个autoHotKey笔记
date: 2025-02-13
hidden: false
tags: autoHotKey
ptags: 
---
# 命令集合
## window 命令
w+r 然后输入命令

| 命令            | 说明                                  |
| ------------- | ----------------------------------- |
| shell:startup | 打开 window 启动文件夹，该文件夹内的所有 exe 都会开启运行 |

## autoHotKey 命令
ahk_exe 用于匹配进程名的标识符

| 命令                          | 说明                                                                 |
| --------------------------- | ------------------------------------------------------------------ |
| 按键::                        | 定义快捷键，放于文件头部<br>eg:+Space 代表 shift+space, 加号代表 shift               |
| WinGet, 变量名, ProcessName, A | 获取当前活动窗口的进程名并存入指定变量中<br>ID 窗口句柄<br>ProcessName 进程名<br>A 当前活动窗口<br> |
| IfWinActive, ahk_exe 进程名    | 当前活动窗口是否属于指定的进程                                                    |
| IfWinExist, ahk_exe 进程名     | 检查指定的窗口是否存在                                                        |
| WinActivate, ahk_exe  进程名   | 激活指定窗口                                                             |
| WinRestore, ahk_exe 进程名     | 恢复指定的窗口（如果窗口被最小化，则将其还原）                                            |
