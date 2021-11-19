# EKS Setup using AWS EKS Terraform Module

EKS setup on AWS is complex, which includes role setup, worker node configuration, Kubernetes RBAC configuration, etc. Use the [AWS EKS Terraform module](https://github.com/howdio/terraform-aws-eks). This module will use the [eks-network](../../network/eks-network) module found in this project to create a compatible network to host EKS.

**NOTE: This Terraform module creates resources on AWS, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Setup

1. Create a `terraform.tfvars` and enter the pertinent values.

   ```bash
   $ vi terraform.tfvars
   ```   
   
1. Run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

1. Add the context to kubectl.

   ```bash
   $ aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
   ```

1. Get the contexts.

   ```bash
   $ kubectl config get-contexts
   CURRENT   NAME                                                CLUSTER                                             AUTHINFO
   *         arn:aws:eks:us-west-2:12145909788:cluster/dev-eks   arn:aws:eks:us-west-2:12145909788:cluster/dev-eks   arn:aws:eks:us-west-2:12145909788:cluster/dev-eks
   ```

1. The name is too long and you don't want to type the cluster name in full. So shorten it.

   ```bash
   $ kubectl config rename-context arn:aws:eks:us-west-2:12145909788:cluster/dev-eks dev-eks
   ```
   
1. Check you cluster.

   ```bash
   $ kubetcl config use-context dev-eks
   $ kubetcl get nodes
   NAME                                       STATUS   ROLES    AGE   VERSION
   ip-10-0-2-213.us-west-2.compute.internal   Ready    <none>   16m   v1.21.5-eks-bc4871b
   ```

## Reference

* [AWS EKS Terraform module](https://github.com/howdio/terraform-aws-eks)
* [AWS Instance Types](https://aws.amazon.com/ec2/instance-types)
