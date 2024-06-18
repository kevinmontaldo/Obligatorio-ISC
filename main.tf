module "aws" {
  source   = "./modules/aws"
  vpc_cidr = var.vpc_cidr
  subnet_A = var.subnet_A
  subnet_B = var.subnet_B
  az_1     = var.az_1
  az_2     = var.az_2
  region   = var.region
}
