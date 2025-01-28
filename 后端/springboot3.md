---
title: springboot3
description: springboot3笔记
date: 2025-01-28
tags:
  - 后端
---
# 起步依赖starter poms

- 官方提供的场景：命名为：spring-boot-starter-*

- 第三方提供场景：命名为：*-spring-boot-starter

作用:

```java
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.0.5</version>
</parent>
```