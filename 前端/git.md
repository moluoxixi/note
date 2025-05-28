---
title: git
description: git
date: 2025-01-28
ptags:
  - 前端
tags:
  - 工具
---
## 子模块
| 命令名称                                              | 作用                             |
| ------------------------------------------------- | ------------------------------ |
| `git submodule add -b <子模块分支> <子模块仓库URL> <子模块目录>` | 新增子模块到指定目录                     |
| `git clone --recurse-submodules <repository-url>` | clone 项目, 并初始化并更新(clone)其中的子模块 |
| `git submodule init`                              | 初始化所有子模块                       |
| `git submodule update`                            | 更新所有子模块 (clone 下来)             |


## 配置相关操作与初始化

|                                                                               |          |
| ----------------------------------------------------------------------------- | -------- |
| 命令名称                                                                          | 作用       |
| git init                                                                      | 仓库初始化    |
| git config -l                                                                 | 查看所有配置信息 |
| git config 变量名                                                                | 查看指定配置信息 |
| git config --global user. name "你的用户名" git config --global user. email "你的邮箱" | 配置用户名和邮箱 |
| git config --global --edit                                                    | 修改配置信息   |
| git config --global --unset 变量名                                               | 删除指定配置信息 |

## 文件与文件夹相关操作与路径切换

|   |   |
|---|---|
|命令名称|作用|
|cd 绝对路径|切换到指定绝对路径 .. 切换到上一级目录文件夹名进入指定文件夹|
|ls|查看当前文件夹下的所有文件|
|touch 文件 1... 文件 n|创建文件|
|cat 文件|查看文件内容|
|mkdir 文件夹 1... 文件夹 n|创建文件夹|
|rm 文件夹 1 .. 文件夹 n -r|删除工作区文件夹如果要删除缓存区需要添加 ``--cache`` 如果需要同时删除暂存区和工作区, 需要添加 ``-f`` |
|rm 文件 1 .. 文件 n|删除工作区文件如果要删除缓存区需要添加 ``--cache`` 如果需要同时删除暂存区和工作区, 需要添加 ``-f`` |

## 代码查看提交回退相关

|   |   |
|---|---|
|命令名称|作用|
|git status|查看当前状态红色: 当前操作只存在于工作区绿色: 当前操作保存到了暂存区但没有保存到本地仓库白色: 当前操作保存到了本地仓库|
|git restore|回退至暂存区的状态|
|git add -u|被修改 (modified) 和被删除 (deleted) 文件，不包括新文件 (new) 同步到暂存区|
|git add .|新文件 (new) 和被修改 (modified) 文件，不包括被删除 (deleted) 文件同步到暂存区|
|git add -A|将所有变化同步到暂存区, git add -u 和 git add . 的结合|
|git restore -A|返回至暂存区的状态|
|git commit|进入 vim 模式添加注释并添加到仓库 (按 i 编辑按 esc 退出编辑输入: wq 退出 vim 模式)|
|git commit -m 注释|为本次操作添加注释并添加到仓库|
|git ls-files|查看所有本地仓库的文件|

## 代码推送拉取与别名

|                          |                                                                                                                       |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| 命令名称                     | 作用                                                                                                                    |
| git remote -v            | 查看当前所有远程地址别名                                                                                                          |
| git remote add 别名远程地址    | 起别名并建立与远程仓库的连接                                                                                                        |
| git remote rm 别名         | 删除别名并断开与远程仓库的连接                                                                                                       |
| git clone 远程地址           | 将远程仓库的内容克隆到本地 (**需要本地没有文件**)                                                                                          |
| git pull                 | 将远程仓库的更新同步到本地                                                                                                         |
| git pull 远程库地址别名远程分支名    | 将远程仓库对于分支的更新同步到本地                                                                                                     |
| git push -f              | 提交本地代码到远程仓库并覆盖 (**慎用, 一般只有回退版本时会使用**)                                                                                 |
| git push -u 别名分支         | 推送本地分支上的内容到远程仓库并添加关联 (-u 关联) 如果 git push 添加了关联, 后续推送关联分支文件可以简写成 ``git push`` 添加关联分支的子分支直接写成 ``git push origin 子分支名称`` |
| git push 别名 --delete 分支名 | 删除远程分支但不删除本地分支 (不能删除主分支)                                                                                              |
|                          |                                                                                                                       |

