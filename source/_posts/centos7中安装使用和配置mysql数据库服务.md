---
title: centos7中安装使用和配置mysql数据库服务
description: 在Centos7中安装使用和配置mysql数据库
keywords: 'mysql,Centos7,安装,配置,使用,database,table,mysqld,mariadb,linux,yum,源码,服务,网站,web,服务器,阿帕奇,install,mysqld.conf'
tags:
  - Centos7
  - Mysql
categories:
  - 编程语言
abbrlink: 3a49b8f2
date: 2019-02-03 22:15:59
---
出现问题的对症下药
## 安装mysql前预准备
首先检查系统中是否存在使用rpm安装的mysql或者mariadb，如果有需要先删除后再编译安装。
卸载完以后用 `rpm -qa|grep mariadb` 或者 `rpm -qa|grep mysql` 查看结果。
~~~
rpm -qa | grep mysql
rpm -qa | grep mariadb

#如果存在则卸载
rpm -e --nodeps XXXX
~~~
![rpm卸载mariadb](/rpm卸载mariadb.png)

## 安装(root权限)
### 安装相关依赖包
~~~
yum install -y libaio-*                        
mkdir -p /usr/local/mysql
~~~

### 安装mysql
~~~
cd /usr/local/src
wget http://zy-res.oss-cn-hangzhou.aliyuncs.com/mysql/mysql-5.7.17-linux-glibc2.5-x86_64.tar.gz
tar -xzvf mysql-5.7.17-linux-glibc2.5-x86_64.tar.gz
mv mysql-5.7.17-linux-glibc2.5-x86_64/* /usr/local/mysql/
~~~

### 建立mysql组和用户，并将mysql用户添加到mysql组
~~~
groupadd mysql
useradd -g mysql -s /sbin/nologin mysql
~~~

### 初始化mysql数据库
~~~
/usr/local/mysql/bin/mysqld --initialize-insecure --datadir=/usr/local/mysql/data/ --user=mysql
~~~

### 更改mysql安装目录的属主属组
~~~
chown -R mysql:mysql /usr/local/mysql
~~~

### 设置开机自启
~~~
cd /usr/local/mysql/support-files/

cp mysql.server  /etc/init.d/mysql
chmod +x /etc/init.d/mysql
chmod +x /etc/rc.d/rc.local                  
~~~
`vim /etc/rc.d/rc.local`
将`/etc/init.d/mysql start`到rc.local文件中，然后输入:wq保存退出

### 设置环境变量
~~~
vi /root/.bash_profile

PATH=$PATH:$HOME/bin:/usr/local/mysql/bin:/usr/local/mysql/lib

source /root/.bash_profile               
~~~
### 启动MySQL数据库
~~~
/etc/init.d/mysql start           
~~~
如果报下方错，则是之前没有完全卸载，[返回上方操作](#安装mysql前预准备)
![Mysql数据库 mysqld.saft error](/mysql_safe_error.png)

### 登录mysql（默认密码是空），修改密码
~~~
mysql -uroot -p

#登录后进行操作
set password for'root'@'localhost'=password('这是密码');
~~~
