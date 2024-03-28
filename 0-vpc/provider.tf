terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
  backend "s3" {
    # access_key = "AKIAX3M5KHFOAQS37E6F"
    # secret_key = "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"
    bucket         = "roboshop-dev"
    key            = "vpc-dev"
    region         = "us-east-1"
    dynamodb_table = "roboshop-dev"
   }
}

provider "aws" {
  region = "us-east-1"
}