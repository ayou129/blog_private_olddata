---
title: centos7中安装和配置apache/httpd服务
description: 在Centos7中安装和配置apache(httpd)服务
keywords: 'Centos7,安装,配置,apache,httpd,linux,服务,网站,web,服务器,阿帕奇,install,httpd.conf'
tags:
  - Centos7
  - Apache
categories:
  - 编程语言
abbrlink: bde0f072
date: 2019-01-29 20:31:23
---
出现问题的对症下药
## 相关依赖包(root权限)
1. 安装vim及unzip/apr、apr-util和pcre软件包和相关依赖包：
~~~
yum install -y wget vim unzip expat-devel gcc gcc-c++ autoconf libtool 
~~~

2. 安装apr
~~~
cd /usr/local/src/
wget http://apache.mirror.gtcomm.net/apr/apr-1.6.5.tar.gz
tar zxvf apr-1.6.5.tar.gz
cd apr-1.6.5

./buildconf
./configure --prefix=/usr/local/apr
make && make install
~~~

3. 安装apr-util
~~~
cd /usr/local/src/
wget http://apache.mirror.rafal.ca/apr/apr-util-1.6.1.tar.gz
tar zxvf apr-util-1.6.1.tar.gz
cd apr-util-1.6.1

./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr
make && make install
~~~

4. 安装pcre
~~~
cd /usr/local/src/
wget https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz
tar zxvf pcre-8.41.tar.gz
cd pcre-8.41

./configure --prefix=/usr/local/pcre
make && make install
~~~
如果某wget提示不存在(404)，你可以到网址上级目录寻找已更新的版本进行下载
例如`wget https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz`
提示`已发出 HTTP 请求，正在等待回应... 404 Not Found`
![yum install 404 Not Found](/404-not-found.jpg)
则需要打开`https://ftp.pcre.org/pub/pcre`
1. 进行查找最新版本
2. 更改链接下载
3. 更改相同的文件名

再进行安装


## Apache(root权限)
1. 安装
```	
cd /usr/local/src/
wget http://www-us.apache.org/dist/httpd/httpd-2.4.38.tar.gz 
tar zxvf httpd-2.4.38.tar.gz
cd httpd-2.4.38

./configure \
--prefix=/usr/local/apache \
--sysconfdir=/etc/httpd  \
--with-apr=/usr/local/apr \
--with-apr-util=/usr/local/apr-util/bin/apu-1-config \
--with-pcre=/usr/local/pcre \
--enable--ssl \
--enable-so \
--enable-rewrite
make && make install
```
2. 配置Apache
```
vim /etc/httpd/httpd.conf
```
 + 文件末尾增加下方code
 //添加前不要开启服务，注意，如果开启服务会报错`make_sock: could not bind to address`
```
#指定守护进程的进程号
PidFile  "/var/run/httpd.pid"

#后缀名是.php的文件交由x-httpd-php处理
AddHandler application/x-httpd-php .php
```
 + 编辑相关配置
```
ServerName localhost:80
ServerAdmin guoxinlee129@gmail.com
```
3. 启动httpd服务
~~~
/usr/local/apache/bin/apachectl start
~~~
 可能会遇到问题：Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:80
![Address already in use: AH00072: make_sock](/pidfile_error.jpg)
原因：指定守护进程的进程号 前 开启了服务，则造成冲突
 <b>方案1</b>:
 1. 添加 `PidFile  "/var/run/httpd.pid"`
 2. `netstat -ltnp | grep :80`找到httpd进程号
```
tcp6       0      0 :::80                   :::*                    LISTEN      94732/httpd 
```
 3. 杀死进程号`sudo kill -9 94732`
 4. 开启服务 `/usr/local/apache/bin/apachectl start`

 <b>方案2</b>:
 1. 注释`#PidFile  "/var/run/httpd.pid"`
 2. 关闭服务 `/usr/local/apache/bin/apachectl stop`
 3. 删除注释`PidFile  "/var/run/httpd.pid"`
 4. 开启服务 `/usr/local/apache/bin/apachectl start`

 4. 环境变量
 ~~~
vi /root/.bash_profile

PATH=$PATH:$HOME/bin:/usr/local/apache/bin
source /root/.bash_profile
~~~

 5. 开机自启（该文件作用是机器重启后执行该命令）
 ~~~
vim /etc/rc.d/rc.local

apachectl -k start  //最后一行添加
~~~
