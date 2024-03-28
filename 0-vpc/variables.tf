

variable "project_name" {
  type = string
   default = "Roboshop"
}

variable "environment" {
    type = string
    default = "Dev"
  
}

variable "common_tags" {
    type = map
    default =  {
        Name = "Roboshop"
        Terraform = "True"
        Environment = "Dev"

    }
}

variable "vpc_tags" {
    type = map 
    default = {}
  
}
variable "public_subnets_cidr" {
   
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "private_subnets_cidr" {
  default =  ["10.0.11.0/24","10.0.12.0/24"]
}
variable "database_subnets_cidr" {
   default = ["10.0.21.0/24", "10.0.22.0/24"]
}
