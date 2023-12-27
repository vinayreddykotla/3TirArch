#!/bin/bash
sudo hostnamectl set-hostname "tomcat.vinaydevops.io"
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts
sudo apt-get update
sudo apt-get install git wget unzip curl tree -y
sudo apt-get install apache2 -y 
cd /opt/
git clone https://github.com/keshavkummari/keshavkummari.git
cd keshavkummari
mv * /var/www/html/ 
sudo systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service

# Attach Instance profile To EC2 Instance 
# aws ec2 associate-iam-instance-profile --iam-instance-profile Name=SA-EC2-SSM --instance-id ""