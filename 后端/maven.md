# **maven**

依赖管理工具,可以搭建私服

## 目录结构

```
bin：含有Maven的运行脚本
boot：含有plexus-classworlds类加载器框架
conf：含有Maven的核心配置文件
lib：含有Maven运行时所需要的Java类库
LICENSE、NOTICE、README.txt：针对Maven版本，第三方软件等简要介绍
```

## 配置

在config/settings.xml中配置

### 环境变量&本地maven仓库配置

```javascript
//环境变量配置
需要在path中添加环境变量,路径为maven安装目录的的bin目录

//本地maven仓库配置
//注意,idea中是有默认maven的,需要替换为本地的
<localRepository>D:\maven-repository</localRepository>
```

### 中央仓库配置

```javascript
//中央仓库镜像配置
//mirror的作用主要是重定向 Maven 仓库的请求
<mirror>
    <id>alimaven</id>         //定义镜像的唯一标识符
    <name>aliyun maven</name> //定义镜像的名称
    //定义镜像的地址
    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    //定义了哪些仓库的请求应该被这个镜像所替代
    //central代表中央仓库
    <mirrorOf>central</mirrorOf>
</mirror>
```

### 配置jdk17版本项目构建

```javascript
//profile 的主要作用是定义一系列的配置信息
<profile>
    <id>jdk-17</id>
    //定义何时激活这个 profile
    <activation>
      //指定为默认激活状态        
      <activeByDefault>true</activeByDefault>
      //当jdk为17的时候
      <jdk>17</jdk>
    </activation>
    //定义构建过程中使用的属性
    <properties>
      //定义了 Java 源代码的编译版本为 17
      <maven.compiler.source>17</maven.compiler.source>
      //编译后的字节码的目标版本为 17
      <maven.compiler.target>17</maven.compiler.target>
      //定义用于编译的 Maven 编译插件的版本为 17
      <maven.compiler.compilerVersion>17</maven.compiler.compilerVersion>
    </properties>
</profile>
```

## maven配置

pom.xml

```javascript
<!-- 模型版本 -->
<modelVersion>4.0.0</modelVersion>
<!-- 公司或者组织的唯一标志，并且配置时生成的路径也是由此生成，
 如com.companyname.project-group，
 maven会将该项目打成的jar包放本地路径：/com/companyname/project-group -->
<groupId>com.companyname.project-group</groupId>
<!-- 项目的唯一ID，一个groupId下面可能多个项目，就是靠artifactId来区分的 -->
<artifactId>project</artifactId>
<!-- 版本号 -->
<version>1.0.0</version>

<!-- 指定打包名称,默认的打包名称：artifactid+verson.打包方式 -->
<build>
​  <plugins><plugin>插件配置...</plugin></plugins>
  <finalName>定义打包名称</finalName>
</build>

<dependencies>
    <!-- 引入具体的依赖包 -->
    <dependency>
        <groupId>log4j</groupId>
        <artifactId>log4j</artifactId>
        <version>1.2.17</version>
        <!-- 依赖范围 -->
        <scope>runtime</scope>
    </dependency>

</dependencies>
<!--打包方式
    默认：jar
    jar指的是普通的java项目打包方式！ 项目打成jar包！
    war指的是web项目打包方式！项目打成war包！
    pom不会讲项目打包！这个项目作为父工程，被其他工程聚合或者继承！后面会讲解两个概念
-->
<packaging>jar/pom/war</packaging>
```

