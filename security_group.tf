resource "aws_security_group" "ecs_service" {
  name        = "ecs-service-sg"
  description = "Allow ALB to access ECS tasks"
  vpc_id      = module.vpc.vpc_id

 

    ingress {
    from_port       = 3001
    to_port         = 3001
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

