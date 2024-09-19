# tailwind

将样式粒子化,变成一个个类名,并在打包后只会保留使用的类名,其余会被摇掉

`npm install -D tailwindcss postcss autoprefixer`

`npx tailwindcss init -p`

## 基础示例

首先要在主文件的.css文件中声明:

```css
//App.css
@tailwind base;       //基础样式
@tailwind components; //组件样式
@tailwind utilities;  //实用程序样式
```

use

```css
.aaa {
    background: red;
    font-size: 14px;
}
.aaa:hover {
    font-size: 30px;
}
@media(min-width:768px) {
    .aaa {
        background: blue;
    }
}

//等同于
<div class="text-[14px] bg-red-500 hover:text-[30px] md:bg-blue-500"></div>
```

## @layer扩展&@apply复用

use

```css
//App.css
@tailwind base;       //基础样式
@tailwind components; //组件样式
@tailwind utilities;  //实用程序样式

//扩展components样式
@layer components{
    .hover-and-other{
        //@apply用于允许你应用Tailwind CSS中现有的样式值
        @apply hover:bg-blue-700 focus:outline-none first:pt-0 last:pb-0;
    }
    .font-style{
	    @apply py-2 px-4 font-semibold rounded-lg shadow-md;
    }
}
```

## 自定义插件扩展样式

主要用于多项目复用

```javascript
//.guang.plugin
const plugin = require('tailwindcss/plugin');

module.exports = plugin(function({ addUtilities }) {
    addUtilities({
        '.guang': {
            background: 'blue',
            color: 'yellow'
        },
        '.guangguang': {
            'font-size': '70px'
        }
    })
})
```

## 修改默认主题

```javascript
//tailwind.config.js

/*@type {import('tailwindcss').Config}**/
module.exports ={
    //指定需要应用tailwind css类名的文件所在路径
    content:["./src/*/*.{js,jsx,vue}","./components/**/*.{html,js}"],
    //引入上面的自定义插件
    plugins:[require('./guang.plugin')],
    theme:{
	    screens:{sm: '480px',},
	    colors:{'blue': '#1fb6ff',gray: { 100: '#f7fafc'}},
	    fontFamily:{sans: ['Graphik', 'sans-serif'],},
	    fontSizes: {'xs': '.75rem',},
	    spacing:{0: '0',},
	    borderColor: (theme) => ({  
	      ...theme('colors') // 你可以在这里添加额外的边框颜色  
	    }),
	    ... //其他主题配置
		// 扩展设置
        extend:{
            padding:{
                '1':'30px'   
            },
            fontSize:{
                'base':['30px','2rem']
            }
            screens:{
                'md':'300px    
            }        
        }
    }
}
```

## 添加prefix避免和自定义class重名

```javascript
//tailwind.config.js

/*@type {import('tailwindcss').Config}**/
module.exports =
{
    ...,
    //添加 prefix,但是所有的原子 class 都会加上 prefix
    prefix:'qianzui',
}
```
## 动态主题切换

