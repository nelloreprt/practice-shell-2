# when ever there is a "cd" command in use, always declare a variable as
path=$(pwd)

# output redirection >>  declare a variable >>
log=/tmp/roboshop.log

# this is a function with hardcoded values
STATUS_CHECK () {
  if [ $? -eq 0 ] ; then
  echo -e "\e[31m SUCCESS \e[0m" ;
  else
    echo -e "\e[32m FAIL \e[0m""
  fi
}

# this is a function with DYNAMIC values, where values are injected inside the function
# we are creating a function and we are sending a INPUT to the Function

PRINT_HEADING () {
echo $1
}
