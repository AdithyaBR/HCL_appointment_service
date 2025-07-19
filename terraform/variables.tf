variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "healthcare-cluster"
}

variable "ecs_task_execution_role_name" {
  description = "IAM role for ECS task execution"
  type        = string
  default     = "ecs-task-execution-role2"
}

variable "task_family_name" {
  description = "Task Definition Family Name"
  type        = string
  default     = "appointment-service"
}

variable "container_name" {
  description = "Name of the ECS container"
  type        = string
  default     = "appointment-service"
}

variable "container_port" {
  description = "Port used by the ECS container"
  type        = number
  default     = 3001
}

variable "log_group_name" {
  description = "Log group for ECS containers"
  type        = string
  default     = "/ecs/appointment-service"
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}
