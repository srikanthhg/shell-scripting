#!/bin/bash

AMI=ami-03265a0778a880afb
SG_ID=sg-087e7afb3a936fce7
INSTANCES=("web" "catalogue" "user" "cart" "shipping"
"payment" "mongodb" "rabbitmq" "mysql" "redis")

for i in "${INSTANCES[@]}"
do
echo "instance is $i"
if [ $i == mysql ||$i == mongodb||$i == shipping ];
then 
Instance_TYPE="t3.small"
else
Instance_TYPE="t2.micro"
fi
aws ec2 run-instances --image-id $AMI --instance-type $Instance_TYPE  --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"
done

