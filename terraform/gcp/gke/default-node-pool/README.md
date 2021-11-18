# GKE with Default Node Pool

Node pool is a critical part of a GKE cluster. We can create 1 to many node pools with the Terraform module `google_container_node_pool` and then associate them to the `google_container_cluster` resource or just define 1 (default) node pool within the `google_container_cluster` resource.

This recipe produces the following resources and functions:

* A custom network configured for GKE usage created by a [separate Terraform module](../../network/gke-network).
* Regional GKE cluster.
* Use the default node pool.

**NOTE: This Terraform module creates resources on GCP, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Notes

### Initial Node Count

There are 2 types of GKE cluster: zonal and regional. The initial number of nodes is based on the `initial_node_count` attribute defined in the module. An `initial_node_count` of 1 creates 1 node per zone. A regional GKE cluster typically has 3 zones. So with a regional GKE cluster with `initial_node_count` of 1, the module will create a total of 3 nodes. 

## Setup

1. Create a `terraform.tfvars` and enter the pertinent values like project id.

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
