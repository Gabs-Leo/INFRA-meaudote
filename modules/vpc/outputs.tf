output "vpc_id" {
  value = google_compute_network.vpc.id
}
output "vpc_name" {
  value = google_compute_network.vpc.name
}
output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}
output "private_subnet_1_name" {
  value = google_compute_subnetwork.private[0].name
}