## 版本 (就是提交记录) 查看回退相关

|                           |                                                     |
| ------------------------- | --------------------------------------------------- |
| 命令名称                      | 作用                                                  |
| git log                   | 查看当前版本以及之前的版本 (提交日志) 如果加--oneline 则会以一行简化的方式查看        |
| git reflog                | 查看所有提交的历史记录 (不只是当前分支的历史记录)。如果加--oneline 则会以一行简化的方式查看 |
| git reset --hard 版本号      | 回退到指定版本号的版本, 版本号可以只写前七位                              |
| git reset --hard HEAD^    | 回退到上一个版本, 每多一个^就多退一个版本                               |
| git reset --hard HEAD~n   | 回退到前 n 个**版本**                                        |
| git reset --hard HEAD@{n} | 回退到前 n 个**历史记录**                                      |
| git reset --hard 版本号文件名  | 将指定文件回退到指定版本号 (需要先进入该文件目录)                           |

## 分支相关操作

|   |   |
|---|---|
|命令名称|作用|
|git branch|查看所有分支|
|git checkout 分支名|切换到指定分支|
|git checkout -b 分支名|创建新分支并切换到该分支|
|git merge 分支名 1 ... 分支名 n|合并分支|
|git branch -d 分支名 1 ... 分支名 n|删除分支|
|git checkout -b 本地分支名 origin/远程分支名|基于远程分支创建本地分支|


## Git 标签 (tag) 操作指南

### 什么是 Git 标签
Git 标签是对仓库中特定提交的引用，通常用于标记发布版本 (如 v1.0.0)。

### 基本操作

#### 创建标签 
```
# 创建轻量标签
git tag v1.0.0

# 创建附注标签(推荐用于发布版本)
git tag -a v1.0.0 -m "发布1.0.0版本"

# 给历史提交打标签
git tag -a v0.9.0 9fceb02 -m "给过去的提交打标签"
```

#### 查看标签
```
# 列出所有标签
git tag

# 查看标签信息
git show v1.0.0

# 按模式查找标签
git tag -l "v1.0.*"
```

#### 推送标签到远程
```
# 推送特定标签
git push origin v1.0.0

# 推送所有标签
git push origin --tags
```

#### 删除标签
```
# 删除本地标签
git tag -d v1.0.0

# 删除远程标签
git push origin --delete v1.0.0
# 或
git push origin :refs/tags/v1.0.0
```

#### 检出标签
```
# 查看标签内容
git checkout v1.0.0

# 基于标签创建分支
git checkout -b branch_name v1.0.0
```

#### 标签类型
- **轻量标签**：指向特定提交的引用，没有额外信息
- **附注标签**：存储完整对象，包含标签创建者、日期和注释信息，推荐用于发布

轻量标签适合临时标记，附注标签适合版本发布和重要里程碑。

## 清屏和设置 git 默认编辑器

|   |   |
|---|---|
|命令名称|作用|
|ctrl+l 或 clear|清屏|
|git config --global core. editor vim|将 git 的默认编辑器设置为 vim|

## git有什么特点

1. 主动提交
2. 分布式版本管理系统+中央仓库

分布式仓库工作模型:

1. 首先，你作为主工程师，独立搭建了项目架构，****并把这些代码提交到了本地仓库****；
2. 然后，你在服务器上创建了一个中央仓库，并把 1 中的提交****从本地仓库推送到了服务器的中央仓库****；
3. 其他同事**把中央仓库的所有内容克隆到本地，拥有了各自的本地仓库**，从此刻开始，你们三人开始并行开发；
4. 在之后的开发过程中，你们三人总是每人独立负责开发一个功能，在这个功能开发过程中，**一个人会把它的每一步改动提交到本地仓库**。注意：由于本地提交无需立即上传到中央仓库，所以每一步提交不必是一个完整功能，而可以是功能中的一个步骤或块。
5. 在一个人把某个功能开发完成之后，他就可以把这个功能相关的所有提交**从本地仓库推送到中央仓库**；
6. 每次当有人把新的提交推送到中央仓库的时候，另外两个人就可以选择**把这些提交同步到自己的机器上，并把它们和自己的本地代码合并**。

![分布式 VCS](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/30/1600a9a4a20c2e6e~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)![分布式 VCS](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/30/1600a9a4a20c2e6e~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)

