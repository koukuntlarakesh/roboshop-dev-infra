# #!/bin/bash 
# component=$1
# environment=$2
# yum install python3.11-devel python3.11-pip -y
# pip3.11 install ansible botocore boto3
# ansible pull -U https://github.com/koukuntlarakesh/roboshop-ansible-roles.git -e component=$component environment=$environment  main-tf.yaml


#!/bin/bash
component=$1
environment=$2 #dont use env here, it is reserved in linux
yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible botocore boto3
ansible-pull -U  https://github.com/koukuntlarakesh/roboshop-terraform-roles.git -e component=$component -e env=$environment main-tf.yaml