# ECR

A simple recipe for creating an ECR repository.

This recipe produces the following resources and functions:

* An ECR repository.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

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

1. To test, we need to build the Dockerfile into a Docker image. Run the following.

   ```bash
   $ docker-compose build
   ```

1. Authenticate Docker to ECR. If you receive an error with the following command, upgrade to the latest version of AWS CLI - version `2.0.44` is known to know. On Mac, you can run `brew upgrade awscli`.

   ```bash
   $ # Assuming us-west-2
   $ aws ecr get-login-password | docker login --username AWS --password-stdin "$(terraform output repository_url)"
   ```

1. Tag the Docker image to associate it with the ECR repository and then push to ECR.

   ```bash
   $ docker tag hello-node "$(terraform output repository_url)"
   $ docker push "$(terraform output repository_url)"
   ```

1. Check if the Docker image has been pushed to ECR.

   ```bash
   $ aws ecr list-images --repository-name dev
   ```
   
1. Destroy the ECR repository.

   ```bash
   $ terraform destroy
   ```   

## Notes

### Image Scanning

ECR provides image scanning after an image is pushed to a repository. See [ECR User Guide](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html) for details.

## Reference

* [Terraform: ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
* [AWS User Guide: Push Docker Image to ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)
* [AWS User Guide: Getting Started with ECR using AWS CLI](https://docs.aws.amazon.com/AmazonECR/latest/userguide/getting-started-cli.html)
