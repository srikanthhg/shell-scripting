#!/bin/bash

ID=$(id -u)

R=\e[31m
G=\e[32m
Y=\e[33m
N=\e[0m

TIMESTAMP=$(date +%H-%m-%S)
LOGFILE=$TIMESTAMP/$0/.log

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo -e "$R $2 $N"
    exit 1 # you can give other than 0
else
    echo "Already Installed"
fi
}

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR:: Please run the script with root access $N"
    exit 1 # you can give other than 0
else
    echo "You are the root user"
fi

dnf module disable nodejs -y &>>$LOGFILE

VALIDATE $? "disabled nodejs"

dnf module enable nodejs:18 -y &>>$LOGFILE

VALIDATE $? "enabled nodejs 18"

dnf install nodejs -y &>>$LOGFILE

VALIDATE $? "Installed nodejs"

id roboshop

if [ $? -ne 0 ]
then
    echo -e "$R user not exists $N"
    useradd roboshop
else
    echo "user already exists"
fi

mkdir /app &>>$LOGFILE

curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>>$LOGFILE

VALIDATE $? "app downloaded"

cd /app 

unzip /tmp/cart.zip &>>$LOGFILE

npm install 

cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>$LOGFILE

VALIDATE $? "copy cart service"

systemctl daemon-reload &>>$LOGFILE

VALIDATE $? "daemon reload"

systemctl enable cart &>>$LOGFILE

VALIDATE $? "enabled"

systemctl start cart &>>$LOGFILE

VALIDATE $? "service started"
