output "vpc_self_link" {
  description = "The URI of this VPC."
  value       = google_compute_network.vpc.self_link
}

output "vpc_id" {
  description = "The ID of this VPC."
  value       = google_compute_network.vpc.id
}

output "primary_subnet" {
  description = "The primary subnet of this VPC."
  value       = google_compute_subnetwork.primary
}

output "gke_subnet" {
  description = "The GKE subnet of this VPC."
  value       = google_compute_subnetwork.gke
}

output "router_nat" {
  description = "The NAT service in a router."
  value       = google_compute_router_nat.this
}
