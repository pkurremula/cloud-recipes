# Use an existing Terraform module to create a compatible VPC that supports EKS.

module "network" {
  source = "../../network/eks-network"

  prefix       = var.prefix
  region       = var.region
  cluster_name = local.cluster_name

  public_subnet_cidrs  = var.subnets.public_cidrs
  private_subnet_cidrs = var.subnets.private_cidrs
}
