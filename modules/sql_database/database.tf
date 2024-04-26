resource "google_sql_database_instance" "instance" {
  name             = "${var.project}-db-${var.environment}"
  database_version = var.instance_version
  region           = var.region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    
    ip_configuration {
      ipv4_enabled = false
      private_network = var.vpc_id
    }
  }
}

resource "google_sql_database" "database" {
  name     = "${var.project}-${var.environment}"
  instance = google_sql_database_instance.instance.name
  charset = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "root_user" {
  name     = var.db_user
  password = var.db_password
  instance = google_sql_database_instance.instance.name
}

