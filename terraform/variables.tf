variable "PROJECT_NAME" {
  description = "project name"
  type        = string
  default     = "telegram-echo-bot-python"
}

variable "AWS_REGION" {
  type        = string
  default     = "us-east-1"
}

variable "TELEGRAM_BOT_TOKEN" {
  type = string
  sensitive = true
}
