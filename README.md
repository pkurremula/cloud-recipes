# A Collection of Cloud Recipes

Here is a collection of recipes for Docker, Terraform, and Kubernetes for creating and scheduling resources in the Cloud.

* [Docker recipes](docker)
* [Kubernetes recipes](kubernetes)
* [Terraform recipes](terraform)

## Setup

### Terraform Setup

Currently, the setup is for Mac using [Homebrew](https://brew.sh/).

1. Install Homebrew.

   ```bash
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
   ```

1. Install the Terraform.

   ```bash
   $ brew install terraform
   ```

### AWS Setup

All AWS terraform recipes uses the AWS profile called `cloud-recipes`. So we need to create the profile in the aws profile and credentials files.

1. Install AWS CLI tool.

   ```bash
   $ brew install awscli
   ```

1. Configure AWS CLI tool.

   ```bash
   $ aws configure
   ```

    If you wish to switch to another IAM profile/user you can add that profile to `~/.aws/credentials` and `~/.aws/config`.
    
    ```bash
    $ vi ~/.aws/credentials
    [default]
    aws_access_key_id=FERJHF348fFD3EXAMPLE
    aws_secret_access_key=jdeiry34824/JDSFryewd3274dsdhfEXAMPLE
    
    [cloud-recipes]
    aws_access_key_id=AWS_FERJHF348fFD3EXAMPLE
    aws_secret_access_key=jdeiry34824/JDSFryewd3274dsdhfEXAMPLE
    
    $ vi ~/.aws/config
    [default]
    region = us-east-1
    output = json
    
    [profile cloud-recipes]
    region = us-west-2
    output = text
    ```
   
1. Verify that `awscli` is working by running the following:

   ```bash
   $ aws ec2 describe-instances --profile cloud-recipes
   ```   

### GCP Setup

1. Install GCP SDK.

   ```bash
   $ brew cask install google-cloud-sdk
   ```

1. Configure Google SDK.

   ```bash
   $ gcloud auth application-default login
   $ gcloud auth login
   $ gcloud config set project [project-id]
   $ gcloud config set compute/region us-west1  # This optional
   ```

1. Print configurations.

   ```bash
   $ gcloud config list
   ```
   
1. Update components.

   ```bash
   $ gcloud components update
   ```   
   
## Reference

* [AWS Command Line Interface](https://aws.amazon.com/cli/)
* [gcloud CLI Guide](https://cloud.google.com/sdk/gcloud)  
