## 链接

1. 

1. 

## 创建项目

需要node18.16+

```javascript
pnpm create vuepress vuepress-starter
```

执行完毕后,会生成如下结构的目录:

```javascript
├─ docs
│  ├─ .vuepress
│  │  ├─ client.js(手动建)   <--- 客户端配置文件
│  │  └─ config.js           <--- 配置文件
│  └─ README.md
└─ package.json
```

## config.js

项目的配置文件,参考

[https://vuepress.vuejs.org/zh/reference/config.html](https://vuepress.vuejs.org/zh/reference/config.html)

### demo

```javascript
import { defineUserConfig } from 'vuepress';
import { defaultTheme } from '@vuepress/theme-default';
import { viteBundler } from '@vuepress/bundler-vite';

export default defineUserConfig({
  base: '/',
  title: 'My VuePress Site',
  description: 'A site built with VuePress',
  bundler: viteBundler(),
  theme: defaultTheme({
    navbar: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/guide/' },
      {
        text: 'Languages',
        children: [
          { text: 'English', link: '/language/english/' },
          { text: '简体中文', link: '/language/chinese/' },
        ],
      },
      { text: 'External', link: 'https://google.com' },
    ],
    sidebar: 'auto',
  }),
  plugins: [
    // 插件配置
  ],
  markdown: {
    lineNumbers: true,
  },
});
```

### 常用配置

- **基本配置**

- base：站点的基础路径，默认值为 '/'。

- title：网站的标题。

- description：网站的描述。

- bundler：指定打包器，可以使用 viteBundler 或 webpackBundler。

- **主题配置**

- theme：指定主题，通常使用 defaultTheme。

- **主题配置项**

- navbar：配置导航栏。

- sidebar：配置侧边栏。

- home：配置首页。

- logo：配置站点的 Logo。

- repo：配置 Git 仓库地址。

- docsRepo：配置文档的 Git 仓库地址。

- docsBranch：配置文档的 Git 分支。

- docsDir：配置文档的目录。

- editLinkText：配置编辑链接的文本。

- **插件配置**

- plugins：配置插件，可以通过数组方式添加插件及其选项。

- Markdown 配置

- markdown：配置 Markdown 相关选项。

- lineNumbers：是否显示行号。

- extractHeaders：指定提取哪些 headers。

- **本地化配置**

- locales：配置多语言支持。

- **部署相关配置**

- dest：输出目录。

- temp：临时文件目录。

- cache：缓存文件目录。

- **高级配置**

- head：用于修改 HTML <head>。

- extendsMarkdown：扩展 Markdown 解析。

- extendsPageData：扩展页面数据。

- clientAppEnhanceFiles：客户端增强文件。

- clientAppRootComponentFiles：客户端根组件文件。

- **开发服务器配置**

- devServer：配置开发服务器选项。

- **其他配置**

- shouldPrefetch：是否启用 <link rel="prefetch">。