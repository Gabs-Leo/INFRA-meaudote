output registry_id {
  value = google_artifact_registry_repository.registry.repository_id
}
output "registry_url" {
  value = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.registry.repository_id}"
}