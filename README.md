# A Collection of Terraform Recipes.

I started this project as I was learning Terraform. Over time, it evolved into a handy reference for me or anyone to look up a Terraform recipe.

## Recipes

* Basics
  * Collection
    * [List to string](basics/collection/list-to-string) - Convert a list of strings to a string of the objects delimited by comma.
    * [Map](basics/collection/map) - Create maps using the `map` function and `{}` operators.
  * Loop
    * [count vs for vs for_each](basics/loop) - The 3 constructs `count`, `for`, and `for_each` for looping in Terraform.
  * String
    * [Append to a string](basics/string/append) - Append a string to a string, the Terraform way.
    * [Formatting and interpolation](basics/string/format-n-interpolation) - Terraform string formatting and interpolation.
    * [Regex](basics/string/regex) - Regular expression in Terraform.
    * [Reverse a string](basics/string/reverse) - Reverses the characters in a string.
    * [Trim a string](basics/string/trim) - Ways to remove characters from the start/end of a string.
  * Utility
    * [Random password generator](basics/utility/password-generator) - Random password generator.

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
