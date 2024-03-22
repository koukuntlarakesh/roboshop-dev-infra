
data "aws_ssm_parameter" "private_subnets" {
   name  = "/${var.project_name}-${var.environment}/private_subnet_ids"
}
data "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}-${var.environment}/vpc-id"
}
data "aws_ssm_parameter" "app_alb_listener_arn" {
  name  = "/${var.project_name}-${var.environment}/app_alb_arn"
}
data "aws_ssm_parameter" "shipping_Sg_id" {
  name  = "/${var.project_name}-${var.environment}/shipping_Sg_id"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
  
}