| 依赖范围     | 描述                                                                                                                                |
| -------- | --------------------------------------------------------------------------------------------------------------------------------- |
| compile  | 编译依赖范围，scope 元素的缺省值。使用此依赖范围的 Maven 依赖，对于三种 classpath 均有效，即该 Maven 依赖在上述三种 classpath 均会被引入。例如，log4j 在编译、测试、运行过程都是必须的。              |
| test     | 测试依赖范围。使用此依赖范围的 Maven 依赖，只对测试 classpath 有效。例如，Junit 依赖只有在测试阶段才需要。                                                                 |
| provided | 已提供依赖范围。使用此依赖范围的 Maven 依赖，只对编译 classpath 和测试 classpath 有效。例如，servlet-api 依赖对于编译、测试阶段而言是需要的，但是运行阶段，由于外部容器已经提供，故不需要 Maven 重复引入该依赖。  |
| runtime  | 运行时依赖范围。使用此依赖范围的 Maven 依赖，只对测试 classpath、运行 classpath 有效。例如，JDBC 驱动实现依赖，其在编译时只需 JDK 提供的 JDBC 接口即可，只有测试、运行阶段才需要实现了 JDBC 接口的驱动。     |
| system   | 系统依赖范围，其效果与 provided 的依赖范围一致。其用于添加非 Maven 仓库的本地依赖，通过依赖元素 dependency 中的 systemPath 元素指定本地依赖的路径。鉴于使用其会导致项目的可移植性降低，一般不推荐使用。          |
| import   | 导入依赖范围，该依赖范围只能与 dependencyManagement 元素配合使用，其功能是将目标 pom.xml 文件中 dependencyManagement 的配置导入合并到当前 pom.xml 的 dependencyManagement 中。 |


## Maven工程的GAVP

gav需要我们在创建项目的时候指定，p有默认值，我们先行了解下这组属性的含义：

Maven 中的 GAVP 是指 GroupId、ArtifactId、Version、Packaging 等四个属性的缩写，其中前三个是必要的，而 Packaging 属性为可选项。这四个属性主要为每个项目在maven仓库中做一个标识，方便后期项目之间相互引用依赖等！

GAV遵循一下规则：

	1） 

		说明：{公司/BU} 例如：alibaba/taobao/tmall/aliexpress 等 BU 一级；子业务线可选。

		正例：com.taobao.tddl 或 com.alibaba.sourcing.multilang

	2） 

		正例：tc-client / uic-api / tair-tool / bookstore

	3） 

		1） 主版本号：当做了不兼容的 API 修改，或者增加了能改变产品方向的新功能。

		2） 次版本号：当做了向下兼容的功能性新增（新增类、接口等）。

		3） 修订号：修复 bug，没有修改方法签名的功能加强，保持 API 兼容性。

		例如： 初始→1.0.0  修改bug → 1.0.1  功能调整 → 1.1.1等

**Packaging定义规则：**

	指示将项目打包为什么类型的文件，idea根据packaging值，识别maven项目类型！

	packaging 属性为 jar（默认值），代表普通的Java工程，打包以后是.jar结尾的文件。

	packaging 属性为 war，代表Java的web工程，打包以后.war结尾的文件。

	packaging 属性为 pom，代表不会打包，用来做继承的父工程。

## 打包命令

| 命令          | 描述                        |
| ----------- | ------------------------- |
| mvn compile | 编译项目，生成编译后的文件保存在target目录下 |
| mvn package | 打包项目，生成jar或war文件,保存在      |
| mvn clean   | 清理target目录(编译或打包后的项目结构)   |
| mvn install | 打包后上传到maven本地仓库           |
| mvn deploy  | 只打包，上传到maven私服仓库          |
| mvn site    | 生成站点                      |
| mvn test    | 执行测试源码                    |


## idea配置与创建maven项目

```javascript
//配置本地maven
//idea可以配置本地maven,在设置中的maven配置中,设置目录为setting.xml的路径,
//例如: D:\maven\conf\settings.xml

```

## maven项目目录

```java
|-- pom.xml                               # Maven项目管理文件,描述项目依赖和构建配置等信息
|-- src
    |-- main                              # 项目主要代码
    |   |-- java                          # Java 源代码目录
    |   |   `-- com/example/myapp         # 开发者代码主目录
    |   |       |-- controller            # 存放 Controller 层代码的目录
    |   |       |-- service               # 存放 Service 层代码的目录
    |   |       |-- dao                   # 存放 DAO 层代码的目录
    |   |       `-- model                 # 存放数据模型的目录
    |   |-- resources                     # 资源目录，存放配置文件、静态资源等
    |   |   |-- log4j.properties          # 日志配置文件
    |   |   |-- spring-mybatis.xml        # Spring Mybatis 配置文件
    |   |   `-- static                    # 存放静态资源的目录
    |   |       |-- css                   # 存放 CSS 文件的目录
    |   |       |-- js                    # 存放 JavaScript 文件的目录
    |   |       `-- images                # 存放图片资源的目录
    |   `-- webapp                        # 存放 WEB 相关配置和资源
    |       |-- WEB-INF                   # 存放 WEB 应用配置文件
    |       |   |-- web.xml               # Web 应用的部署描述文件
    |       |   `-- classes               # 存放编译后的 class 文件
    |       `-- index.html                # Web 应用入口页面
    `-- test                              # 项目测试代码
        |-- java                          # 单元测试目录
        `-- resources                     # 测试资源目录
