variable "vpc_cidr" {
  type = string  
}

variable "subnet_A" {
  type = string
}

variable "subnet_B" {

  type = string
}

variable "az_1" {
  type = string  
}

variable "az_2" {
  type = string  
}

variable "region" {
  type = string
}

data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

locals {
  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
}