```js
//tailwind默认支持暗黑主题切换
	//1.在html/body上写一个属性用于控制主题
		<body data-theme="dark" />
		
	//2.定义tailwind.config.ts
		module.exports = {
			//当某个元素上具有data-mode="dark"属性时,该元素及其子孙元素会应用暗黑主题
			darkMode: ['selector', '[data-mode="dark"]'],
			...
		} 
		
	// 3.定义主题切换函数,用于切换主题
		export const changeTheme = (theme: string) => {
			document.body.setAttribute('data-mode', theme);
		};

// 通过自定义变量手动实现
	// 1.在html/body上写一个属性用于控制主题
		<body data-theme="dark" />
		
	// 2.定义各主题下自定义变量的值
		//../theme1.css
		html[data-theme="theme1"] {
			--color-primary: #f98866;
			--color-secondary: #80bd9e;
			--color-buttons: #89da59;
			--color-typography: #ff320e;
		}
		
		
		// ../theme2.css
		html[data-theme="theme2"] {
			--color-primary: #f4cc70;
			--color-secondary: #6ab187;
			--color-buttons: #de7a22;
			--color-typography: #20948b;
		}
	
	// 3.在主样式文件中引入主题文件与tailwind
		// ../style/main.css
		@tailwind base;
		@tailwind components;
		@tailwind utilities;
		
		@layer base {
			html { //默认主题
				--color-primary: #4285f4;
				--color-secondary: #34a853;
				--color-buttons: #fbbc05;
				--color-typography: #ea4335;
			}
			@import "themes/theme1.css";
			@import "themes/theme2.css";
		}
	
	// 4.设置tailwind,以使用这些css变量
			// tailwind.config.ts
			module.exports = {
			    content: [
			      './src/view/**/*.{js,ts,jsx,tsx,vue}',
			    ],
			    theme: {
			      extend: {
			        colors: {
			          primary: 'var(--color-primary)',
			          secondary: 'var(--color-secondary)',
			          buttons: 'var(--color-buttons)',
			          typography: 'var(--color-typography)',
			        },
			      },
			    },
			    plugins: [],
		  };
	
	// 5.定义主题切换函数,用于切换主题
		// ../theme/main.ts
		export const changeTheme = (theme: string) => {
		  document.body?.setAttribute("data-theme", theme);
		};

```
# css Modules

基于postcss


1. Module.Css (module 是一种约定, 表示需要开启 css 模块化).
2. 他会将你的所有类名进行一定规则的替换 (将 footer 替换成 `_footer_i 22 st_1`)
3. 同时创建一个映像对象{ footer: “`_footer_i 22 st_1`” }
4. 将替换过后的内容塞进 style 标签里然后放入到 head 标签中.
5. 将 componentA. Moudle. Css 内容进行全部抹除，替换成 JS 脚本.
6. 将创建的映射对象在脚本中进行默认导出.


css Modues会将.module.css文件编译成这个样子

![](images/WEBRESOURCE2e01d5001b00b663c689e9ca71f89b9cimage.png)

显而易见,它这样用:

```javascript
import styles from './Button1.module.css';
export default function() {
    return <div className={styles['btn-wrapper']}>
        <button className={styles.btn}>button1</button>
    </div>
}
```
# sass
```js
//&代表父选择器
	.a{
		&.b{}
	}
	//编译为
	.a.b{}

//@mixin&@include
	@mixin button-style($padding, $background, $border: 1px solid #ccc) {  
	  padding: $padding;  
	  background-color: $background;  
	  border: $border;  
	} 
	.button-primary {  
	  @include button-style(10px, blue, 2px solid black);  
	}  

//占位符%与继承@extend
	//sass使用%定义占位符,占位符定义的css不会输出到css文件中,并可以使用@extend继承
		%button-style{  
			display: inline-block; 
		}
	
	//sass使用@extend继承某些样式,或占位符样式
	
		//继承占位符样式
			.button-primary {  
				@extend %button-style;
				background-color: red; 
			}
			//编译为
			.button-primary {  
				display: inline-block; 
				background-color: red; 
			}
	
		//继承css样式
			.button{
				color:red;
				&-color{
					@extend .button;
					width:100%
				}
			}
			//编译为
			.button,.button-color{
				color:red;
			}
			.button-color{
				width:100%
			}

//$变量名 定义变量,#{变量名} 插值,@each,@if,@else循环与条件判断
	//sass使用$符定义变量
		 $button:"button";
		 $red:red;
		 $list:(
			 button:'button',
			 primary:blue,
			 debug:$red,
		 );
	//@each遍历list,#{变量名使用变量}
		@each $name,$value in $list{
			.#{$name}:{
				@if($name != button){
					color:#{$value};
				}
				@else{
					color:gray;
				}
			}
		}
		//编译为
		.primary{
			color:blue;
		}
		.debug{
			color:red;
		}
		.button:{
			color:gray;
		}

//属性嵌套
	.funky {
	  font: 20px/24px {
	    family: fantasy;
	    weight: bold;
	  }
	  background{
		  color:black;
	  }
	}
	//编译为
	.funky {
		font: 20px/24px;
		font-family: fantasy;
		font-weight: bold;
		background-color:black;
	}
```

# less

```js

```