variable "fargate_cpu" {
  description = "The number of CPU units used by the task"
  type        = string
  default     = "512" # 0.5 vCPU
}

variable "fargate_memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
  default     = "1024" # 1 GB
}
