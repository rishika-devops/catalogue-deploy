#!/bin/bash
component=$1
environment=$2
app_version=$3
sudo yum install -y python39
python3.9 -m venv ansible-env
source ansible-env/bin/activate
pip install --upgrade pip
pip install ansible botocore boto3
ansible-pull -U  https://github.com/rishika-devops/roboshop-ansible-roles-tf.git -e component=$component -e env=$environment -e app_version=$app_version main-tf.yaml
