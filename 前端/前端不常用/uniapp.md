## uniApp

目前只能@vue/cli@4 版本及以下创建

推荐@4.5.15

```
vue create -p dcloudio/uni-preset-vue 项目文件名
```

默认版本

### tsconfig.json报错问题

创建tsconfig.json配置文件时，VSCode会自动检测当前项目当中是否有ts文件，若没有则报错

解决方案:

在项目根目录下随便建一个ts文件,新建一个puppet.ts，puppet：傀儡的意思

tsconfig.json

```
{
    "compilerOptions": {
        "types": ["@dcloudio/types", "miniprogram-api-typings", "mini-types"]
    }, 
    "files": ["puppet.ts"]
}
```

### pages.json和manifest.json报红

因为在


# 小程序

## sitemap.json

## app.json

pages:配置页面,相当于路由,路径以pages开头

```
pages:[
    'pages/文件相对于pages的路径',
    ...
]
```

window:

```
头部导航栏的背景色,只能是#开头的rgb格式
'navigationBarBackgroundColor':'#ccc',
//导航栏的标题
"navigationBarTitleText": "Weixin",
导航栏标题的字体颜色,只能是black或white
"navigationBarTextStyle":"black"
```

## app.wxss

放公共样式

## js文件

index.js

### Page函数

用于创建当前页面,并规定该页面的行为

```
Page(config)
```

app.js

### App函数

用于创建应用

## 事件

事件的回调函数直接作为Page函数的配置项

事件的回调函数内可以通过this获取该组件实例

```
<input bindtap="hander" />

Page({
    hander(event){}
})
```

### 标签上的事件

|事件名|是什么事件|
|---|---|
|bindtap|点击事件|
|catchtap|不带冒泡的点击|
|touchstart|手指触摸动作开始|
|touchmove|手指触摸后移动|
|touchcancel|手指触摸动作被打断，如来电提醒，弹窗|
|touchend|手指触摸动作结束|
|||

### 事件对象

|||
|---|---|
|event.currentTarget|触发事件的元素,而不是接收事件冒泡的元素|
|touches|手指按压对象,具有按压坐标等|
|||

## 钩子

app

||小程序初始化完毕触发,只能触发一次|
|---|---|
||小程序出现在前台触发|
||小程序隐藏在后台触发|
||小程序报错时触发|

page

|onLoad|页面加载时触发|
|---|---|
|onShow|页面显示时触发|
|onHide|页面隐藏时触发|
|onReady|页面文档记录添加时触发|
|onUnload|页面文档记录销毁时触发|

## 其他函数

||||
|---|---|---|
|this.setData(newDataInfo)|用于设置data,接收新的data对象||
|wx.navigateTo/redirectTo(config)  <br>config-->{url:'/pages/文件相对于pages的路径'}|保留/替换当前页面的文档记录,跳转至指定路由,**不能跳转到tabbar配置中的页面**||
|wx.reLaunch()|关闭所有页面,打开一个新页面||
|wx.getUserProfile(config)  <br>config-->{desc:'描述',success:(userInfo)=>{},fail:(err)=>{}}|获取用户信息|userInfo-->{nickName:用户名,avatarUrl:头像地址,}|
|wx.showToast(config)|显示消息提示框||
|wx.show/hideLoading(config)|显示loading||
||||
||||

## 组件

|||
|---|---|
|view|视图-->div|
|image|图片-->img|
|text|文字-->span|
|video||
|scroll-view||
|swiper/swiper-item||

video

```
VideoContext=createVideoContent(video标签的id)
VideoContext.play()    //播放视频
VideoContext.pause()    //暂停视频
VideoContext.seek(playTime)    //跳转到指定进度
```

参数一接收一个对象

{from,target}

## 音频

BackgroundAudioManager

title和src必须有才能播放

[https://developers.weixin.qq.com/miniprogram/dev/api/media/background-audio/BackgroundAudioManager.html](https://developers.weixin.qq.com/miniprogram/dev/api/media/background-audio/BackgroundAudioManager.html)

## tabbar

```
"tabBar": {
    "color": "",
    "selectedColor": "",
    "list": [
        {
            "pagePath": "",
            "text": "",
            "iconPath": "",
            "selectedIconPath": ""
        },
    ],
},
```

### 微信登录流程

#### 服务器发送以下字段给微信接口,返回openId,session_key等

openId作用:

```
接口:
https://api.weixin.qq.com/sns/jscode2session?appid=${appId}&secret=${secret}&js_code=${code}&grant_type=authorization_code
```

AppId:小程序唯一标识

AppSecret:小程序密钥

code:用户登录信息,调用wx.login后success返回的标识

#### 将返回的数据加密,返回给客户端保存

#### 客户端请求时,携带加密的信息,服务器解密,将openId,session_key进行校验

# uniapp

## 脚手架创建(vscode用这个,hb早帮你创建好了)

```
vue create -p dcloudio/uni-preset-vue 项目名
```

## 配置

### manifest.json

设置小程序的AppID

es6->es5

打包压缩

...

### pages.json

配置页面信息

​ ->path:路由路径

​ ->style路由页面的样式-->标题,标题色,tabbar...

## vue2

### main.js

```
import Vue from 'vue';
import App from '根组件的路径';
// 把App组件注册为小程序的应用
App.mpType = 'app'
```

### 组件内

```
<script>
    export default {
        vue2的各种特性,除了生命周期钩子
        data(){},
        methods:{},
        ...
        小程序的是生命周期钩子
        onLaunch(){},
        ...
    }
</script>
```

### 请求

仍然使用wx.request,不能使用ajax