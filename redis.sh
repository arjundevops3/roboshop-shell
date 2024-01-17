source common.sh
echo -e "\e[35mInstall redis repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35m Enable redis 6 version\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mInstall redis \e[0m"
yum install redis -y &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35m Update redis listen address \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf  &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35m Start Redis server\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log
stat_check $?