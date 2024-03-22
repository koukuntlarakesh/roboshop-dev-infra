
data "aws_ssm_parameter" "private_subnets" {
   name  = "/${var.project_name}-${var.environment}/private_subnet_ids"
}
data "aws_ssm_parameter" "security_grp_vpn" {
  name  = "/${var.project_name}-${var.environment}/vpn_Sg_id"
}
data "aws_ssm_parameter" "security_grp_app_alb" {
 name  = "/${var.project_name}-${var.environment}/app_alb_Sg_id"
}
data "aws_ssm_parameter" "catalogue_Sg_ids" {
  name = "/${var.project_name}-${var.environment}/catalogue_Sg_id"
}
data "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}-${var.environment}/vpc-id"
}
data "aws_ssm_parameter" "app_alb_arn" {
  name  = "/${var.project_name}-${var.environment}/app_alb_arn"
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
