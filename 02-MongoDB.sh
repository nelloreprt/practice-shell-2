# when ever there is a "cd" command in use, always declare a variable as
#path=$(pwd)

# output redirection >>  declare a variable >>
#log=/tmp/roboshop.log
#call the variable ${log}
#result=>>   &>> ${log}

# this is a function with hardcoded values
#STATUS_CHECK () {
#  if [ $? -eq 0 ] ; then
#  echo -e "\e[31m SUCCESS \e[0m" ;
#  else
#   echo -e "\e[32m FAIL \e[0m""
#  fi
#}

source common.sh

PRINT_HEADING "Setup the MongoDB repo file"
cp /${path}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${log}
STATUS_CHECK

PRINT_HEADING "Install MongoDB"
yum install mongodb-org -y  &>> ${log}
STATUS_CHECK

PRINT_HEADING "Install MongoDB"
yum install mongodb-org -y  &>> ${log}
STATUS_CHECK

PRINT_HEADING "Enable the service."
systemctl enable mongod &>> ${log}
STATUS_CHECK

PRINT_HEADING "Start the service."
systemctl start mongod &>> ${log}
STATUS_CHECK

PRINT_HEADING "using " sed " to replace 127.0.0.1 to 0.0.0.0."
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> ${log}
STATUS_CHECK

PRINT_HEADING "Restart the service."
systemctl restart mongod &>> ${log}
STATUS_CHECK























