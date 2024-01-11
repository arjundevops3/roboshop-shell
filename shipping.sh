echo -e "\e[35mInstall maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[35mAdd app user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35mCreate app directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[35mDownload application content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log


echo -e "\e[35m Extract app content\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[35mDownload dependencies\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[35mInstall mysql client\e[0m"
yum  install mysql -y &>>/tmp/roboshop.log

echo -e "\e[35m Load schema\e[0m"
mysql -h mysql-dev.arjund73.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[35mStart shipping service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log







