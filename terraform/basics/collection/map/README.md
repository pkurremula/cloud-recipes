# Literal Map vs Function Map

We can construct a map object using:

* The `tomap` function. Given that a map in Terraform requires all its field to be the same type, we can use `tomap` to "safely" convert a literal map (that may have mixed data types) to a map with a single data type. See [main.tf](main.tf).
* The `{` amd `}` operators (literal form).

Note that the `map` function is deprecated in Terraform v0.12 and later. Terraform recommends using the literal construct to create a map.

## Reference

* [Terraform: map Function](https://www.terraform.io/docs/configuration/functions/map.html)
