---
title: uniapp
description: uniapp笔记
date: 2025-01-28
ptags:
  - 前端
tags:
  - 移动端
---


---

### Uniapp 常见 API 及常用参数

| **API 分类** | **API 名称**                                         | **常用参数**                                           | **功能描述**         |
| ---------- | -------------------------------------------------- | -------------------------------------------------- | ---------------- |
| **用户信息**   | `uni.getUserInfo({withCredentials})`               | `withCredentials`（是否包含敏感信息）                        | 获取用户信息，包括昵称、头像等  |
|            | `uni.login({success(res){}})`                      | 无                                                  | 获取用户登录凭证（code）   |
| **数据存储**   | `uni.setStorageSync(key, data)`                    | `key`（键名）、`data`（存储的数据）                            | 同步方式存储数据到本地缓存    |
|            | `uni.getStorageSync(key)`                          | `key`（键名）                                          | 同步方式从本地缓存获取数据    |
| **网络请求**   | `uni.request(url, data, method)`                   | `url`（请求地址）、`data`（请求参数）、`method`（请求方法）            | 发起 HTTPS 网络请求    |
| **支付**     | `uni.requestPayment(timeStamp, nonceStr, package)` | `timeStamp`（时间戳）、`nonceStr`（随机字符串）、`package`（订单信息） | 发起微信支付请求         |
| **设备信息**   | `uni.getSystemInfoSync()`                          | 无                                                  | 获取系统信息，如屏幕宽度、高度等 |
| **位置信息**   | `uni.getLocation(type, isHighAccuracy)`            | `type`（坐标类型）、`isHighAccuracy`（是否高精度）               | 获取用户地理位置         |
| **媒体**     | `uni.chooseImage(count, sizeType)`                 | `count`（选择图片数量）、`sizeType`（图片尺寸类型）                 | 从相册或相机选择图片       |
|            | `uni.previewImage(urls, current)`                  | `urls`（图片链接列表）、`current`（当前显示图片的链接）                | 预览图片             |
| **分享**     | `uni.shareAppMessage(title, path)`                 | `title`（分享标题）、`path`（分享路径）                         | 分享小程序页面          |

---

### Uniapp 登录流程

1. **调用 `uni.login()`**  
   小程序调用 `uni.login()` 获取临时登录凭证 `code`。

2. **发送 `code` 到服务器**  
   将 `code` 发送到开发者服务器，服务器通过微信接口（如 `code2Session`）换取用户的唯一标识 `openid` 和会话密钥 `session_key`。

3. **生成自定义登录态**  
   服务器根据 `openid` 和 `session_key` 生成自定义登录态（如 token），并返回给小程序。

4. **存储登录态**  
   小程序将登录态存储在本地（如 `uni.setStorageSync`），用于后续请求的身份验证。

---

### Uniapp 支付流程

1. **生成订单**  
   用户在小程序中选择商品并提交订单，后端生成支付订单，包括订单号、金额等信息。

2. **调用统一下单接口**  
   后端调用微信支付的统一下单接口，获取支付参数（如 `timeStamp`、`nonceStr`、`package` 等）。

3. **发起支付请求**  
   小程序调用 `uni.requestPayment()`，传入支付参数，唤起微信支付界面。

4. **支付结果回调**  
   用户完成支付后，微信服务器会通知后端支付结果，后端更新订单状态并返回支付结果给小程序。

5. **支付成功提示**  
   小程序根据支付结果提示用户支付成功或失败。