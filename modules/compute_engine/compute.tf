resource "google_service_account" "default" {
  account_id   = "${var.project}-sa-${var.environment}"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = "${var.project}-${var.environment}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_x86_64.self_link
    }
  }

  #scratch_disk {
  #  interface = "NVME"
  #}

  network_interface {
    subnetwork = var.subnetwork_id
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${var.gce_ssh_pub_key_file}"
  }

  metadata_startup_script = file("${path.module}/user_data/${var.startup_script}")

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}