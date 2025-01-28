---
title: vitepress
description: vitepress
date: 2025-01-28
tags:
 - 前端
---
[vitepress](https://juejin.cn/post/7362547962604437541?searchId=20250116152459C477D53F0033D50AF80C#heading-40)
 https://vitepress.dev/reference

## 主页
https://vitepress.dev/reference/default-theme-home-page

| 分类                     | 说明                        |
| ---------------------- | ------------------------- |
| layout                 | 布局方式，分为 doc/home/page     |
| [hero](#hero)          | 主页头部内容, 仅 layout: home 生效 |
| [features](##features) | 主页头部下面的卡片列表               |
| 写在双 `---` 之外           | 其他 markdown 内容            |

主页对应 index. md 内容，主要如图
![[Pasted image 20250116165617.png]]
![[Pasted image 20250116165516.png]]
### 例子
```sh
---
# https://vitepress.dev/reference/default-theme-home-page
# 分为doc/home/page
layout: home

# 主页头部内容,仅 layout:home 生效
hero:
  # 最大的标题
  name: "vueComponent"
  # 次标题
  text: "一个vue组件库"
  # 标题右侧显示的图片
  # image: https://vuejs.org/images/logo.png
  # 描述
  tagline: My great project tagline
  # 操作按钮集合
  actions:
    # 按钮背景 brand蓝色,alt灰色
    - theme: brand
      # 按钮文字
      text: Markdown Examples
      # 按钮跳转的链接
      link: /markdown-examples

# 头部下面的内容,是一串卡片
features:
  - title: Feature A
    details: Lorem ipsum dolor sit amet, consectetur adipiscing elit
---

## 首页模块 MD 文档

MD 文件
```
### hero
```js
interface Hero {
  // `text` 上方的字符，带有品牌颜色
  // 预计简短，例如产品名称
  name?: string
  // hero 部分的主要文字，
  // 被定义为 `h1` 标签
  text: string
  // `text` 下方的标语
  tagline?: string
  // text 和 tagline 区域旁的图片
  image?: ThemeableImage
  // 主页 hero 部分的操作按钮
  actions?: HeroAction[]
}

```
### features
```js
interface Feature {
  // 在每个 feature 框中显示图标
  icon?: string | {
  	dark : string,
  	light : string
  }
  // feature 的标题
  title: string
  // feature 的详情
  details: string
  // 点击 feature 组件时的链接，可以是内部链接，也可以是外部链接。
  link?: string
  // feature 组件内显示的链接文本，最好与 `link` 选项一起使用
  linkText?: string
  // `link` 选项的链接 rel 属性
  rel?: string
  // `link` 选项的链接 target 属性
  target?: string
}

```

## themeConfig
`.vitepress/config.*` 里的配置

```js
import { defineConfig } from 'vitepress'
// https://github.com/mingyuLi97/blog
// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "vueComponent",
  description: "一个vue组件库",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    // 标题
    siteTitle:'vueComponent',
    // logo
    logo: `https://vuejs.org/images/logo.png`,
    // 导航栏
    nav: [
      // 单层级
      { text: 'Home', link: '/' },
      // 多层级
      {
        text: 'examples',
        items: [
          {
            text: 'markdown-examples',
            items: [
              { text: 'markdown-examples', link: '/markdown-examples' },
            ]
          }
        ]
      },
    ],

    // 侧边栏,配置基本同导航栏
    sidebar: [
      // 单层级
      {
        text: 'Home',
        link: '/',
        // 是否可折叠
        collapsed: false,
      },
      // 多层级
      {
        text: 'examples',
        items: [
          {
            text: 'markdown-examples',
            items: [
              { text: 'markdown-examples', link: '/markdown-examples' },
            ]
          }
        ]
      },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/vuejs/vitepress' }
    ],
    // 搜索配置
    search: {
      // local or algolia
      provider: 'local'
      // //#region algolia
      // algolia有两种方式,
      	// 使用Crawler爬虫,
      	// 或者github的DocSearch Scraper Action
      	// 参考https://juejin.cn/post/7157340749065895944
      // provider: 'algolia',
      // options: {
      //   appId: 'U30ELOTLE6',
      //   apiKey: 'b6db2a4a0256519acf2e1d3408781856',
      //   indexName: 'vueComponent'
      // }
      // //#endregion
    }
  }
})

```

