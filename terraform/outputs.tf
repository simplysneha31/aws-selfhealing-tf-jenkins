output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = aws_lambda_function.self_healing.arn
}

output "cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "eventbridge_rule_name" {
  description = "Name of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.alarm_trigger.name
}
