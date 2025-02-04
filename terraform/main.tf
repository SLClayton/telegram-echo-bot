# Calls the shell script (build_lambda.sh) that builds the lambda package dir
resource "null_resource" "lambda_build_script" {
  triggers = {
    # This ensures that it always runs
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "sh ../build_lambda.sh"
  }
}

# This zips up the build directory into a lambda package
data "archive_file" "lambda_package" {
  source_dir = "/tmp/tmp_lambda_build_dfy2c84w"
  output_path = "../${var.PROJECT_NAME}-package.zip"
  type = "zip"

  depends_on = [null_resource.lambda_build_script]
}

# Create IAM role for lambda
resource "aws_iam_role" "lambda_iam_role" {
  name = "${var.PROJECT_NAME}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}

# Attach the basic AWS execution policy to the IAM role
resource "aws_iam_role_policy_attachment" "basic_execution_policy_attachment" {
  role       = aws_iam_role.lambda_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# The lambda function itself
resource "aws_lambda_function" "message-handler-lambda" {
  function_name = "${var.PROJECT_NAME}-message-handler"
  filename      = data.archive_file.lambda_package.output_path
  role          = aws_iam_role.lambda_iam_role.arn
  runtime       = "python3.10"
  handler       = "lambda_function.lambda_handler"
  timeout       = 30
  memory_size   = 128
  source_code_hash  = data.archive_file.lambda_package.output_base64sha256

  # Insert the token as an env variable
  environment {
    variables = {
      TELEGRAM_BOT_TOKEN = var.TELEGRAM_BOT_TOKEN
    }
  }

  depends_on = [null_resource.lambda_build_script]
}

# Create a function URL for the lambda to be called by
resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.message-handler-lambda.function_name
  authorization_type = "NONE"
}

# Call the telegrams API 'setWebhook' endpoint directly with a curl command
# to add the newly created function url as our bots webhook
resource "null_resource" "set_telegram_webhook" {

  provisioner "local-exec" {
    command = <<EOT
      curl -X POST "https://api.telegram.org/bot${var.TELEGRAM_BOT_TOKEN}/setWebhook" \
           -H "Content-Type: application/json" \
           -d '{"url": "${aws_lambda_function_url.lambda_url.function_url}"}'
    EOT
  }

  depends_on = [aws_lambda_function_url.lambda_url]
}
