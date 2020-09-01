# A Collection of Terraform Recipes.

I started this project as I was learning Terraform. Over time, it evolved into a handy reference for me or anyone to look up a Terraform recipe.

## Recipes

* Basics
  * Collection
    * [Clean up a list](basics/collection/clean-up) - Use distinct and compact to clean up a list.
    * [List to string](basics/collection/list-to-string) - Convert a list of strings to a string of the objects delimited by a comma.
    * [Map](basics/collection/map) - Create maps using the `{}` operator and the `map` function.
    * [Operator \[\] vs Element](basics/collection/operator-element) - The difference between the `[]` operator and  the`element` function.
  * If-Else
    * [If-Else conditional](basics/if-else) - Sample code that demonstrates how if-else statements are implemented in Terraform.  
  * Loop
    * [Count vs for vs for_each](basics/loop) - The 3 constructs `count`, `for`, and `for_each` for looping in Terraform.
    * [Iterate a map](basics/loop/for-map) - Loop through a map.
  * String
    * [Append to a string](basics/string/append) - Append a string to a string, the Terraform way.
    * [Formatting and interpolation](basics/string/format-n-interpolation) - Terraform string formatting and interpolation.
    * [Regex](basics/string/regex) - Regular expression in Terraform.
    * [Reverse a string](basics/string/reverse) - Reverses the characters in a string.
    * [Trim a string](basics/string/trim) - Ways to remove characters from the start/end of a string.
  * Variables
    * [Declaration](basics/variables/declaration) - Examples of how to declare variables of the most common used types in Terraform.
    * [Conversion](basics/variables/conversion) - Examples of converting types in Terraform. 
  * Utilities
    * [Random password generator](basics/utils/password-generator) - Random password generator.
* Tools
  * [Makefile](tools/makefile) - A sample Makefile for a Terraform project.    
* AWS
  * EC2
    * [Simple](aws/ec2/simple) - A simple recipe to create an EC2 instance.
    * [Production](aws/ec2/production) - A recipe to create an EC2 instance in production.
    * [Cluster](aws/ec2/cluster) - A recipe to create a cluster of multiple EC2 instances.
    * [User-data](aws/ec2/user-data) - A recipe that uses the `template_file` module to inject configurations and then pass the user-data to configure EC2 instance during its launch.
  * ECR
    * [Simple](aws/ecr/simple) - A simple recipe to create an ECR repository.
  * Security Group
    * [Simple](aws/security-group/simple) - A simple recipe to create a security group.  
    * [Dynamic](aws/security-group/dynamic) - A recipe that creates multiple rules in a security group using the `dynamic` block and a list.
  * VOC
    * [Simple](aws/vpc/simple) - A simple recipe to create a VPC.

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
