# Convert a String to a List

This recipe shows how you can convert a string representing a list of items, delimited by commas, to a list.

* `compact` - takes a list of strings and return a list with empty strings removed.
* `split` - split a string into a list delimited by the separator.

## Notes

When you split an empty string, you get a list with an empty string. This means:

```terraform
> split(",", "")
[
  "",
]
```

Use the `compact` function to remove the empty string in the list. This why it's common to see `compact(split(",", var.my_string)) in Terraform code. 

## Reference

* [Terraform: compact Function](https://www.terraform.io/docs/language/functions/compact.html)
* [Terraform: split Function](https://www.terraform.io/docs/language/functions/split.html)
