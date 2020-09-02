# Append a String

There is a `concat` function in Terraform, but it's used for concatenating lists. In Terraform, there isn't really a function dedicated to appending a string to another string like you see in other languages like `concat` in Java or JavaScrip . However, there are 2 good workarounds:

* format - more of a string interpolation.
* join - convert a list to a string

## Reference

* [Terraform: format Function](https://www.terraform.io/docs/configuration/functions/format.html)
* [Terraform: join Function](https://www.terraform.io/docs/configuration/functions/join.html)
