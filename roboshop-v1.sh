#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
domain_name="daws92s.cloud"
security_group="sgr-0266014ef23396f91"


for instance in $@
do 
    echo "Creating instance: $instance"
    instance_id=$(aws ec2 run-instances \
  --image-id $ami_id \
  --instance-type $instance_type \
  --security-group-ids $security_group \
  --query 'Instances[0].InstanceId' \
  --output text
)
    echo "$instance instance id: $instance_id"                # this line prints the instance id 
done 




