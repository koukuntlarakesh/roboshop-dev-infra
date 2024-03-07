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
        Terraform = "true"
        Environment = "Dev"

    }
}

