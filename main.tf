module "aws" {
  source   = "./modules/aws"
  vpc-cidr  = var.vpc-cidr
  subnet-A = var.subnet-A
  subnet-B = var.subnet-B
  az-1     = var.az-1
  az-2     = var.az-2
  region   = var.region
}
