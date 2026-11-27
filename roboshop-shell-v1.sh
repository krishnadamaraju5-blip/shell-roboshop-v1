#/bin/bash/


ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
security_group="sg-0bd4a23dde203c42e"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
domain_name="daws92s.cloud"

for instance in $@
do 
    echo "Creating instance: $instance"
    instance_id=$(aws ec2 run-instances \
    --image-id $ami_id \
    --instance-type $instance_type \
    --security-group-ids $security_group \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "$instance instance id: $instance_id"

if [ $instance != "frontend" ]; then
    IP=$(aws ec2 describe-instances \
    --instance-ids $instance_id \
    --query 'Reservations[0].Instances[0].PrivateIpAddress' \
    --output text)
    echo "$IP"

    r53_record=${instance}.${domain_name}
else
    IP=$(aws ec2 describe-instances \
    --instance-ids $instance_id \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)
    echo "$IP"

    r53_record=${domain_name}
fi
#aws r53 record update and recreation 

aws route53 change-resource-record-sets \
    --hosted-zone-id $hosted_zone_id \
    --change-batch '{
        "Changes": [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "'$r53_record'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": [
                        {
                            "Value": "'$IP'"
                        }
                    ]
                }
            }
        ]
    }'
       echo "$r53_record"
done




