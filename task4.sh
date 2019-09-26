#!/bin/bash
#Task 4
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

        ErrorLog "| /usr/bin/logger -t httpd -i -p local6.info" 

        CustomLog "| /usr/bin/logger -t httpd -i -p local6.info" common


</VirtualHost>

<VirtualHost *:80>
        ServerName apache2.centos
        ServerAlias centos

        DocumentRoot "/var/www/html/apache2-centos"
</VirtualHost>
EOF
ipaddres="$(hostname -I | awk -F' ' '{print $1}')"
cat << EOF >> /etc/rsyslog.conf
local6.info		@$ipaddres
EOF
systemctl restart httpd
systemctl restart rsyslog
echo "wrong string" >> /etc/httpd/conf.d/vhosts.conf
systemctl restart httpd
tail -n 15 /var/log/messages
sed -e '/^wrong/d' -i /etc/httpd/conf.d/vhosts.conf
systemctl restart httpd
curl -iL viktar.kaliada
tail -n 15 /var/log/messages
