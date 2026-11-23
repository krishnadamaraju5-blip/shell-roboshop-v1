#!/bin/bash

user_id=${id -u}
logs_folder="/var/log/roboshop"
logs_file="${logs_folder}/${0}.log"


if [ $user_id -ne 0 ]; then
    echo "Please run the script with administrative privileges"
    exit 1
fi

mkdir -p $logs_folder

validate(){
    if [ $1 -ne 0 ]; then 
    echo "${2}.......failed"
    else
    echo "${2}.......success"
    fi
}

cp mongo.repo  /etc/yum.repos.d/mongo.repo &>> $logs_file
validate $? "Adding mongo repo"

dnf install mongodb-org -y &>> $logs_file
validate $? "Mongodb installed" 

systemctl enable mongod &>> $logs_file
validate $? "Enabled mongod"

systemctl start mongod &>> $logs_file
validate $? "Started mongod"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

systemctl restart mongod &>> $logs_file

systemctl status mongod 
ss -lntp | grep 27017  



