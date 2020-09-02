# Trim a String

Terraform provides multiple functions to remove characters and substrings from a string:

| Function   | Description |
|------------|-------------|
| chomp      | Remove newline characters at the end of a string. |
| trim       | Remove characters at the start and end of a string. |
| trimprefix | Remove a word from the start of a string. |
| trimsuffix | Remove a word from the end of a string. |
| trimspace  | Remove all whitespaces at the start and end of a string. |

This recipe is an example of how these functions can be used to remove characters from a string. 

> **Notes**
>
> 1. The `trim` function remove the characters (not substring) specified in the second argument. This means that any of the characters in the second argument will be removed from the target string.
> 1. Functions `trimprefix` and `trimsuffix` remove a substring from the target string.

## Reference

* [Terraform: chomp](https://www.terraform.io/docs/configuration/functions/chomp.html)
* [Terraform: trim](https://www.terraform.io/docs/configuration/functions/trim.html)
* [Terraform: trimprefix](https://www.terraform.io/docs/configuration/functions/trimprefix.html)
