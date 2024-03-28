module "vpc" {
    #source = "../../terraform_aws_vpc"
    source="https://github.com/koukuntlarakesh/terraform_aws_vpc.git"  
     project_name = var.project_name
     environment = var.environment
     common_tags = var.common_tags
     vpc_tags = var.vpc_tags
     public_subnets_cidr = var.public_subnets_cidr
     private_subnets_cidr = var.private_subnets_cidr
     database_subnets_cidr = var.database_subnets_cidr
     acceptor_vpc_required = true

}

