#!/bin/bash
#Task 1
yum -y install httpd
cat << EOF > /var/www/html/index.html
<h2>Hello from httpd</h2>
<hr />
<p>Created by Viktar Kaliada</p>
EOF
systemctl start httpd
httpd -S
systemctl stop httpd
yum -y install wget
wget -P /opt http://apache.org/dist/httpd/httpd-2.4.41.tar.gz
tar -zxvf /opt/httpd-2.4.41.tar.gz -C /opt
cd /opt/httpd-2.4.41
yum -y install gcc apr-devel apr-util apr-util-devel pcre pcre-devel 
./configure --prefix=/usr/local/apache2
make
make install
cat << EOF > /usr/local/apache2/htdocs/index.html
<h2>Hello from Apache2</h2>
<hr />
<p>Created by Viktar Kaliada</p>
EOF
/usr/local/apache2/bin/apachectl start
/usr/local/apache2/bin/apachectl -S
/usr/local/apache2/bin/apachectl stop