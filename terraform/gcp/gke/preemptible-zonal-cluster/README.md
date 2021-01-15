# GKE Zonal Cluster

In GCP, you get one GKE zonal cluster for free. Otherwise, for each additional GKE cluster, you will get charge at an hourly/cluster rate. See here for [pricing on GKE](https://cloud.google.com/kubernetes-engine/pricing).

This recipe crates a GKE zonal cluster with n number of preemptible nodes to save money.

This recipe produces the following resources and functions:

* A custom network configured for GKE usage created by a [separate Terraform module](../../network/gke-network).
* A zonal GKE cluster (1 zone to get the free tier).
* Enable monitoring and logging for the GKE cluster.
* A custom GKE service account.
* Custom node pool with the following settings:
  * Autoscaling (at the node pool level).
  * Use preemptible nodes.

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Notes

### Location

To designate a GKE cluster as zonal, assign a zone to the `location` property of the `google_container_cluster` module. For GKE regional cluster, assign a region.

## Setup

1. Create a `terraform.tfvars` and enter the pertinent values, including project id.

   ```bash
   $ vi terraform.tfvars
   ```

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Reference

* [Terraform: google_container_node_pool](https://www.terraform.io/docs/providers/google/r/container_cluster.html)
* [GCP Machine Types](https://cloud.google.com/compute/docs/machine-types)
* [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
* [GKE Node Pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
