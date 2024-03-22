# locals {
#   name ="${var.project_name}-${var.environment}"
#   public_subnets= element(split(",",data.aws_ssm_parameter.public_subnets.value),0)
# }

locals {
  name           = "${var.project_name}-${var.environment}"
  private_subnets = element(split(",", data.aws_ssm_parameter.private_subnets.value), 0)
}
