# module "ec2_instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   ami = data.aws_ami.centos8.id
#   name =  "${local.name}-vpn"
#   instance_type = "t3.small"
#   vpc_security_group_ids  = [data.aws_ssm_parameter.security_vpn.value]
#   subnet_id = data.aws_subnet.selected.id
#   user_data = file("userfile.sh")
#   tags = {
#     Name =  "${local.name}-vpn"
#   }
# }

module "vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.name}-vpn"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.security_grp_vpn.value]
  subnet_id              = data.aws_subnet.selected.id
  user_data = file("openvpn.sh")
  tags = merge(
    var.common_tags,
    {
      Component = "vpn"
    },
    {
      Name = "${local.name}-vpn"
    }
  )
}