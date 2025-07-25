# ====================== ALB ======================
resource "aws_lb" "healthcare_alb1" {
  name               = "healthcare-alb-new"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = module.vpc.public_subnets
}

# ====================== Appointment Service Target Group ======================
resource "aws_lb_target_group" "appointment_service" {
  name        = "appointment-stg"
  port        = 3001
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

# ====================== ALB Listener ======================
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.healthcare_alb1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page Not Found"
      status_code  = "404"
    }
  }
}

# ====================== Listener Rule for Appointment Service ======================
resource "aws_lb_listener_rule" "appointment_service" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appointment_service.arn
  }

  condition {
    path_pattern {
      values = ["/appointment*"]
    }
  }
}

# ====================== Outputs ======================
output "alb_dns_name" {
  value = aws_lb.healthcare_alb1.dns_name
}

output "appointment_service_url" {
  value = "http://${aws_lb.healthcare_alb1.dns_name}/appointments"
}
