#!/bin/bash

ACTION=$1
AGE=$2

if [ -z $ACTION ];
then
	echo "Usage $1: Define ACTION of backup or delete"
	exit 1
fi

if [ "$ACTION" = "delete" ] && [ -z $AGE ];
then
	echo "Please enter the age of backups you would like to delete"
	exit 1
fi

function backup_ebs () {

	for volume in $(aws ec2 describe-volumes | jq .Volumes[].VolumeId | sed 's/\"//g')
	do
		echo creating snapshot for $volume $(aws ec2 create-snapshot --volume-id $volume --description "backup-script")
	done
}

function delete_snapshots () {

	for snapshot in $(aws ec2 describe-snapshots --filters Name=description,Values=backup-script | jq .Snapshots[].StartTime | cut -d T -f1 | sed 's/\"//g')
	do
		echo $snapshot
	done
}

case $ACTION in
	"backup")
		backup_ebs
	;;
	"delete")
		delete_snapshots 
	;;
esac





