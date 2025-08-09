variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "selfHealingLambda"
}

variable "lambda_runtime" {
  description = "Runtime environment for Lambda"
  type        = string
  default     = "python3.9"
}

variable "lambda_handler" {
  description = "Handler method for Lambda"
  type        = string
  default     = "handler.lambda_handler"
}

variable "ec2_instance_id" {
  description = "ID of the EC2 instance to monitor and remediate"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization threshold to trigger alarm"
  type        = number
  default     = 5
}

variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
  default     = "HighCPUAlarm"
}

variable "lambda_zip_path" {
  description = "Path to the zipped Lambda function code"
  type        = string
  default     = "../lambda/function.zip"
}

variable "aws_access_key"{
    description = "AWSCLI access key"
    type = string
    sensitive = true
}

variable "aws_secret_key"{
    description = "AWSCLI secret key"
    type = string
    sensitive = true
}