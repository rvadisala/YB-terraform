#!/bin/bash
sudo yum install epel-release -y
sudo yum install httpd -y
sudo systemctl enable --now httpd
sudo bash -c 'echo "Hosted WebServer using Terraform @ $(date) on" > /var/www/html/index.html'
ifconfig | grep  -m1 10 | awk '{print $2}' | sudo tee -a /var/www/html/index.html
sudo /usr/sbin/setenforce 0


cat >> /var/www/html/index.html <<EOF
<h1>Database Details:</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
<p>DB engine: ${db_engine}</p>
<p>DB Publicly Acceessible: ${db_accessible}</p>
EOF
