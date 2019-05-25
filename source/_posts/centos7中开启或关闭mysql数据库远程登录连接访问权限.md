---
title: centos7中开启或关闭mysql数据库远程登录连接访问权限
description: 实现centos7中开启/删除,mysql数据库远程登录连接访问权限
keywords: 'mysql,Centos7,远程,登录,关闭,删除,连接访问权限,安装,开启,数据库,database,table,mysqld,mariadb,linux,yum,源码,服务,网站,web,服务器,阿帕奇,install,mysqld.conf'
tags:
  - Centos7
  - Mysql
categories:
  - 编程语言
abbrlink: b80c9de7
date: 2019-02-03 22:31:00
---
出现问题的对症下药
## 添加权限
### 连接数据库
~~~
mysql -uroot -p密码
~~~

### 切换到 mysql DB
~~~
use mysql; 
~~~

### 添加
#### 只允许固定ip才能访问
~~~
GRANT ALL PRIVILEGES ON *.* TO'myuser'@'准备赋予权限的ip'IDENTIFIED BY'这是密码' WITH GRANT OPTION;
~~~
#### 允许所有用户拥有访问此数据库的权限(不安全,不建议)
~~~
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%'IDENTIFIED BY '这是密码' WITH GRANT OPTION;
~~~
### 推入内存或重启mysql使其生效
~~~
FLUSH PRIVILEGES;
~~~
或
~~~
/etc/init.d/mysqld start
~~~
## 删除权限
### 连接数据库
~~~
mysql -uroot -p密码
~~~

### 切换到 mysql DB
~~~
use mysql; 
~~~

### 更改mysql安装目录的属主属组
~~~
delete from user where host = '这是被删除权限用户的ip';
~~~
### 推入内存或重启mysql使其生效
~~~
FLUSH PRIVILEGES;
~~~
或
~~~
/etc/init.d/mysqld start
~~~