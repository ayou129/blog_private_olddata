---
title: 'npm 速度慢,卡 解决方案'
description: 解决 npm 命令 速度慢、卡，提高连接速度
keywords: 'npm,命令,加速,很卡,速度,很慢,代码,加快,提高,流畅,windows,linux'
author: guoxinlee
abbrlink: aaeff957
tags:
  - Linux
  - npm
  - Windows
categories:
  - 编程语言
date: 2019-01-27 19:07:00
---
出现问题的对症下药
## Windows 或 Linux
>三种方法都可以实现

* 通过config命令
```npm
npm config set registry http://registry.cnpmjs.org  npm info underscore
```
* 通过命令行指定
```npm
npm --registry http://registry.cnpmjs.org info underscore
```
* 编辑node_modules\npm.npmrc加入下面内容
```npm
registry = http://registry.cnpmjs.org
```
