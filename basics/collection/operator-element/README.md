# Operator [] vs element Function

There are 2 ways to reference an item in a list.

* Operator `[]`
* Function `element`

## Notes

If the operator [] reference an item that is out of bounds, Terraform raise an error. The function `element` handles out of bounds properly by wrapping around and start off from the beginning of the list. 

## Reference

* [Terraform: element Function](https://www.terraform.io/docs/configuration/functions/element.html)
