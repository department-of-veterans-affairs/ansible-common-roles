#!/bin/bash

# required to use aws tools
source /etc/profile

# output file
env_file=$1

if [ -z "$env_file" ]; then
  echo "No argument supplied"
  exit 1
fi

instance_id=`ec2-metadata --instance-id | cut -d ' ' -f2`
availability_zone=`ec2-metadata --availability-zone | cut -d ' ' -f2`
region=`echo $availability_zone | sed 's/[a-z]*$//'`
tags_delimeted=`ec2-describe-tags --region $region --filter "resource-type=instance" --filter "resource-id=$instance_id"`

# parse tags
declare -A tags

while read line; do
  key=`echo "$line" | cut -f4`
  value=`echo "$line" | cut -f5`
  tags["${key}"]="${value}"
done <<< "$tags_delimeted"

# default environment variables
cat <<EOT > $env_file
export EC2_INSTANCE_ID="$instance_id"
export EC2_REGION="$region"
EOT

# emit tags as environment variables
for tag in "${!tags[@]}"; do

  # only proces valid environment variable characters
  if [[ $tag =~ ^[a-zA-Z_]+[a-zA-Z0-9_]*$ ]] ; then
    printf "export EC2_TAG_%s=\"%s\"\n" "${tag}" "${tags[${tag}]}" >> $env_file
  fi
done
