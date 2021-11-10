#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<h2>Built by power of <font color="purple">Terrform</font></h2><br>
Private IP: $MYIP now is static!

<p>
<font color="blue">TerrVersion 4.0</font>
</html>
EOF4
service httpd start
chkconfig httpd on