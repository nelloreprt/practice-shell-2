# when ever there is a "cd" command in use, always declare a variable as
# path=$(pwd)

# output redirection >>  declare a variable >>
# log=/tmp/roboshop.log
# call the variable ${log}
# result=>>   &>> ${log}

# this is a function with hardcoded values
# STATUS_CHECK () {
#  if [ $? -eq 0 ] ; then
#  echo -e "\e[31m SUCCESS \e[0m" ;
#  else
#   echo -e "\e[32m FAIL \e[0m""
#  fi
# }

# this is a function with DYNAMIC values, where values are injected inside the function
# we are creating a function and we are sending a INPUT to the Function

# PRINT_HEADING () {
# echo $1
# }

source common.sh

# we are declaring a variable for the component
component=catalogue

# we are declaring a variable to match a string_condition inside the file >> common.sh
load_schema=true
schema_type=mongodb

# as the script is almost same to the foloowing components
# 03-Catalogue >> nodeJS + load Schema
# 05-User >>      nodeJS + load Schema
# 06-Cart >>      nodeJS +    N.A
# 08-Shipping >>   N.A   + load Schema
# in order to keep the code DRY, we are using FUNCTION with hard coded content or hardcoded values
# so the function name is " NODE_JS " >> which is available inside the file " common.sh "
NODE_JS





































