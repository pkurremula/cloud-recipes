locals {
  cluster_name = "${var.prefix}-eks"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.23.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = compact(flatten([module.network.private_subnet_ids, module.network.public_subnet_ids]))

  vpc_id = module.network.vpc.id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                 = "${var.prefix}-worker-1"
      instance_type        = "t3a.nano"
      asg_desired_capacity = 1
    },
    {
      name                 = "${var.prefix}-worker-2"
      instance_type        = "t3a.nano"
      asg_desired_capacity = 1
    },
  ]
}
