resource "google_cloud_run_v2_service" "cloud_run" {
  name     = "${var.project}-${var.region}-app-${var.environment}"
  location = var.region
  client = "cloud-console"
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  template {
    containers {
      image = var.image
      #env {
      #  name = "BUCKET"
      #  value = var.bucket
      #}
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

#resource "google_vpc_access_connector" "connector" {
#  name = "${var.project}-cn-${var.environment}"
#  subnet {
#    name = var.subnet_name
#  }
#  region = var.region
#}

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