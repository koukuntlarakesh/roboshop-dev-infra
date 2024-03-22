
resource "aws_ssm_parameter" "web_alb" {
  name  = "/${var.project_name}-${var.environment}/web_alb"
  type  = "String"
  value = aws_lb.web_alb.arn
  }
resource "aws_ssm_parameter" "web_alb_listener" {
  name  = "/${var.project_name}-${var.environment}/web_alb_listener"
  type  = "String"
  value = aws_lb_listener.web_alb.arn
  }

