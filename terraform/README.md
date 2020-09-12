# A Collection of Terraform Recipes

A handy reference and recipes on Terraform.

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
    * [User-data](aws/ec2/user-data) - A recipe that uses the `templatefile` function to inject a startup script to configure the EC2 instance further during its creation.
  * ECR
    * [Simple](aws/ecr/simple) - A simple recipe to create an ECR repository.
  * Security Group
    * [Simple](aws/security-group/simple) - A simple recipe to create a security group.  
    * [Dynamic](aws/security-group/dynamic) - A recipe that creates multiple rules in a security group using the `dynamic` block and a list.
  * VPC
    * [Simple](aws/vpc/simple) - A simple recipe to create a VPC.
* GCP
  * GCE
    * [Simple](gcp/gce/simple) - A simple recipe to create an GCE instance.
    * [Startup script](gcp/gce/startup-script) - A recipe that uses the `templatefile` function to inject a startup script to configure the GCE instance further during its creation.

## Reference

* [Terraform: Up & Running](https://www.oreilly.com/library/view/terraform-up/9781492046899/) by Yevgeniy Birkman
* [Terraform homepage](https://www.terraform.io/)
