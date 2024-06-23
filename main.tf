module "aws" {
  source   = "./modules/aws"
  vpc_cidr = var.vpc_cidr
  subnet_A = var.subnet_A
  subnet_B = var.subnet_B
  az_1     = var.az_1
  az_2     = var.az_2
  region   = var.region
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
  current_transition_days_to_standard = var.current_transition_days_to_standard
  current_transition_days_to_glacier = var.current_transition_days_to_glacier
  noncurrent_transition_days_to_standard = var.noncurrent_transition_days_to_standard
  noncurrent_transition_days_to_glacier = var.noncurrent_transition_days_to_glacier
  current_expiration_days = var.current_expiration_days
  noncurrent_expiration_days = var.noncurrent_expiration_days
}


module "docker" {
  source           = "./modules/docker"
  region           = var.region
  db_name          = var.db_name
  db_user          = var.db_user
  db_password      = var.db_password
  db_root_password = var.db_root_password
  db_endpoint       = module.aws.db_endpoint
 depends_on  = [module.aws]
}
module "kubernetes" {
  source      = "./modules/kubernetes"
  region      = var.region
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
  db_endpoint = module.aws.db_endpoint
  az_1        = var.az_1
  depends_on  = [module.docker]
}

