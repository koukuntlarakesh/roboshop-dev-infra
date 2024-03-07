
variable "description" {
  default = {}
  }


variable "common_tags" {
    type = map
    default =  {
        Name = "Roboshop"
        Terraform = "true"
        Environment = "Dev"

    }
}
variable "sg_tags" {
    default = {}
}
variable "project_name" {
  type = string
   default = "Roboshop"
}

variable "environment" {
    type = string
    default = "Dev"
}

