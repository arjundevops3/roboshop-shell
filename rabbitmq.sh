source common.sh

echo -e "${color}configure Erlang repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Configure rabbimq repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Install rabbitmq server${nocolor}"
yum install rabbitmq-server -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Start rabbitmq service ${nocolor}"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} ADDRabbitmq application user${nocolor}"
rabbitmqctl add_user roboshop $1 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
stat_check $?