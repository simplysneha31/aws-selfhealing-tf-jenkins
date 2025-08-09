resource "aws_lambda_function" "self_healing" {
  function_name = var.lambda_function_name
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler
  role          = aws_iam_role.lambda_exec.arn

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  timeout          = 30
  memory_size      = 128

  tags = {
    Purpose = "SelfHealing"
  }
}
