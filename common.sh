# when ever there is a "cd" command in use, always declare a variable as
path=$(pwd)

# output redirection >>  declare a variable >>
log=/tmp/roboshop.log

# this is a function with hardcoded values
STATUS_CHECK () {
  if [ $? -eq 0 ] ; then
  echo -e "\e[31m SUCCESS \e[0m" ;
  else
    echo -e "\e[32m FAIL \e[0m"
  fi
}

# this is a function with DYNAMIC values, where values are injected inside the function
# we are creating a function and we are sending a INPUT to the Function
PRINT_HEADING () {
echo $1
}

NODE_JS () {
  PRINT_HEADING "Setup NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log}
  STATUS_CHECK

  PRINT_HEADING "Install NodeJS"
  yum install nodejs -y &>> ${log}
  STATUS_CHECK

  APP_USER

  PRINT_HEADING "Lets download the dependencies"
  npm install  &>> ${log}
  STATUS_CHECK

  SYSTEMD_SERVICE

  SCHEMA_TYPE
}

APP_USER () {
   PRINT_HEADING "Add application User"
    # when we run useradd command again and again, once if user is created, script will not create the same user again,
    # so we need to add a [ " if-else " condition along with "id" command ] to skip user creation incase user is already crerated
    id roboshop &>> ${log}
    if [ $? -eq 0 ]
    then
      echo "user roboshop already exsit"
      else
        echo "Creating user roboshop"
        useradd roboshop &>> ${log}
    fi

    PRINT_HEADING "Lets setup an app directory"
    mkdir /app  &>> ${log}
    STATUS_CHECK

    PRINT_HEADING "Download the application code to created app directory."
    curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>> ${log}
    cd /app &>> ${log}
    rm -rf * &>> ${log}
    unzip /tmp/catalogue.zip &>> ${log}
    STATUS_CHECK
}

SYSTEMD_SERVICE () {
    PRINT_HEADING "Setup SystemD Catalogue Service"
    cp ${path}/files/${component}.service /etc/systemd/system/${component}.service &>> ${log}
    STATUS_CHECK

    PRINT_HEADING "Load the service."
    systemctl daemon-reload &>> ${log}
    STATUS_CHECK

    PRINT_HEADING "Enable the service."
    systemctl enable ${component} &>> ${log}
    STATUS_CHECK

    PRINT_HEADING "Start the service."
    systemctl start ${component} &>> ${log}
    STATUS_CHECK

}

SCHEMA_TYPE (){

if [ ${load_schema} == "true" ]
then
  if [ ${schema_type} == mongodb ]
  then
  PRINT_HEADING "Copying mongo.repo file to >> /etc/yum.repos.d/mongo.repo"
  cp ${path}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${log}
  STATUS_CHECK

  PRINT_HEADING "install mongodb client."
  yum install mongodb-org-shell -y &>> ${log}
  STATUS_CHECK

  PRINT_HEADING "Load Schema"
  mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>> ${log}
  STATUS_CHECK

 else

   PRINT_HEADING " we need to install mysql client"
     yum install mysql -y  &>> ${log}
     STATUS_CHECK

     PRINT_HEADING "Load Schema"
     # password should not be hardcoded, so we will " EXPORT " the password while implementing the shipping component script
     # mysql_password=RoboShop@1  >> export mysql_password
     mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -p${mysql_password} < /app/schema/shipping.sql  &>> ${log}
     STATUS_CHECK

     PRINT_HEADING "service needs a restart"
     systemctl restart {component} &>> ${log}
     STATUS_CHECK
fi
fi
}

