terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.AWS_REGION
  default_tags {
      tags = {
        project = var.PROJECT_NAME
    }
  }
}
