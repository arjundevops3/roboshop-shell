echo -e "\e[35mCopy mongodb repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[35mInstalling mongodb server \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

#modify conf file
echo -e "\e[35mStart mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
