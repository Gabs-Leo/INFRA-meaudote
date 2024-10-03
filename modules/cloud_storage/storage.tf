resource "google_storage_bucket" "auto-expire" {
  name          = var.name == "" ? "${var.project}-bucket-${var.environment}" : var.name
  location      = var.region
  force_destroy = true

  public_access_prevention = "enforced"
}