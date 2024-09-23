# 初始化项目

```js
//不需要这个
//npx create-react-app --template typescript 项目名称
//装在全局
npx storybook@latest init
//装在本地
npx storybook@latest -s init
```

[https://storybook.js.org](https://storybook.js.org)

[https://juejin.cn/book/7294082310658326565/section/7298717990865633318](https://juejin.cn/book/7294082310658326565/section/7298717990865633318)

# **开造**

storybook运行依赖.storybook下的配置文件,main.ts是主文件,**preview.ts是所有 story 的公共配置**

![](images/WEBRESOURCE7ee8962166a5c47ddcadd2f677906154image.png)

## 目录结构

```
.storybook
src
    assets
    components
        Button
            Button.stories.ts
            index.css
            index.tsx
```


## story 配置
`.storybook/preview.js` 是所有 story 的公共配置,**需要 export default 导出**
`*/组件名.stories.*` 中的 meta 对象是某个组件下 story 的公共配置, **需要 export default 导出**
`*/组件名.stories.*` 中的独立导出的对象是某个组件下 story 的配置, **需要 export 变量名 导出**

根据 story>meta>preview 的原则覆盖合并

| 配置                    | 说明                                                                                                                                                                                                                                                                                                                              |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| (meta 特有)title        | 组件显示在页面中的名称                                                                                                                                                                                                                                                                                                                     |
| (meta 特有)component:组件 | 应该使用哪个组件                                                                                                                                                                                                                                                                                                                        |
| args:{...}            | 传递给组件的参数                                                                                                                                                                                                                                                                                                                        |
| argTypes:{...}        | 配置传递给组件的参数的控制器行为, 默认根据参数类型/默认值自动生成对应控制器类型<br>argTypes:{<br>  //参数描述, 默认取 jsdoc 中的描述<br>  description: '背景',<br>  //控制器行为, 只写 type 时可简写为 control: type 类型 <br>    //常见类型有: radio, inline-radio, range, date, select, inline-radio, color, object,<br>  control: 'select',<br>  //参数值隐射<br>  mapping:{参数: 隐射的值, 可以是 jsx}<br>}<br> |
| parameters:{...}      | 全局参数配置<br>parameters:{<br>  layout: 'centered'   //组件的布局方式, centered 垂直水平居中, fullscreen 占满全屏,padded (默认) 组件周围填充空白<br>  backgrounds: [{      //组件的背景<br>    default: 'dark',  <br>    values:[{name: 'dark',value: ' #333 '}]<br>  }],<br>}                                                                                      |
|                       |                                                                                                                                                                                                                                                                                                                                 |

meta 中这些配置项, 除了 title, 都可以写到 preview. ts 中作为全局配置

```javascript
// Button/Button.stories.ts
import type { Meta, StoryObj } from '@storybook/react'; //vue3是@storybook/react
import { expect } from '@storybook/test'
import { Button,ButtonProps } from './index';

type metaType=Meta<typeof Button>;
//Button下所有story的公共配置
const meta: metaType = {
  title:'Example/Primary', //显示的名称
  tags:['autodocs'], //生成上图的Docs那个所有story的组合文档
  args:{}, //传递给组件的参数
  argTypes:{}, //配置传递给组件的参数应该用哪些控制器类型, 默认根据参数类型/默认值自动生成对应控制器类型
  parameters: { //组件参数
  	layout: 'centered' //组件的布局方式,centered垂直水平居中,fullscreen占满全屏,padded(默认)组件周围填充空白
  },
  
  //可以用render自定义组件,一般返回组件,vue可返回组件配置项
  render(args:ButtonProps,meta:metaType){
     //meta.loaded loaders数组中 函数的返回值组成的对象
     return <Button {...args} />
  },
  //打断渲染,用来请求初始化数据
  loaders: [
    async () => {
      await '假装 fetch'
      return {list: [111]}
    },
  ],
  //组件渲染完毕就会执行,常用来测试
  async play(meta:metaType){
      //断言函数,判断meta.args.backgroundColor==='green',结果会在控制台显示
      await expect(meta.args.backgroundColor).toEqual('green');
  },
};
export default meta;

type Story = StoryObj<typeof Button>;

//导出的变量会成为Button下的单个story,见上图
export const Primary: Story = {  
  args: {  
    primary: true,  
    label: 'Button',  
  },  
};  
  
export const Secondary: Story = {  
  args: {  
    label: 'Button',  
  },  
};  
  
export const Large: Story = {  
  args: {  
    size: 'large',  
    label: 'Button',  
  },  
};  
  
export const Small: Story = {  
  args: {  
    size: 'small',  
    label: 'Button',  
  },  
};
```
## Button组件

```javascript
// Button/index.tsx
import React from 'react';
import './index.css';

export interface ButtonProps {
  /** 你好,xxxxx */
  primary?: boolean;
  backgroundColor?: string;
  size?: 'small' | 'medium' | 'large';
  label?: string;
  onClick?: () => void;
}

/** Primary UI component for user interaction */
export const Button = ({
  primary = false,
  size = 'medium',
  backgroundColor,
  label,
  ...props
}: ButtonProps) => {
  return (<button
      style={{ backgroundColor }}
      {...props}
    >{label}</button>);
};
```

