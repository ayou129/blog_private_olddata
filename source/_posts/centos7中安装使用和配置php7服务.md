---
title: centos7中安装使用和配置php7服务
description: centos7中安装使用和配置php7服务
keywords: 'php,php7,安装,php.ini,Centos7,配置,apache,httpd,linux,服务,网站,web,服务器,阿帕奇,install'
tags:
  - Centos7
  - PHP
categories:
  - 编程语言
abbrlink: 25eedda2
date: 2019-02-04 09:13:13
---
出现问题的对症下药

## 安装(root权限)
### 安装相关依赖包：
~~~
yum install -y curl libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel re2c
~~~

### 安装php
~~~
cd /usr/local/src/
wget http://hk2.php.net/get/php-7.1.26.tar.gz/from/this/mirror
tar zxvf mirror
~~~
> `http://hk2.php.net`是国内网站，mirror是压缩包，下载后解压获得所有php文件
> 备用链接
`http://hk1.php.net/get/php-7.1.26.tar.gz/from/this/mirror`
`http://php.net/get/php-7.1.26.tar.gz/from/a/mirror`

### 编译安装php
--with-php-config=/usr/local/php/bin/php-config \ 指定版本号，暂时不适用
~~~
cd php-7.1.26
./configure \
--prefix=/usr/local/php \
--with-pear=DIR \
--with-tsrm-pthreads \
--with-apxs2=/usr/local/apache/bin/apxs \
--enable-opcache \
--with-pdo-mysql \
--enable-bcmath \
--enable-mbstring \
--enable-sockets \
--enable-zip \
--enable-fpm \
--with-mysqli \
--with-gd \
--with-freetype-dir=/usr/include/freetype2 \
--with-openssl \
--with-curl \
--with-gettext \
--with-zlib=/usr
~~~

~~~
#没测试过的
./configure
--prefix=/usr/local/php
--with-config-file-path=/usr/local/php
--enable-mbstring
--enable-ftp
--with-gd
--with-jpeg-dir=/usr
--with-png-dir=/usr
--with-mysql=mysqlnd
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-pear
--enable-sockets
--with-freetype-dir=/usr
--with-zlib
--with-libxml-dir=/usr
--with-xmlrpc
--enable-zip
--enable-fpm
--enable-xml
--enable-sockets
--with-gd
--with-zlib
--with-iconv
--enable-zip
--with-freetype-dir=/usr/lib/
--enable-soap
--enable-pcntl
--enable-cli
--with-curl

make && make install
~~~

### 复制配置文件(php.ini)
php配置文件的路径已经指定到/usr/local/etc
只需要复制源码中的 `php.ini-development`或者 `php.ini-production`到usr/local/etc目录下即可，vi打开需要的扩展包
~~~
cp /usr/local/src/php-7.1.26/php.ini-development /usr/local/php/etc/php.ini
~~~


### 设置环境变量
`vi /root/.bash_profile` 将 `:/usr/local/php/bin` 加在后方，最后执行 `source /root/.bash_profile`
