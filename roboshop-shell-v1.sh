#/bin/bash/

# user_id=$(id -u)
ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
security_group="sg-0bd4a23dde203c42e"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
domain_name="daws92s.cloud"

if [ $user_id -ne 0 ]; then
    echo "Please run the script with sudo access"
    exit 1
fi

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
done