```

## **依赖传递终止**

- 非compile范围进行依赖传递

- 使用optional配置终止传递<optional>true</optional>

- 依赖冲突（传递的依赖已经存在,怎么解决百度得了）

## maven私服

### 下载nexus

下载

[https://help.sonatype.com/repomanager3/product-information/download](https://help.sonatype.com/repomanager3/product-information/download)

解压，以管理员身份打开CMD，进入bin目录下，执行./nexus /run命令启动

访问 Nexus 首页

首页地址：[http://localhost:8081/](http://localhost:8081/)，8081为默认端口号

### 修改默认密码

登录后,修改默认密码

- 用户名：admin

- 密码：查看 

`E:\Server\nexus-3.61.0-02-win64\sonatype-work\nexus3\admin.password`

### 仓库字段讲解

![](images/WEBRESOURCE06f3cca8e0ef585d97baba68940d5937img009.7f737ed7.png)

| 仓库类型   | 说明                            |
| ------ | ----------------------------- |
| proxy  | 某个远程仓库的代理                     |
| group  | 存放：通过 Nexus 获取的第三方 jar 包      |
| hosted | 存放：本团队其他开发人员部署到 Nexus 的 jar 包 |


| 仓库名称            | 说明                                              |
| --------------- | ----------------------------------------------- |
| maven-central   | Nexus 对 Maven 中央仓库的代理                           |
| maven-public    | Nexus 默认创建，供开发人员下载使用的组仓库                        |
| maven-releases  | Nexus 默认创建，供开发人员部署自己 jar 包的宿主仓库 要求 releases 版本  |
| maven-snapshots | Nexus 默认创建，供开发人员部署自己 jar 包的宿主仓库 要求 snapshots 版本 |


### 修改本地依赖仓库为nexus

修改本地maven的核心配置文件settings.xml，设置新的本地仓库地址

```java
<!-- 配置一个新的 Maven 本地仓库 -->
<localRepository>D:/maven-repository-new</localRepository>
```

把我们原来配置阿里云仓库地址的 mirror 标签改成下面这样：

```java
<mirror>
    <id>nexus-mine</id>
    <mirrorOf>central</mirrorOf>
    <name>Nexus mine</name>
    //设置为nexus的仓库地址,在mvn clean compile,第一次会自动将依赖下载到nexus中,然后再分发到本地项目        
    <url>
</mirror>
```

### 修改默认的中央仓库地址,加快下载速度

设置中,选择repository/repositories(仓库) 然后选择中央仓库(maven-central)

将地址改为[http://maven.aliyun.com/nexus/content/groups/public/](http://maven.aliyun.com/nexus/content/groups/public/)

### 将本地jar包部署到nexus仓库

maven工程中配置：

```java
<distributionManagement>
    <snapshotRepository>
        <id>nexus-mine</id>
        <name>Nexus Snapshot</name>
        <url>
    </snapshotRepository>
</distributionManagement>
```

注意：这里 snapshotRepository 的 id 标签必须和 settings.xml 中指定的 mirror 标签的 id 属性一致。

执行部署命令：

```java
mvn deploy
```

### 引用别人部署的 jar 包

maven工程中配置：

```java
<repositories>
    <repository>
        <id>nexus-mine</id>
        <name>nexus-mine</name>
        <url>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
        <releases>
            <enabled>true</enabled>
        </releases>
    </repository>
</repositories>
```

### 是什么

一种特殊的Maven远程仓库，用来代理位于外部的远程仓库（中央仓库、其他远程公共仓库）

一般根据私密性,决定部署在局域网还是公网上

maven会将依赖缓存在仓库中,避免重复下载,同时可以放公司的独特依赖,基于这个特性,maven有以下优势:

1. 节省外网带宽,避免重复下载,降低带宽压力

2. 下载速度更快,位于私服,下载超快

3. 可部署第三方构件,例如公司的依赖,npm等

![](images/WEBRESOURCE316e546d2995cd278685cd8d2e88b54bimage-20231021164631791.png)

