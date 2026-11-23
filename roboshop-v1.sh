#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
domain_name="daws92s.cloud"
security_group="sg-0bd4a23dde203c42e"


for instance in $@
do 
    echo "Creating instance: $instance"
    instance_id=$(aws ec2 run-instances \
  --image-id $ami_id \
  --instance-type $instance_type \
  --security-group-ids $security_group \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-$instance}]" \
  --query 'Instances[0].InstanceId' \
  --output text
)
    echo "$instance instance id: $instance_id"                # this line prints the instance id 


    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query 'Reservations[0].Instances[0].PrivateIpAddress' \
  --output text

      r53_record=$instance.daws92s.cloud
    else
        IP=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query 'Reservations[*].Instances[*].PublicIpAddress' \
  --output text
     r53_record=$instance_daws92s.cloud
)
)
done 




