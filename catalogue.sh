echo -e "\e[35mCongiguring nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35mInstalling NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[35mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35mCreate application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
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
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[35mStart catalouge service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log


echo -e "\e[35mCopy mongodb repo file\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log


echo -e "\e[35mInstalling mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[35mLoad schema\e[0m"
mongo --host mongodb-dev.arjund73.shop </app/schema/catalogue.js &>>/tmp/roboshop.log