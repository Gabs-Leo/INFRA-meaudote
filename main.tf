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
  region = var.region
  project = var.project
  environment = terraform.workspace
  image = "nginx"
  subnet_name = module.vpc.private_subnet_1_name
  container_port = "80"
}