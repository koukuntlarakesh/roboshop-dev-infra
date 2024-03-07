data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}-${var.environment}/vpc-id"
}


data "aws_vpc" "vpn" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.vpn.id
  availability_zone = "us-east-1a"
}