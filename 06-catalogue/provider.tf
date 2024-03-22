terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
  backend "s3" {
    bucket         = "roboshop-dev"
    key            = "catalogue_dev"
    region         = "us-east-1"
    dynamodb_table = "roboshop-dev"
   }
}

provider "aws" {
  region = "us-east-1"
}