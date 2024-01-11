echo -e "${color}Installing nginx server${nocolor}"
yum install nginx -y &>>/tmp/roboshop.log &>>$log_file

echo -e "${color}Removing app content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>$log_file

echo -e "${color}Downloading frontend content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file

echo -e "${color}Extracting frontend content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$log_file

echo -e "${color}Update frontend congif file${nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file

echo -e "${color}Starting nginx server${nocolor}"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file