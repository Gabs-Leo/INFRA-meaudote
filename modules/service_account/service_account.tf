resource "google_service_account" "service_account" {
  account_id   = "${var.project}-sa-${var.environment}-${var.sufix}"
  display_name = "${var.project} service account ${var.environment} ${var.sufix}"
}

resource "google_project_iam_member" "iam_member" {
  count = length(var.roles)
  project = var.project
  role    = var.roles[count.index]
  member  = "serviceAccount:${google_service_account.service_account.email}"
}