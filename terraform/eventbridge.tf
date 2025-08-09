resource "aws_cloudwatch_event_rule" "alarm_trigger" {
  name        = "TriggerLambdaOnAlarm"
  description = "Fires when CloudWatch alarm enters ALARM state"

  event_pattern = jsonencode({
    source = ["aws.cloudwatch"],
    "detail-type" = ["CloudWatch Alarm State Change"],
    detail = {
      state = {
        value = ["ALARM"]
      },
      alarmName = [var.alarm_name]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.alarm_trigger.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.self_healing.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.self_healing.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.alarm_trigger.arn
}
