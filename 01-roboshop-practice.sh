# Write a script to create a instance for roboshop project

#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
domain_name="daws92s.cloud"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
security_group="sg-0bd4a23dde203c42e"

for instance in $@
do
    echo "Creating instance: $instance"
    instance_id=$(aws ec2 run-instances \
  --image-id "$ami_id" \
  --instance-type "$instance_type" \
  --security-group-ids "$security_group" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-common}]" \
  --query 'Instances[0].InstanceId' \
  --output text)
    
    echo "$instance instance id: $instance_id"
done



