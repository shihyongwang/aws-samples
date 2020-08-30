#!/bin/sh -x

## The S3 bucket where you will upload the new staffs.
S3Bucket=sywang-codedeploy-us-east-1

## https://console.aws.amazon.com/codesuite/codedeploy/applications?region=us-east-1
BlueGreenApp=sywang-app-codedeploy_app-830

CurrentTime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

aws deploy push \
    --application-name ${BlueGreenApp} \
    --description "new version (${CurrentTime})" \
    --ignore-hidden-files \
    --s3-location s3://${S3Bucket}/newversion.zip \
    --source /home/ec2-user/linux
