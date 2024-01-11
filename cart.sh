source common.sh

component=cart


echo -e "${color}Congiguring Nodejs repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color}Installing NodeJS${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color}Add application user${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color}Create application directory${nocolor}"
rm -rf /app &>>${log_file}
mkdir /app 

echo -e "${color}Download application content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd /app

echo -e "${color}Extract app content${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}
cd /app

echo -e "${color}Installing NodeJS dependencies${nocolor}"
npm install &>>${log_file}

echo -e "${color} Setup systemd service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color}Start ${component}  service${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}


