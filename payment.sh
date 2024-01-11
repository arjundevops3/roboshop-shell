echo -e "\e[35mInstall python\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[35mADD application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35mCreate app directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[35mDownload application content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35mExtracting app content\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[35mInstall application dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[35m Load schema\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[35mStart payment service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment  &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log