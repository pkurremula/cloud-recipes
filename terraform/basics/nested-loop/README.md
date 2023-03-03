# Nested Loop

We can't use a nested loop within a Terraform resource. This means we can't do the following:

```terraform
locals {
  schemas = {
    "my_schema1" = {
      tables = {
        "my_table1" = {
          role = "my_role"
          privileges = ["SELECT", "INSERT"] 
        }
      }
    }
    "my_schema2" = {
      tables = {
        "my_table1" = {
          role = "my_role"
          privileges = ["SELECT"]
        }
      }
    }
  }
}

# This isn't supported in Terraform
resource "snowflake_table_grant" "trips" {
  for_each = local.schemas

  database = "my_db"
  schema   = each.key
  name     = each.tables
  ...
}
```

To achieve nested loop behavior in Terraform (at least in the above use case), we first need to flatten the nested collection and pass flatten collection to the resource module. See [main.tf]() for details.
