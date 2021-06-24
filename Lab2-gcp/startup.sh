#! /bin/bash
touch test.txt
echo "Test" > test.txt
sudo yum -y update
sudo yum -y install httpd
sudo chown -R $USER:$USER /var/www
sudo echo "<h2>Web server GCP</h2><br>Built by Terrform" > /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on