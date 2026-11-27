#/bin/bash/

user_id=$(id -u)
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
done


