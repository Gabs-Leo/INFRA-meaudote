resource "google_cloud_run_v2_service" "cloud_run" {
  name     = "${var.project}-${var.region}-app-${var.environment}"
  location = var.region
  client = "gcloud"
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    containers {
      image = var.image_name
      dynamic "env" {
        for_each = { for obj in var.env_variables : obj.key => obj.value }
        content {
          name  = env.key
          value = env.value
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