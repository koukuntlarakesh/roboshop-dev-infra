module "shipping" {
  source = "../../terraform_roboshop_app"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  security_group_id = data.aws_ssm_parameter.shipping_Sg_id.value
  private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnets.value)
  iam_instance_profile = var.iam_instance_profile
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  tags = var.tags
  app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
  priority = var.priority
  instance_type = var.instance_type 
}

