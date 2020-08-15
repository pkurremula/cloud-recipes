# Regular Expression

Terraform provides 2 functions that supports regular expression matching.

| Function   | Description |
|------------|-------------|
| regex     | Returns the first matching substrings based on the specified regular expression. |
| regexall | Returns a list of all matching substrings based on the specified regular expression. |

Avoid using `regex`. With the newer `regexall` function, it's not clear why we even have `regex` - it's probably to support older code. The problem with `regex` function is if the specified pattern doesn't match the string, the function returns an error. For example: `regex("\\d", "abc")` will cause an error and forces terraform to exit. And in some context, this may be acceptable. It's better to just use `regexall`, which returns a list of matched substrings. We test the return result for its length, and a length of 0 means that there're no matches.

> **Notes**
>
> See [here](https://github.com/google/re2/wiki/Syntax) for details on the supported RE2 regular expression language.

## Reference

* [Terraform: regex](https://www.terraform.io/docs/configuration/functions/regex.html)
* [Terraform: regexall](https://www.terraform.io/docs/configuration/functions/regexall.html)
