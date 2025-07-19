# ====================== ECS Cluster ======================
resource "aws_ecs_cluster" "healthcare_cluster" {
  name = var.ecs_cluster_name
}

# ====================== IAM Role for ECS Task Execution ======================
resource "aws_iam_role" "ecs_task_execution_role2" {
  name = var.ecs_task_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ====================== ECS Task Definition for Appointment Service ======================
resource "aws_ecs_task_definition" "appointment_service" {
  family                   = var.task_family_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role2.arn

  container_definitions = jsonencode([{
    name      = var.container_name,
    image     = "${aws_ecr_repository.appointment_service.repository_url}:latest",
    essential = true,
    portMappings = [{
      containerPort = var.container_port,
      hostPort      = var.container_port,
      protocol      = "tcp"
    }],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = var.log_group_name,
        "awslogs-region"        = var.aws_region,
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

# ====================== ECS Service for Appointment ======================
resource "aws_ecs_service" "appointment_service" {
  name            = var.container_name
  cluster         = aws_ecs_cluster.healthcare_cluster.id
  task_definition = aws_ecs_task_definition.appointment_service.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.appointment_service.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }   

  depends_on = [aws_lb_listener.front_end]
}
