resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_threshold

  dimensions = {
    InstanceId = var.ec2_instance_id
  }

  treat_missing_data = "notBreaching"
  alarm_description  = "Triggers when EC2 CPU exceeds threshold"

  tags = {
    Purpose = "SelfHealing"
  }
}
