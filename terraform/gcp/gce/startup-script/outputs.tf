output "id" {
  description = "ID of the GCE instance."
  value       = google_compute_instance.host.id
}

output "private_ip" {
  description = "The private IP address assigned to the GCE instances."
  value       = google_compute_instance.host.network_interface[0].network_ip
}

output "public_ip" {
  description = "The public IP address assigned to the GCE instances."
  value       = google_compute_instance.host.network_interface[0].access_config[0].nat_ip
}
