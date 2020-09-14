output "self_link" {
  description = "The URI of the VPC."
  value       = google_compute_network.vpc.self_link
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = google_compute_network.vpc.id
}
