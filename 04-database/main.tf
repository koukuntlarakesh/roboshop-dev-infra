# module "ec2_mongodb" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   ami = data.aws_ami.centos8.id
#   name =  "${local.name}-mongodb"
#   instance_type = "t3.micro"
#   vpc_security_group_ids  = [data.aws_ssm_parameter.mongodb_Sg_id.value]
#   subnet_id = local.database_subnet_ids
#   tags = {
#     Name =  "${local.name}-mongodb"
#   }
# }

# # resource "null_resource" "mongodb" {
# #   # Changes to any instance of the cluster requires re-provisioning
# #   triggers = {
# #      instance_id = module.ec2_mongodb.id
# #   }

# #   # Bootstrap script can run on any instance of the cluster
# #   # So we just choose the first in this case
# #   connection {
# #     host = module.ec2_mongodb.private_ip
# #     type = "ssh"
# #     user  = "centos"
# #     password = "DevOps321"
# #   }

# #   provisioner "file" {
# #            source = "bootstrap.sh"
# #            destination = "/tmp/bootstrap.sh"
# #   }
# #   provisioner "remote-exec" {
# #     # Bootstrap script called with private_ip of each node in the cluster
# #     inline = [
# #         "chmod +x /tmp/bootstrap.sh",
# #         "sudo sh /tmp/bootstrap.sh mongodb dev"
# #     ]
# #   }
# # }

module "mongodb" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.name}-mongodb"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_Sg_id.value]
  subnet_id              = local.database_subnet_ids
  tags = merge(
    var.common_tags,
    {
      Component = "mongodb"
    },
    {
      Name = "${local.name}-mongodb"
    }
  )
}

resource "null_resource" "mongodb" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.mongodb.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.mongodb.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb dev"
    ]
  }
}
