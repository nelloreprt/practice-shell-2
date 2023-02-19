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

PRINT_HEADING "installing repo file as a rpm"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${log}
STATUS_CHECK

PRINT_HEADING "Enable Redis 6.2 from package"
dnf module enable redis:remi-6.2 -y &>> ${log}
STATUS_CHECK

PRINT_HEADING "Install Redis"
yum install redis -y  &>> ${log}
STATUS_CHECK

PRINT_HEADING "using " sed " to replace 127.0.0.1 to 0.0.0.0 in /etc/redis.conf "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>> ${log}
STATUS_CHECK

PRINT_HEADING "using " sed " to replace 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>> ${log}
STATUS_CHECK

PRINT_HEADING "Enable the service."
systemctl enable redis &>> ${log}
STATUS_CHECK

PRINT_HEADING "Start the service."
systemctl start redis &>> ${log}
STATUS_CHECK




















