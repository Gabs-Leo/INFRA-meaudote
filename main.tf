/*
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
  subnet_name = module.vpc.private_subnet_1_name
  registry_name = module.artifact_registry.registry_id
  env_variables = var.env_variables
  database_host = module.sql_database.db_host
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

module "artifact_registry" {
  source = "./modules/artifact_registry"
  region = var.region
  project = var.project
  environment = terraform.workspace
}

module "bastion" {
  source = "./modules/compute_engine"
  project = var.project
  environment = terraform.workspace
  tags = ["bastion"]
  subnetwork_id = module.vpc.public_subnet_1_name
  gce_ssh_user = var.ssh_user
  gce_ssh_pub_key_file = var.ssh_public_key
}
*/
module "backend_service_account" {
  source = "./modules/service_account"
  project = var.project
  sufix = "backend"
  environment = terraform.workspace
  roles = [
    "roles/editor",
    "roles/iam.serviceAccountUser",
    "roles/storage.admin"
  ]
}

module "backend_cloud_storage" {
  source = "./modules/cloud_storage"
  name = "${var.project}-${terraform.workspace}-backend-bucket"
  project = var.project
  environment = terraform.workspace
}