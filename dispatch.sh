echo -e "\e[35mInstalling golang \e[0m"
yum install golang -y &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mADD Application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mCreate application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mDownload application content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
stat_check $?


echo -e "\e[35mExtract application content\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mdownload app dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35m Load schema\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mStart dispatch service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log
stat_check $?