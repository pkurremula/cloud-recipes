# GKE Zonal Cluster

In GCP, you get one GKE zonal cluster for free. Otherwise, for each additional GKE cluster, you will get charge at an hourly/cluster rate. See here for [pricing on GKE](https://cloud.google.com/kubernetes-engine/pricing).

This recipe crates a GKE zonal cluster with n number of preemptible nodes to save money.

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup

1. Create a network for the cluster.

   ```bash
   $ cd ../../network/gke-network
   $ terraform init
   $ TF_VAR_project=[GCP-project-id] terraform apply
   ```

1. Create a `terraform.tfvars` and enter the pertinent values.

   ```bash
   $ vi terraform.tfvars
   ```

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ TF_VAR_project=[GCP-project-id] terraform apply
   ```

## Notes

### Location

To designate a GKE cluster as zonal, assign a zone to the `location` property of the `google_container_cluster` module. For GKE regional cluster, assign a region.

## Reference

* [Terraform: google_container_node_pool](https://www.terraform.io/docs/providers/google/r/container_cluster.html)
* [GCP Machine Types](https://cloud.google.com/compute/docs/machine-types)
* [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
* [GKE Node Pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
