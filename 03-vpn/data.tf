# data "aws_ami" "centos8" {
#   most_recent = true

#   owners = ["973714476881"]

#    filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#    filter {
#     name   = "name"
#     values = ["Centos-8-DevOps-Practice"]
#   }
#    filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
#   }

# data "aws_ssm_parameter" "security_vpn" {
# name  = "/${var.project_name}-${var.environment}/vpn_Sg_id"
# }


# data "aws_vpc" "vpn" {
#   default = true
# }

# data "aws_subnet" "selected" {
#   vpc_id = data.aws_vpc.vpn.id
#   availability_zone = "us-east-1a"
# }

data "aws_ami" "centos8"{
    owners = ["973714476881"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["Centos-8-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
}

data "aws_ssm_parameter" "security_grp_vpn" {
   name  = "/${var.project_name}-${var.environment}/vpn_Sg_id"
}
# output "vpc_info" {
#   value = data.aws_subnet.selected.id
# }