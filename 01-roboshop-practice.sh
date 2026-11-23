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
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-$instance}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

  # in the above script it will create ec2 instance by what arg we passed, attach that instance to this security group and stores the instance id in instance_id
    
    echo "$instance instance id: $instance_id"

    # i wrote the if condition if arg is frontend it stores the public ip in IP variable if not it stores private ip in IP variable.
    #In r53_record if it is frontend it directly gives the public ip and if not it gives the instane name plus domain name.

    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query "Reservations[0].Instances[0].PrivateIpAddress" \
  --output text
        )
        r53_record=${instance}.${domain_name}
        echo "IP of instance is: $IP"
    else
        IP=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
)
        r53_record=${domain_name}
        echo "IP of instance is: $IP"
    fi

    echo "$r53_record"
done



