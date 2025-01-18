terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.75.0, < 6.0.0"
    }
  }

  backend "s3" {
    bucket = "daws-bucket-remote-state-dev"
    key    = "expense-rds-development"
    region = "us-east-1"
    dynamodb_table = "81s-locking-dev"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}