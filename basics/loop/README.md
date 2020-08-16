# Terraform Loop

Terraform supports while-loop through the following constructs:
* `count` - A parameter used for looping over resources.
* `for` - An expression for looping over lists and maps.
* `for_each` - An expression used for looping over resources and blocks.

Here's a table highlighting the 3 loop constructs:

| Construct            | Used in            | Notes                                              |
|----------------------|--------------------|----------------------------------------------------|
| [count](count)       | resource           |                                                    |
| [for](for)           | list and map       |  `if` expression can be used to perform filtering. |
| [for_each](for-each) | resource and block |                                                    |  

## Other Recipes

* [Iterate a Map](for-map) - Loop thru a map.

## Reference

* [Terraform 0.12 Preview: For and For-Each](https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each/)
