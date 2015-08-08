#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Usage: $0 <SSH_KEYNAME> <DNSDOMAIN>"
  echo "e.g. $0 MyAWSKey example.com"
  exit 1
else
  # Sets your external IP
  IPADDRESS=`wget -qO- http://ipecho.net/plain ; echo -n`
  export AWS_DEFAULT_PROFILE=docker-hellorails
  # Configures the aws-cli, requires an access key is and secret
  aws configure --profile $AWS_DEFAULT_PROFILE
  # Creates a CloudFormation stack for the ECS cluster
  aws cloudformation create-stack \
    --stack-name hellorails \
    --template-body file://aws/cf/template.json \
    --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=SSHLocation,ParameterValue="$IPADDRESS/32" ParameterKey=KeyName,ParameterValue=$1 ParameterKey=DNSDomain,ParameterValue=$2
fi
