#mongodb instance creation 
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


# redis instance creation 

module "redis" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.name}-redis"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_Sg_id.value]
  subnet_id              = local.database_subnet_ids
  tags = merge(
    var.common_tags,
    {
      Component = "redis"
    },
    {
      Name = "${local.name}-redis"
    }
  )
}

resource "null_resource" "redis" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.redis.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.redis.private_ip
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
      "sudo sh /tmp/bootstrap.sh redis dev"
    ]
  }
}

# mysql data

# module "mysql" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   ami = data.aws_ami.centos8.id
#   name                   = "${local.name}-mysql"
#   instance_type          = "t3.small"
#   vpc_security_group_ids = [data.aws_ssm_parameter.mysql_Sg_id.value]
#   subnet_id              = local.database_subnet_ids
#   tags = merge(
#     var.common_tags,
#     {
#       Component = "mysql"
#     },
#     {
#       Name = "${local.name}-mysql"
#     }
#   )
# }

# resource "null_resource" "mysql" {
#   # Changes to any instance of the cluster requires re-provisioning
#   triggers = {
#     instance_id = module.mysql.id
#   }

#   # Bootstrap script can run on any instance of the cluster
#   # So we just choose the first in this case
#   connection {
#     host = module.mysql.private_ip
#     type = "ssh"
#     user = "centos"
#     password = "DevOps321"
#   }

#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }

#   provisioner "remote-exec" {
#     # Bootstrap script called with private_ip of each node in the cluster
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh mysql dev"
#     ]
#   }
# }
# # rabbit mq instance creation

# module "rabbitmq" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   ami = data.aws_ami.centos8.id
#   name                   = "${local.name}-rabbitmq"
#   instance_type          = "t3.small"
#   vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_Sg_id.value]
#   subnet_id              = local.database_subnet_ids
#   tags = merge(
#     var.common_tags,
#     {
#       Component = "rabbitmq"
#     },
#     {
#       Name = "${local.name}-rabbitmq"
#     }
#   )
# }

# resource "null_resource" "rabbitmq" {
#   # Changes to any instance of the cluster requires re-provisioning
#   triggers = {
#     instance_id = module.rabbitmq.id
#   }

#   # Bootstrap script can run on any instance of the cluster
#   # So we just choose the first in this case
#   connection {
#     host = module.rabbitmq.private_ip
#     type = "ssh"
#     user = "centos"
#     password = "DevOps321"
#   }

#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }

#   provisioner "remote-exec" {
#     # Bootstrap script called with private_ip of each node in the cluster
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh rabbitmq dev"
#     ]
#   }
# }
module "mysql" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.name}-mysql"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_Sg_id.value]
  subnet_id              = local.database_subnet_ids
  iam_instance_profile = "ec2roleforshellscript"
  tags = merge(
    var.common_tags,
    {
      Component = "mysql"
    },
    {
      Name = "${local.name}-mysql"
    }
  )
}

resource "null_resource" "mysql" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.mysql.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.mysql.private_ip
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
      "sudo sh /tmp/bootstrap.sh mysql dev"
    ]
  }
}

module "rabbitmq" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.name}-rabbitmq"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_Sg_id.value]
  subnet_id              = local.database_subnet_ids
  iam_instance_profile = "ec2roleforshellscript"
  tags = merge(
    var.common_tags,
    {
      Component = "rabbitmq"
    },
    {
      Name = "${local.name}-rabbitmq"
    }
  )
}

resource "null_resource" "rabbitmq" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.rabbitmq.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.rabbitmq.private_ip
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
      "sudo sh /tmp/bootstrap.sh rabbitmq dev"
    ]
  }
}