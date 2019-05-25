---
title: centos7中apache/httpd服务器配置多个虚拟域名，实现一台服务器上运行多个网站，一ip多站点
description: Apache/httpd服务器配置(vhosts.conf)多个虚拟域名，实现一台服务器上运行多个网站，一个ip多个域名（虚拟主机）
keywords: 'Centos7,hosts,多站点,vhosts.conf,虚拟域名,多个网站,配置,apache,httpd,httpd.conf,web,服务器,阿帕奇,linux'
tags:
  - Centos7
  - Apache
categories:
  - 编程语言
abbrlink: b317dd55
date: 2019-02-01 15:15:48
---

出现问题的对症下药
## 服务器文件路径情况
> 默认在每个目录下创建了index.html做标识

1. 准备提供给 `www.root.com`准备的根目录:/data/www
2. 准备提供给 `www.test.com`准备的文件夹:`/data/www/www.test.com`
3. 准备提供给 `blog.test.com`准备的文件夹:`/data/www/blog.test.com`
4. 准备提供给 `www.other.com`准备的文件夹:`/data/www/www.other.com`
![文件路径情况](/file_path.jpg)

## 预计实现以下效果
### 同一台服务能够运行四个不同的网站(包括根目录)
* `http://www.root.com`或 `localhost`(访问根目录)
* `http://www.test.com`(访问 `www.test.com`目录)
* `http://blog.test.com`(是上面的子域名，访问 `blog.test.com`目录)
* `http://www.other.com`(另外一个域名，访问 `www.other.com`目录)

## 实现
### 开启vhost_alias模块
编辑`vim /etc/httpd/httpd.conf`(去掉#)
![开启vhost_alias模块](/vhost_alias.jpg)
 
### 打开并指定vhost_alias配置文件 (注意:配置文件默认安装目录是 `/etc/httpd/extra/`下)
编辑`vim /etc/httpd/httpd.conf`
![开启vhost_alias配置文件](/vhost_alias_include.jpg)
 
### 配置hosts.conf
> windows的hosts位于 `C:\Windows\System32\drivers\etc`
> linux的hosts位于 `/etc/hosts`

编辑`vim /etc/hosts`
```
127.0.0.1 www.root.com
127.0.0.1 www.test.com
127.0.0.1 blog.test.com
127.0.0.1 www.other.com
```
![开启hosts配置文件](/hosts.jpg)
### 配置vhosts.conf
编辑`vim /etc/httpd/vhosts.conf`
```
<VirtualHost *:80>
    DocumentRoot "/data/www"
    DirectoryIndex index.html index.php
    ServerName www.root.com
    ServerAlias root.com
    <Directory "/data/www">  
        AllowOverride All
        Order allow,deny
        Allow from all
        Require all granted
    </Directory>  
</VirtualHost>
<VirtualHost *:80>
    DocumentRoot "/data/www/www.other.com"
    DirectoryIndex index.html index.php
    ServerName www.other.com
    ServerAlias other.com
	<Directory "/data/www/www.other.com">  
        AllowOverride All
     	 Order allow,deny
     	 Allow from all
         Require all granted
	</Directory>  
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot "/data/www/www.test.com"
    DirectoryIndex index.html index.php
    ServerName www.test.com
    ServerAlias test.com
    <Directory "/data/www/www.test.com">  
        AllowOverride All
        Order allow,deny
        Allow from all
        Require all granted
    </Directory>  
</VirtualHost>
<VirtualHost *:80>
    DocumentRoot "/data/www/blog.test.com"
    ServerName blog.test.com
    DirectoryIndex index.html index.php
    <Directory "/data/www/blog.test.com">  
        AllowOverride All
     	Order allow,deny
     	Allow from all
        Require all granted
    </Directory>  
</VirtualHost>
```
### 重启apache/httpd服务
`/usr/local/apache/bin/apachectl restart`

### 浏览器预览
![Apache/httpd服务器配置(vhosts.conf)多个虚拟域名，实现一台服务器上运行多个网站](/vhosts_done.jpg)

## 其它
### 建议在部署阶段关闭根目录下的Indexes权限(Indexes的作用是当前根目录下如果不存在任何文件，则显示目录结构)
修改配置文件 `vim /etc/httpd/httpd.conf` 找到根目录权限配置处
~~~
<Directory "/data/www">
    Options Indexes FollowSymLinks #去掉Indexes
    AllowOverride None
    Require all granted
</Directory>
~~~
改为
~~~
<Directory "/data/www">
    Options FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
~~~


