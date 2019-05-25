---
title: 'git 速度慢,卡 解决方案'
description: 解决 git clone 速度慢、卡，提高连接速度
keywords: 'git,clone,加速,很卡,速度,很慢,代码,加快,提高,流畅,windows,linux'
category:
  - 编程语言
tags:
  - Git
  - Linux
  - Windows
abbrlink: 16d59ca0
date: 2019-01-27 15:48:42
---
出现问题的对症下药

## Windows
1. 修改本机hosts文件，添加下方两行code，并重启网络服务
```Hosts
151.101.72.249 github.global.ssl.fastly.net
192.30.253.112 github.com
```
  >tip:win10中文件路径为C:\Windows\System32\drivers\etc\hosts
　
2. cmd(命令行)中执行下方code
```
ipconfig /flushdns
```
## Linux
1. 修改本机hosts文件，添加下方两行code，并重启网络服务
```Hosts
151.101.72.249 github.global.ssl.fastly.net
192.30.253.112 github.com
```
  >tip:Linux中文件路径为/etc/hosts
　
2. cmd(命令行)中执行下方code
```
sudo /etc/init.d/networking restart
```

