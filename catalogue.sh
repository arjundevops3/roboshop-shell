source common.sh
component=catalogue

nodejs

echo -e "${color}Copy mongodb repo file${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file


echo -e "${color}Installing mongodb client${nocolor}"
yum install mongodb-org-shell -y &>>$log_file

echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.arjund73.shop <${app_path}/schema/$component.js &>>$log_file