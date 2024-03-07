data "aws_ssm_parameter" "mongodb_Sg_id" {
    name  = "/${var.project_name}-${var.environment}/mongodb_Sg_id"
}
data "aws_ssm_parameter" "redis_Sg_id" {
    name  = "/${var.project_name}-${var.environment}/redis_Sg_id"
}
data "aws_ssm_parameter" "rabbitmq_Sg_id" {
    name  = "/${var.project_name}-${var.environment}/rabbitmq_Sg_id"
}
data "aws_ssm_parameter" "mysql_Sg_id" {
    name  = "/${var.project_name}-${var.environment}/mysql_Sg_id"
}
data "aws_ssm_parameter" "database_subnets" {
   name  = "/${var.project_name}-${var.environment}/DATABASE_subnet_ids"
}



data "aws_ssm_parameter" "vpn_Sg_id" {

  name  = "/${var.project_name}-${var.environment}/vpn_Sg_id"
}

data "aws_ami" "centos8" {
  most_recent = true

  owners = ["973714476881"]

   filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
   filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]
  }
   filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  }

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
  
}