resource "google_cloud_run_v2_service" "cloud_run" {
  name     = "${var.project}-${var.region}-app-${var.environment}"
  location = var.region
  client = "gcloud"
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  client_version = "472.0.0"
  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${var.registry_name}/${var.project}-${var.region}-app-${var.environment}:d5b54c9dc37e5308e82b37f3635de6a130e1d70d"
      dynamic env {
        for_each = var.env_variables
        content {
          name = env.value.key
          value = env.value.value
        }
      }
      env {
        name = "DB_HOST"
        value = var.database_host
      }
      ports {
        container_port = var.container_port
      }
    }
    vpc_access{
      network_interfaces {
        network = "${var.project}-vpc-${var.environment}"
        subnetwork = var.subnet_name
      }
      egress = "ALL_TRAFFIC"
    }
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_v2_service.cloud_run.location
  project     = google_cloud_run_v2_service.cloud_run.project
  service     = google_cloud_run_v2_service.cloud_run.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}