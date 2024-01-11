echo -e "\e[34m Disable mysql default password\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[34m Copy mysql repo file\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[34mInstall my sql community server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[35mStart mysql service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[35mSetup mysql password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
