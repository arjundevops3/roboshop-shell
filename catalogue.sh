echo -e "\e[35mCongiguring nodejs repos\e[0m"
yum module disable nodejs -y &>>/tmp/roboshop.log
yum module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[35mInstalling NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[35mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35mCreate application directory\e[0m"
rm -f /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[35mDownload application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35mExtract app content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35mInstalling NodeJS dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[35m Setup systemd service\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[35mStart catalouge service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log


echo -e "\e[35mCopy mongodb repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log


echo -e "\e[35mInstalling mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[35mLoad schema\e[0m"
mongo --host mongodb-dev.arjund73.shop </app/schema/catalogue.js &>>/tmp/roboshop.log