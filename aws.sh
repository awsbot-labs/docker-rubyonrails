#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Usage: $0 create|update <SSH_KEYNAME> <DNSDOMAIN>"
  echo "e.g. $0 create MyAWSKey example.com"
  exit 1
else
  export AWS_DEFAULT_PROFILE=docker-hellorails
  STACK_NAME=`echo $3 | sed -e 's/\./\-/g'`
  # Sets your external IP
  IPADDRESS=`wget -qO- http://ipecho.net/plain ; echo -n`
  # Configures the aws-cli, requires an access key is and secret
  aws configure --profile $AWS_DEFAULT_PROFILE
  # Creates a CloudFormation stack for the ECS cluster
  if [ $1 == "update" ]; then
    COMMAND=update-stack
  else
    COMMAND=create-stack
  fi
  aws cloudformation $COMMAND \
    --stack-name hellorails1-$STACK_NAME \
    --template-body file://aws/cf/template.json \
    --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=SSHLocation,ParameterValue="$IPADDRESS/32" ParameterKey=KeyName,ParameterValue=$2 ParameterKey=DNSDomain,ParameterValue=$3
fi
