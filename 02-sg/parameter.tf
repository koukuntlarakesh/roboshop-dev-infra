resource "aws_ssm_parameter" "security_grp_mongodb" {
  name  = "/${var.project_name}-${var.environment}/mongodb_Sg_id"
  type  = "String"
  value = module.mongodb.security_grp
  }
  resource "aws_ssm_parameter" "security_grp_redis" {
name  = "/${var.project_name}-${var.environment}/redis_Sg_id"
  type  = "String"
  value = module.redis.security_grp
  }
  
resource "aws_ssm_parameter" "security_grp_rabbitmq" {
name  = "/${var.project_name}-${var.environment}/rabbitmq_Sg_id"
  type  = "String"
  value = module.rabbitmq.security_grp
  }
resource "aws_ssm_parameter" "security_grp_mysql" {
  name  = "/${var.project_name}-${var.environment}/mysql_Sg_id"
  type  = "String"
  value = module.mysql.security_grp
  }
resource "aws_ssm_parameter" "security_grp_catalogue" {
name  = "/${var.project_name}-${var.environment}/catalogue_Sg_id"
  type  = "String"
  value = module.catalogue.security_grp
  }
  
resource "aws_ssm_parameter" "security_grp_user" {
name  = "/${var.project_name}-${var.environment}/user_Sg_id"
  type  = "String"
  value = module.user.security_grp
  }
resource "aws_ssm_parameter" "security_grp_cart" {
  name  = "/${var.project_name}-${var.environment}/cart_Sg_id"
  type  = "String"
  value = module.cart.security_grp
  }

resource "aws_ssm_parameter" "security_grp_shipping" {
name  = "/${var.project_name}-${var.environment}/shipping_Sg_id"
  type  = "String"
  value = module.shipping.security_grp
  }
  
resource "aws_ssm_parameter" "security_grp_dispatch" {
name  = "/${var.project_name}-${var.environment}/dispatch_Sg_id"
  type  = "String"
  value = module.dispatch.security_grp
  }
resource "aws_ssm_parameter" "security_grp_payment" {
 name  = "/${var.project_name}-${var.environment}/payment_Sg_id"
  type  = "String"
  value = module.payment.security_grp
  }
  
resource "aws_ssm_parameter" "security_grp_web" {
name  = "/${var.project_name}-${var.environment}/web_Sg_id"
  type  = "String"
  value = module.web.security_grp
  }

  resource "aws_ssm_parameter" "security_grp_vpn" {
  name  = "/${var.project_name}-${var.environment}/vpn_Sg_id"
  type  = "String"
  value = module.vpn.security_grp
  }

  resource "aws_ssm_parameter" "security_grp_app_alb" {
name  = "/${var.project_name}-${var.environment}/app_alb_Sg_id"
  type  = "String"
  value = module.app_alb.security_grp
  }

   resource "aws_ssm_parameter" "security_grp_web_alb" {
name  = "/${var.project_name}-${var.environment}/web_alb_Sg_id"
  type  = "String"
  value = module.web_alb.security_grp
  }