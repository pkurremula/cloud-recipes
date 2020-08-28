# Type Conversion

Examples of converting a type to another type. Obviously the conversion works if the source value has a valid value representation of the target type. For example:

* `"true"` converts to bool `true`, `"false"` converts to bool `false`, but not `"yes"`.
* `"0.15"` converts to number `0.15`, but not `"abc"`.

## Primitive Types

Conversion of primitive types:

* A string variable is the most flexible. It will accept values of number, bool, and string type.
* A bool variable will only accept a bool or string value. Even 0 or 1 doesn't convert to a bool.
* A number variable will only accept a number or string value. Bool true or false doesn't convert to a number.

## Complex Types

Conversion of complex types:

* Types object and map can be used interchangeably as long as their attributes are compatible.
* Types tuple and list can be used interchangeably as long as they both have the same number of contained items.

## Reference

* [Terraform: Types](https://www.terraform.io/docs/configuration/types.html)
