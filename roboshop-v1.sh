#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
hosted_zone_id="Z00465481VWRQZXCOQUPB"
domain_name="daws92s.cloud"

for instance in $@
do 
    echo "Creating instance: $instance"
done 

