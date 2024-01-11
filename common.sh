color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


nodejs() {
  echo -e "${color}Congiguring nodejs repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo -e "${color}Installing NodeJS${nocolor}"
  yum install nodejs -y &>>$log_file

  echo -e "${color}Add application user${nocolor}"
  useradd roboshop &>>$log_file

  echo -e "${color}Create application directory${nocolor}"
  rm -rf ${app_path} &>>$log_file
  mkdir ${app_path}

  echo -e "${color}Download application content${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  cd ${app_path}

  echo -e "${color}Extract app content${nocolor}"
  unzip /tmp/$component.zip &>>$log_file
  cd ${app_path}

  echo -e "${color}Installing NodeJS dependencies${nocolor}"
  npm install &>>$log_file

  echo -e "${color} Setup systemd service${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file

  echo -e "${color}Start catalouge service${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file


}

mongo_schema_setup() {
  echo -e "\e[35mCopy mongodb repo file\e[0m"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log


  echo -e "\e[35mInstalling mongodb client\e[0m"
  yum install mongodb-org-shell -y &>>/tmp/roboshop.log

  echo -e "\e[35mLoad schema\e[0m"
  mongo --host mongodb-dev.arjund73.shop </app/schema/user.js &>>/tmp/roboshop.log
}