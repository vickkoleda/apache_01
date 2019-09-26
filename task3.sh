#!/bin/bash
#Task 3
yum -y install epel-release
yum -y install cronolog
mkdir -p /var/log/cronolog/kaliada
chmod 700 /var/log/cronolog -R
cat << EOF > /etc/httpd/conf.d/vhosts.conf
<VirtualHost *:80>
        ServerName www.viktar.kaliada
        ServerAlias viktar.kaliada

        DocumentRoot "/var/www/html/viktar-kaliada"

        RewriteEngine On
        RewriteRule ^/$ /index.html [L,R=301]
        RewriteRule ^/index.html /ping.html [L,R=301]
        RewriteRule !^/ping.html - [L,R=403]

        LogLevel alert rewrite:trace6

        ErrorLog "| /usr/sbin/cronolog /var/log/cronolog/kaliada/error_%d-%m-%Y.log" 
    	CustomLog "| /usr/sbin/cronolog /var/log/cronolog/kaliada/access_%d-%m-%Y.log" common

</VirtualHost>

<VirtualHost *:80>
        ServerName apache2.centos
        ServerAlias centos

        DocumentRoot "/var/www/html/apache2-centos"
</VirtualHost>
EOF
systemctl restart httpd
yum -y install tree
tree /var/log/cronolog/kaliada
cat /var/log/cronolog/kaliada/access_$(date +"%d-%m-%Y").log
cat /var/log/cronolog/kaliada/error_$(date +"%d-%m-%Y").log

