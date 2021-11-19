output "cluster_name" {
  description = "EKS cluster Name"
  value       = local.cluster_name
}

output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS cluster control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group associated with the EKS cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "kubectl config."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration for authenticating with this cluster."
  value       = module.eks.config_map_aws_auth
}

output "region" {
  description = "The region where the cluster is hosted."
  value       = var.region
}
