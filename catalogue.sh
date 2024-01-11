component=$component
color="${color}"
nocolor=""\e[0m"

echo -e "${color}Congiguring nodejs repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJS${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Add application user${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Create application directory${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "${color}Download application content${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color}Extract app content${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color}Installing NodeJS dependencies${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color} Setup systemd service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color}Start catalouge service${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log


echo -e "${color}Copy mongodb repo file${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log


echo -e "${color}Installing mongodb client${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.arjund73.shop </app/schema/$component.js &>>/tmp/roboshop.log