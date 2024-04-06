module "vpn" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "vpn"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  description = "sg for vpn"
  vpc_id = data.aws_vpc.vpn.id
  sg_tags = var.sg_tags
  
}
module "mongodb" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "mongodb"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  description = "sg for mongodb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "redis" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "redis"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for redis"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "rabbitmq" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "rabbitmq"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for rabitmq"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "mysql" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name ="mysql"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for mysql"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "catalogue" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "catalogue"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  description = "sg for catalogue"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "user" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "user"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for user"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "cart" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "cart"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for cart"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "payment" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name ="payment"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for payment"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "shipping" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name = "shipping"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for shipping"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "dispatch" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=mainf"
  sg_name = "dispatch"
  project_name = var.project_name
  environment = var.environment
    common_tags = var.common_tags
  description = "sg for dispatch"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "web" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name ="web"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  description = "sg for web"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "app_alb" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name ="app_alb"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  description = "sg for app_alb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}
module "web_alb" {
  source = "git::https://github.com/koukuntlarakesh/roboshop_aws_sg/roboshop_aws_sg.git?ref=main"
  sg_name ="web_alb"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  description = "sg for web_alb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_tags = var.sg_tags
}

# app alb should accept connections only from vpn because it is internal
resource "aws_security_group_rule" "app_alb_vpn" {
 source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}

#  traffic accepting from the web to app_alb
resource "aws_security_group_rule" "app_alb_web" {
 source_security_group_id = module.web.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
#  traffic accepting from the catalogue to app_alb for internal transfers
resource "aws_security_group_rule" "app_alb_catalogue" {
 source_security_group_id = module.catalogue.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
#  traffic accepting from the user to app_alb for internal transfers
resource "aws_security_group_rule" "app_alb_user" {
 source_security_group_id = module.user.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
#  traffic accepting from the cart to app_alb for internal transfers
resource "aws_security_group_rule" "app_alb_cart" {
 source_security_group_id = module.cart.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
#  traffic accepting from the shipping to app_alb for internal transfers
resource "aws_security_group_rule" "app_alb_shipping" {
 source_security_group_id = module.shipping.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
#  traffic accepting from the payment to app_alb for internal transfers
resource "aws_security_group_rule" "app_alb_payment" {
 source_security_group_id = module.payment.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
#  traffic accepting from the dispatch to app_alb for internal transfers
resource "aws_security_group_rule" "app_alb_dispatch" {
 source_security_group_id = module.dispatch.security_grp
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id = module.app_alb.security_grp
}
# traffic accepting from the internet through to  the web alb 
resource "aws_security_group_rule" "web_alb" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id = module.web_alb.security_grp
}
#openvpn
resource "aws_security_group_rule" "vpn_home" {
  security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"] #ideally your home public IP address, but it frequently changes
}

#for accessing mongodb server through vpn with out the public address
resource "aws_security_group_rule" "mongodb_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mongodb.security_grp
}

#mongodb accepting connections from catalogue instance
resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.security_grp
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.security_grp
}
#mongodb accepting connections from user instance
resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.security_grp
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.security_grp
}
resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.security_grp
}
resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.security_grp
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.security_grp
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.security_grp
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.security_grp
}

resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.security_grp
}


resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.security_grp
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.security_grp
}


resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.security_grp
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.security_grp
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.security_grp
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.security_grp
}

resource "aws_security_group_rule" "catalogue_app_alb" {
  source_security_group_id = module.app_alb.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.security_grp
}

# resource "aws_security_group_rule" "catalogue_cart" {
#   source_security_group_id = module.cart.security_grp
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.security_grp
# }

resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.security_grp
}

resource "aws_security_group_rule" "user_app_alb" {
  source_security_group_id = module.app_alb.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.security_grp
}


# resource "aws_security_group_rule" "user_web" {
#   source_security_group_id = module.web.security_grp
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.security_grp
# }

# resource "aws_security_group_rule" "user_payment" {
#   source_security_group_id = module.payment.security_grp
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.security_grp
# }

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.security_grp
}

# resource "aws_security_group_rule" "cart_web" {
#   source_security_group_id = module.web.security_grp
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.security_grp
# }
resource "aws_security_group_rule" "cart_app_alb" {
  source_security_group_id = module.app_alb.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.security_grp
}
resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.security_grp
}

resource "aws_security_group_rule" "cart_payment" {
  source_security_group_id = module.payment.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.security_grp
}

resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.security_grp
}

# resource "aws_security_group_rule" "shipping_web" {
#   source_security_group_id = module.web.security_grp
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.security_grp
# }
resource "aws_security_group_rule" "shipping_app_alb" {
  source_security_group_id = module.app_alb.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.security_grp
}
resource "aws_security_group_rule" "payment_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payment.security_grp
}

# resource "aws_security_group_rule" "payment_web" {
#   source_security_group_id = module.web.security_grp
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.payment.security_grp
# }
resource "aws_security_group_rule" "payment_app_alb" {
  source_security_group_id = module.app_alb.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payment.security_grp
}
resource "aws_security_group_rule" "dispatch_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.dispatch.security_grp
}
resource "aws_security_group_rule" "dispatch_app_alb" {
  source_security_group_id = module.app_alb.security_grp
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.dispatch.security_grp
}
resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = module.vpn.security_grp
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.security_grp
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks              = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.web.security_grp
}
