source.sh

echo -e "$(color)Copy mongodb repo file $(nocolor)"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
stat_check $?

echo -e "$(color)Installing mongodb server $(nocolor)"
yum install mongodb-org -y &>>/tmp/roboshop.log &>>$log_file
stat_check $?

echo -e "$(color)Update mongodb listen address$(nocolor)"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
stat_check $?

echo -e "$(color)Start mongodb service$(nocolor)"
systemctl enable mongod &>>/tmp/roboshop.log &>>$log_file
systemctl restart mongod &>>/tmp/roboshop.log &>>$log_file
stat_check $?