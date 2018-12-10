#!/bin/bash

AMI=ami-009d6802948d06e52

echo $AMI


echo "How many instances do you want to create?: "

read COUNT

echo "What ec2 type do you wish to create?: "

read EC2TYPE


function create_instance () {

	echo $(aws ec2 run-instances --image-id $AMI --count $COUNT --instance-type $EC2TYPE)
}

get_instances

create_instance





