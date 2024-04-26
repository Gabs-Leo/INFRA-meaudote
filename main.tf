module "vpc" {
  source = "./modules/vpc"
  subnet_public_cidrs = var.subnet_public_cidrs
  subnet_private_cidrs = var.subnet_private_cidrs
  project = var.project
  environment = terraform.workspace
  region = var.region
}

module "cloud_run" {
  source = "./modules/cloud_run"
  depends_on = [ module.vpc ]

  region = var.region
  project = var.project
  environment = terraform.workspace
  image = "nginx"
  subnet_name = module.vpc.private_subnet_1_name
  container_port = "80"
}

module "sql_database" {
  source = "./modules/sql_database"
  depends_on = [ module.vpc ]

  project = var.project
  environment = terraform.workspace
  region = var.region
  vpc_id = module.vpc.vpc_id
  db_user = var.db_user
  db_password = var.db_password
}