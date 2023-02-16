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

PRINT_HEADING "Install Nginx"
yum install nginx -y &>> ${log}
STATUS_CHECK

PRINT_HEADING "Start & Enable Nginx service"
systemctl enable nginx &>> ${log}
STATUS_CHECK

PRINT_HEADING "START NGINX"
systemctl start nginx &>> ${log}
STATUS_CHECK

PRINT_HEADING "Download the frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${log}
STATUS_CHECK

PRINT_HEADING "Change directory to /usr/share/nginx/html"
cd /usr/share/nginx/html &>> ${log}
STATUS_CHECK

PRINT_HEADING "Remove the default content that web server is serving."
rm -rf /usr/share/nginx/html/* &>> ${log}
STATUS_CHECK

PRINT_HEADING "Extract the frontend content."
unzip /tmp/frontend.zip &>> ${log}
STATUS_CHECK

PRINT_HEADING "Create Nginx Reverse Proxy Configuration."
cp ${path}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> ${log}
STATUS_CHECK

PRINT_HEADING "Restart Nginx Service to load the changes of the configuration."
systemctl restart nginx &>> ${log}
STATUS_CHECK