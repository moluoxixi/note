## 核心组成

前端部分：依赖系统内置Webview组件。例如，在Windows上使用Edge/Webview2，在macOS上使用WebKit，在Linux上使用WebKitGTK。

后端部分：采用rust编写，负责与操作系统交互、处理系统事件、安全控制和API调用。

> v8将js转成机器码执行,且具有多种优化策略
> webview基于webkit引擎,在执行js上性能不佳
