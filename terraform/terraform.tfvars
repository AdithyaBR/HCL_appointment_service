# ========== AWS & VPC ==========
aws_region           = "us-west-1"
vpc_name             = "Patient-Appointment-vpc"
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-west-1a", "us-west-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
enable_nat_gateway   = true
single_nat_gateway   = true

# ========== ECS Configuration ==========
ecs_cluster_name             = "healthcare-cluster"
ecs_task_execution_role_name = "ecs-task-execution-role2"
task_family_name             = "appointment-service"
fargate_cpu                  = "512"
fargate_memory               = "1024"
container_name               = "appointment-service"
container_port               = 3001
desired_count                = 1
log_group_name               = "/ecs/appointment-service"
