# GKE with Default Node Pool

Node pool is a critical part of a GKE cluster. We can create 1 to many node pools with the Terraform module `google_container_node_pool` and then associate them to the `google_container_cluster` resource or just define 1 (default) node pool within the `google_container_cluster` resource.

This recipe shows the creation using the default node pool.   

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup

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

### Initial Node Count

There are 2 types of GKE cluster: zonal and regional. The initial number of nodes is based on the `initial_node_count` attribute defined in the module. An `initial_node_count` of 1 creates 1 node per zone. A regional GKE cluster typically has 3 zones. So with a regional GKE cluster with `initial_node_count` of 1, the module will create a total of 3 nodes. 

## Reference

* [Terraform: google_container_node_pool](https://www.terraform.io/docs/providers/google/r/container_cluster.html)
* [GCP Machine Types](https://cloud.google.com/compute/docs/machine-types)
* [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
* [GKE Node Pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
