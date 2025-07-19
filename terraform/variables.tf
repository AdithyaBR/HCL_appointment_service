# ========== AWS & VPC Configuration ==========

variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway for private subnet internet access"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use single NAT gateway across all AZs"
  type        = bool
}

# ========== ECS Cluster & Task Configuration ==========

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "IAM Role name for ECS task execution"
  type        = string
}

variable "task_family_name" {
  description = "The family name of the ECS task definition"
  type        = string
}

variable "fargate_cpu" {
  description = "CPU units for ECS Fargate task"
  type        = string
}

variable "fargate_memory" {
  description = "Memory in MiB for ECS Fargate task"
  type        = string
}

variable "container_name" {
  description = "The name of the container inside the ECS task"
  type        = string
}

variable "container_port" {
  description = "The container port to expose"
  type        = number
}

variable "desired_count" {
  description = "Number of desired ECS service instances"
  type        = number
}

# ========== CloudWatch & Logging ==========

variable "log_group_name" {
  description = "The name of the log group used by ECS for logging"
  type        = string
}
