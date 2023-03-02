# Dynamic Block

You may encounter a resource block with a set of 0 to n nested blocks of the same type. And writing repeated nested blocks may be tedious. For example:

```terraform
resource "snowflake_table" "my_table" {
  database = snowflake_database.my_db.name
  schema   = "my_schema"
  name     = "my_table"

  column {
    name = rider_id
    type = "integer"
    nullable = false
  }

  column {
    name = start_time
    type = "timestamp_ntz(9)"
    nullable = false
  }

  column {
    name = end_time
    type = "timestamp_ntz(9)"
    nullable = false
  }

  column {
    name = start_station
    type = "text"
    nullable = true
  }

  column {
    name = end_station
    type = "text"
    nullable = true
  }
}
```

We can dynamically create these repeatable nested blocks using a terraform construct call `dynamic` block. So the above example can be rewritten as:

```terraform
locals {
  my_table = {
    columns = {
      rider_id = {
        type     = "integer"
      }
      start_time = {
        type     = "timestamp_ntz(9)"
      }
      end_time = {
        type     = "timestamp_ntz(9)"
      }
      start_location = {
        type     = "text"
        nullable = true
      }
      end_location = {
        type     = "text"
        nullable = true
      }
    }
  }
}

resource "snowflake_table" "my_table" {
  database = snowflake_database.my_db.name
  schema   = "my_schema"
  name     = "my_table"

  dynamic "column" {
    for_each = local.my_table
    content {
      name     = column.key
      type     = lookup(column.value, "type", "text")
      nullable = lookup(column.value, "nullable", false)
    }
  }
}
```

The dynamic block is labeled as `column`, the iterator variable `column` (in `lookup(column.value...)`) should be set to match the dynamic block label.


## Reference

* [Terraform: dynamic block](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)
