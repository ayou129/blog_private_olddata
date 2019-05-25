---
title: centos7中apache/httpd服务器更改网站根目录
description: Apache/httpd服务器更改网站根目录
keywords: 'centos7,网站根目录,配置,apache,httpd,linux,服务,网站,web,服务器,阿帕奇,更改,httpd.conf'
tags:
  - Centos7
  - Apache
categories:
  - 编程语言
abbrlink: e12cdf26
date: 2019-01-30 20:31:23
---
出现问题的对症下药
## 更改网站根目录(假设需要将目录更换为 `/data/www`)
1. 提前创建目录 `/data/www`
~~~
mkdir -p /data/www

echo "this is test content" > /data/www/index.html
~~~
2. 修改配置文件 `vim /etc/httpd/httpd.conf`
```
#更改DocumentRoot
DocumentRoot "/data/www"
#设置目录权限(下方code为新增)
<Directory "/data/www">
    Options FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
```
2. 重启服务
~~~
/usr/local/apache/bin/apachectl restart
~~~
![Apache/httpd服务器更改网站根目录成功](/changed_done.jpg)
