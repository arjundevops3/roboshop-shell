color="${color}m"
nocolor="${nocolor}"
log_file="$log_file"
app_path="/app"

app_presetup() {
  echo -e "${color}Add application user${nocolor}"
  useradd roboshop &>>$log_file

  echo -e "${color}mCreate app directory${nocolor}"
  rm -rf /app &>>$log_file
  mkdir /app &>>$log_file

  echo -e "${color}Download application content${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file

  echo -e "${color}Extract app content${nocolor}"
  cd ${app_path}
  unzip /tmp/$component.zip &>>$log_file

}

systemd_setup() {
  echo -e "${color} Setup systemd service${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file

  echo -e "${color}Start catalouge service${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file
}


nodejs() {
  echo -e "${color}Congiguring nodejs repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo -e "${color}Installing NodeJS${nocolor}"
  yum install nodejs -y &>>$log_file

  app_presetup

  echo -e "${color}Installing NodeJS dependencies${nocolor}"
  npm install &>>$log_file

  systemd_setup


}

mongo_schema_setup() {
  echo -e "${color}Copy mongodb repo file${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file


  echo -e "${color}Installing mongodb client${nocolor}"
  yum install mongodb-org-shell -y &>>$log_file

  echo -e "${color}Load schema${nocolor}"
  mongo --host mongodb-dev.arjund73.shop </app/schema/user.js &>>$log_file
}


mysql_schema_setup() {
  echo -e "${color}Install mysql client${nocolor}"
  yum  install mysql -y &>>$log_file

  echo -e "${color} Load schema${nocolor}"
  mysql -h mysql-dev.arjund73.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$log_file
}
maven() {
  echo -e "${color}Install maven${nocolor}"
  yum install maven -y &>>$log_file

  app_presetup
  mysql_schema_setup
  echo -e "${color}Download maven dependencies${nocolor}"
  mvn clean package &>>$log_file
  mv target/shipping-1.0.jar shipping.jar &>>$log_file

  systemd_setup
}