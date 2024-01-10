echo -e "\e[35mInstalling nginx server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[35mRemoving app content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[35mDownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33mExtracting frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

#we need to copy conf file

echo -e "\e[33mStarting nginx server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log