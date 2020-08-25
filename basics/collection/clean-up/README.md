# Clean up a list

Sometimes, it's a good idea to clean a list of strings before to clean it up before passing the list to another function or module. We can chain these 2 functions for this purpose:

* `compact` - Remove an empty string from a list. 
* `distinct` - Remove duplicate strings.

## Notes

The functions work with list of items of any type. The function `compact` will just convert an item to a string type.

## Reference

* [Terraform: compact Function](https://www.terraform.io/docs/configuration/functions/compact.html)
* [Terraform: distinct Function](https://www.terraform.io/docs/configuration/functions/distinct.html)
