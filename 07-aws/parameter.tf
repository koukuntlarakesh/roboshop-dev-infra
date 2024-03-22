resource "aws_ssm_parameter" "acm_certicate" {
 name  = "/${var.project_name}-${var.environment}/acm_certificate"
  type  = "String"
  value = aws_acm_certificate.koukuntla.arn
  }