locals {
  name ="${var.project_name}-${var.environment}"
  private_subnet_ids = element(split(",",data.aws_ssm_parameter.private_subnets.value),0)
  current_time= formatdate("DD-MM-YYYY-hh-mm",timestamp())
}

  