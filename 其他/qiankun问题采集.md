## 使用 css 变量,部分样式丢失

```js
// 当使用css缩写,并且使用了css var,在该样式之后存在它的子属性,则会导致样式丢失
// 仅在使用 styleNode.textContent=styleNode.sheet.cssRules[0].cssText 时存在

// 例如:
html{
	--test:red;
}
.a{
	background: var(--test, blue);
	background-color: red;
}
//解析为:
.a{
	background-image: ;
	background-position-x: ;
	background-position-y: ;
	background-size: ;
	background-repeat: ;
	background-attachment: ;
	background-origin: ;
	background-clip: ;
	background-color: red;
}


<head>
	<style>  
			html{  
					--test: red  
			}  
	</style>  
</head>  
<body>  
<div class="ddd1">  
        22222  
</div>  
<script>  
	const textNode = document.createTextNode(`  
		.ddd1 {
			background: var(--test, blue); 
			background-color: red;
		}
	`);  
  const styleNode = document.createElement('style');  
  
  styleNode.appendChild(textNode);  
  document.body.append(styleNode);  
  
  const rule = styleNode.sheet.cssRules[0];  
  styleNode.textContent = rule.cssText;
</script>
```
乾坤源码部分:
![[Pasted image 20241114160854.png]]

## vue3子应用内,进行路由跳转时,偶先路径添加_aaa_undefinded后缀,且子应用被卸载,主应用菜单失效
 点住院医生站的header部分,偶先,一闪而过的undefined,且页面会闪烁,疑似修改了href
 
![[237d3a9a2abf28998ea3ec7bfca4387.jpg]]