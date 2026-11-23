#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
domain_name="daws92s.cloud"

for instance in $@
do 
    echo "Creating instance: $instance"
    instance_id=$(aws ec2 run-instances \                     # so we have created ec2 instance and queried instance in through this block
    --image-id $ami_id \
    --instance-type $instance_type \
    --security-group-ids sgr-0266014ef23396f91 \
    --query 'Instances[0].InstanceId' \
    --output text
)
    echo "$instance instance id: $instance_id"                # this line prints the instance id 
done 




