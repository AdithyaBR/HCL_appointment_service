# ====================== CloudWatch Log Group ======================
resource "aws_cloudwatch_log_group" "appointment_service" {
  name              = var.log_group_name
  retention_in_days = 7

  tags = {
    Name        = "appointment-log-group"
    Environment = "dev"
  }
}

# ====================== CloudWatch CPU Utilization Alarm ======================
resource "aws_cloudwatch_metric_alarm" "high_cpu_appointment" {
  alarm_name          = "appointment-service-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    ClusterName = aws_ecs_cluster.healthcare_cluster.name
    ServiceName = aws_ecs_service.appointment_service.name
  }

  alarm_description = "This alarm triggers when CPU utilization exceeds 70% for 10 minutes."
  treat_missing_data = "notBreaching"
}
