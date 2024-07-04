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

在项目根目录下随便建一个ts文件,新建一个

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