## DVCS的本地仓库、与VCS本地的区别

DVCS 分布式版本控制系统 VCS 版本控制系统

DVCS本地仓库是带版本管理功能的，像可以离线做一些提交，回滚、查看历史、分支等操作，

而VCS的本地备份如脱离服务器则做不上面的这些操作

# 一套git操作合集

## 版本管理原理

git有一个特殊的引用HEAD,该引用默认情况下是指向主分支master的(也有可能是main)

当我们checkout -b 分支时,会将HEAD引用指向新分支

当我们commit时,HEAD会带上它的当前引用,共同指向新的commit

reset --hard实际上是修改HEAD引用

当一个提交记录不在有人引用时,这个记录将被删除,即不存在分支引用它,也不存在HEAD引用它

![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/22/15fe3354a2a32692~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/22/15fe3354a2a32692~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)

## git push 原理

git push 的本质就是将HEAD所引用的分支节点与最新引用同步到远程分支,

下图实例仅会将master分支的节点和最新引用更新,

注意,**push不会改变远程HEAD引用,远程HEAD永远指向主分支(一般是master)**

![把 master push 到远程仓库](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/29/1600725e9973f71d~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)![把 master push 到远程仓库](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/29/1600725e9973f71d~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)

## merge,pull,rebase原理

当我们将一个不属于当前分支的代码合并过来时,通常有三种操作:

1. git pull origin 远程分支
2. git merge 其他分支
3. git rebase master

### pull和merge原理

将另一个分支的代码连接到当前分支节点,并创建新节点存储该内容

**简单理解就是将其他分支代码合并到当前分支,并创建新节点存储**

![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/21/15fddc2a9d759d8e~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/21/15fddc2a9d759d8e~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)

### rebase原理

将基点挪到另外一个分支的最后一个节点,并将当前分支的所有节点挪到另外一个节点,并在最后一个节点合并代码

rebase就是变基,下图中,将 branch1的 基点从节点2挪到了4

导致5,6节点挪到了master分支的7,8,并将节点4的代码合并到了8

**简单理解就是将当前分支的所有记录合并到另外一个分支,并合并代码**

如果要使用git rebase i需要配置

![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/30/1600abd620a8e28c~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2017/11/30/1600abd620a8e28c~tplv-t2oaga2asx-jj-mark:2041:0:0:0:q75.awebp)


# 其他

## 配置忽略文件

### 仓库中没有提交该文件

创建一个文件【.gitignore】配置忽略，一般与.git目录同级，**不要鼠标右键直接创建，要通过编辑器的方式创建**

常见情况有：

1. 临时文件
2. 多媒体文件、如音频、视频
3. 编辑器生成的配置文件（.idea）
4. npm安装的第三方模块

### 仓库中已经提交该文件

办法1：【非常委婉型】

1. 对于已经加入到暂存区中的文件，可以在暂存区中删除该文件
2. ​然后再.gitignore中配置忽略
3. add和commit提交即可

办法2：【简单粗暴型】

​ 还可以直接将.git目录删掉，然后重新add和commit也可以，但是这样做风险太大，容易找不到之前的版本。

## 免密登录

1. 创建非对称加密对
```
//使用git终端在任意路径输入命令即可
ssh-keygen -t rsa -C '邮箱'
```

2. 文件默认存储在家目录（c:/用户/用户名/.ssh）的 .ssh 文件夹中。

- id_rsa 私钥
- id_rsa.pub 公钥

3. 将公钥（.pub）文件内容配置到账号的秘钥中

- 首页 -> 右上角头像-> settings -> SSH and GPG keys -> new SSH Key

4. 克隆代码时，选择 ssh 模式进行克隆 （地址在仓库首页绿色克隆的位置选择 use ssh）
```
git clone git@github.com/xiaohigh/team-repo-1.git
```

5. ``ssh-keygen`` 命令常用参数：

- ``-t``：指定生成密钥的类型，默认使用RSA类型密钥。
- ``-f``：指定生成密钥的文件名，默认``id_rsa``（私钥，公钥``id_rsa.pub``）
- ``-P``：提供旧密码，空表示不需要密码（``-P ' '``）。
- ``-N``：提供新密码，空表示不需要密码(``-N ' '``)。
- ``-C``：提供一个新注释，比如邮箱。