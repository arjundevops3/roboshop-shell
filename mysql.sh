echo -e "\e[35mInstalling nginx server\e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[35mInstalling nginx server\e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[35mInstalling nginx server\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[35mInstalling nginx server\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

echo -e "\e[35mInstalling nginx server\e[0m"
mysql -uroot -pRoboShop@1 &>>/tmp/roboshop.log