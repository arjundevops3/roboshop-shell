echo -e "\e[35mCopy mongodb repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[35mInstalling mongodb server \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[35mUpdate mongodb listen address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[35mStart mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
