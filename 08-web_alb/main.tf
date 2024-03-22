resource "aws_lb" "web_alb" {
  name               = "${local.name}-${var.tags.Component}"
  internal           = false 
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.security_grp_web_alb.value]
  subnets            =  split(",",data.aws_ssm_parameter.public_subnets.value)



  tags = merge(var.common_tags,var.tags)
}


resource "aws_lb_listener" "web_alb" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_ssm_parameter.acm_certificate.value

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "hiii this is from listener"
      status_code  = "200"
    }
  }
}
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name    = "web-${var.environment}"
      type    = "A"
      alias   = {
        name    = aws_lb.web_alb.dns_name
        zone_id = aws_lb.web_alb.zone_id
      }
    }
  ]
}





