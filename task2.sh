#!/bin/bash
#Task 2
systemctl start httpd
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

</VirtualHost>

<VirtualHost *:80>
        ServerName apache2.centos
        ServerAlias centos

        DocumentRoot "/var/www/html/apache2-centos"
</VirtualHost>
EOF
mkdir /var/www/html/{viktar-kaliada,apache2-centos}
cp /var/www/html/index.html /var/www/html/viktar-kaliada
cat << EOF > /var/www/html/viktar-kaliada/ping.html
<h2>This is ping.html</h2>
<hr />
<p>Created by Viktar Kaliada</p>
EOF
cat << EOF > /var/www/html/apache2-centos/index.html
<h2>This is 2dn virtual host on the same IP and port</h2>
<hr />
<p>Created by Viktar Kaliada</p>
EOF

