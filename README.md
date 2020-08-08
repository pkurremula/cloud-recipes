# A Collection of Terraform Recipes.

I started this project as I was learning Terraform. Over time, it evolved into a handy reference for me or anyone to look up a Terraform recipe.

## Setup

Currently, the setup is for Mac using [Homebrew](https://brew.sh/).

1. Install Homebrew.

   ```bash
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
   ```

1. Install the following Homebrew packages.

   ```bash
   $ brew install terraform awscli
   $ brew cask install google-cloud-sdk
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
    
    [dev]
    aws_access_key_id=FERJHF348fFD3EXAMPLE
    aws_secret_access_key=jdeiry34824/JDSFryewd3274dsdhfEXAMPLE
    
    $ vi ~/.aws/config
    [default]
    region = us-west-2
    output = json
    
    [profile dev]
    region = us-east-1
    output = text
    ```
   
1. Verify that `awscli` is working by running the following:

   ```bash
   $ aws ec2 describe-instances --profile dev
   ```   
   
1. Configure Google Cloud CLI Tool.

   ```bash
   $ gcloud config set project [project-id]
   $ gcloud config set compute/zone us-west1  # This optional
   $ gcloud auth login 
   ```   

## Reference

* [Terraform: Up & Running](https://www.oreilly.com/library/view/terraform-up/9781492046899/) by Yevgeniy Birkman
* [Terraform homepage](https://www.terraform.io/)
