#!/bin/bash

function get_instances () {

for instance in $( aws ec2 describe-instances | jq .Reservations[].Instances[].InstanceId)
do
	echo $instance
done

echo "Enter the instance id you wish to stop: "
read INSTANCEID

}



function stop_instances () {

	echo $(aws ec2 stop-instances --instance-ids $INSTANCEID)
}

get_instances
stop_instances


