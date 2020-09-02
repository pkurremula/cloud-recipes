output "arn" {
  description = "The ARN of the repository."
  value       = aws_ecr_repository.repo.arn
}

output "registry_id" {
  description = "The registry ID of the repository."
  value       = aws_ecr_repository.repo.registry_id
}

output "repository_url" {
  description = "The URL of the repository."
  value       = aws_ecr_repository.repo.repository_url
}
