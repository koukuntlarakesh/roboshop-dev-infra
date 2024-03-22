variable "project_name" {
  default =  "Roboshop"
}
variable "environment" {
  default = "Dev"
}
variable "instance_type" {
  default =  "t2.micro"
}
variable "iam_instance_profile" {
  default = "ec2roleforshellscript"
}
variable "common_tags" {
  type = map 
  default = {
    Name = "Roboshop"
    terraform =true
    Environment = "Dev"
  }
}
variable "tags" {
 default = {Component = "payment"}
}
variable "priority" {
  default = "40"
}


