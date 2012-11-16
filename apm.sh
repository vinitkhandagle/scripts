


#!/bin/bash

yum install kernel-headers kernel-devel gcc make cmake



./configure --prefix=/var/www/html \
--with-mpm=prefork \
--enable-ssl \
--enable-cgi \
--enable-headers \
--enable-usertrack \
--enable-so
