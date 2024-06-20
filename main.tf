module "aws" {
  source   = "./modules/aws"
  vpc_cidr = var.vpc_cidr
  subnet_A = var.subnet_A
  subnet_B = var.subnet_B
  az_1     = var.az_1
  az_2     = var.az_2
  region   = var.region
}


module "docker" {
  source           = "./modules/docker"
  region           = var.region
  db_name          = var.db_name
  db_user          = var.db_user
  db_password      = var.db_password
  db_root_password = var.db_root_password
  depends_on       = [module.aws]
}
module "kubernetes" {
  source     = "./modules/kubernetes"
  region     = var.region
  db_name          = var.db_name
  db_user          = var.db_user
  db_password      = var.db_password
  depends_on = [module.docker]
}

