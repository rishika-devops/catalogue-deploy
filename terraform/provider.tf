terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.53.0"
    }
  }
  backend "s3" {
    bucket         = "sowjanya-state-dev"
    key            = "catalogue"
    region         = "us-east-1"
    dynamodb_table = "sowjanya-locking-dev"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}