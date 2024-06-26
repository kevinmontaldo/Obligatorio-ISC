# AWS Network
variable "profile" {
  type = string
}

variable "region" {
  type = string
}

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
# RDS
variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_root_password" {
  type = string
}
# S3
variable "current_transition_days_to_standard" {
  type = string
}
variable "current_transition_days_to_glacier" {
  type = string
}
variable "noncurrent_transition_days_to_standard" {
  type = string
}
variable "noncurrent_transition_days_to_glacier" {
  type = string
}
variable "current_expiration_days" {
  type = string
}
variable "noncurrent_expiration_days" {
  type = string
}

# AWS
data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

locals {
  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
}





