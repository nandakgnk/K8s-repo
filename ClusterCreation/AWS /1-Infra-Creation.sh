
#!/bin/bash

# Description: This script creates a security group, allows all inbound traffic,
# and launches three EC2 instances: one master and two workers.
# Optionally, you can specify the instance type. The default is t3.medium.
# if issue with AMIID, do change it accordingly, i have taken north-virginia
read -p "ENTER VPC ID" VPC_ID
readp -p "Enter SECURITY GROUP ID" SECURITY_GROUP_ID
readp -p "Enter Keystring:" KEY_STRING
# Set the default instance type          
 INSTANCE_TYPE=${1:-t3.medium}             #Default isntance type 
#

aws ec2 run-instances \
    --image-id ami-04a81a99f5ec58529 \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_STRING \
    --security-group-ids $SECURITY_GROUP_ID \
    --instance-market-options '{
        "MarketType": "spot",
        "SpotOptions": {
            "MaxPrice": "0.05",
            "SpotInstanceType": "one-time",
            "InstanceInterruptionBehavior": "terminate"
        }
    }' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Master}]' \
    --region us-east-1
    echo "#####MASTER NODE CREATED##########"


aws ec2 run-instances \
    --image-id ami-04a81a99f5ec58529 \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_STRING \
    --security-group-ids $SECURITY_GROUP_ID \
    --instance-market-options '{
        "MarketType": "spot",
        "SpotOptions": {
            "MaxPrice": "0.05",
            "SpotInstanceType": "one-time",
            "InstanceInterruptionBehavior": "terminate"
        }
    }' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Worker1}]' \
    --region us-east-1
    echo "#####Worker1 NODE CREATED##########"


aws ec2 run-instances \
    --image-id ami-04a81a99f5ec58529 \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_STRING \
    --security-group-ids $SECURITY_GROUP_ID \
    --instance-market-options '{
        "MarketType": "spot",
        "SpotOptions": {
            "MaxPrice": "0.05",
            "SpotInstanceType": "one-time",
            "InstanceInterruptionBehavior": "terminate"
        }
    }' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Worker2}]' \
    --region us-east-1
    echo "#####Worker2 NODE CREATED##########"
