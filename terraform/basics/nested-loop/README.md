# Nested Loop

We can't use a nested loop within a Terraform resource. This means we can't do the following:

```terraform
locals {
  schemas = {
    "my_schema1" = {
      name = "my_schema1"
      tables = {
        "my_table1" = {
          name = "my_table1"
          privileges = {
            SELECT = {
              name = "SELECT"
              roles = ["my_role1", "my_role2"]
            }
          }
        }
      }
    }
    "my_schema2" = {
      name = "my_schema2"
      tables = {
        "my_table1" = {
          name = "my_table1"
          privileges = {
            SELECT = {
              name = "SELECT"
              roles = ["my_role1"]
            }
          }
        }
      }
    }
  }
}

# This isn't supported in Terraform
resource "snowflake_table_grant" "my_table" {
  for_each = local.schemas

  database = "my_db"
  schema   = each.key
  ...
}
```

To achieve nested loop behavior in Terraform (at least in the above use case), we first need to flatten the nested collection and pass flatten collection to the resource module. See [main.tf]() for details.

```terraform
# Flatten the nested data structure.
locals {
  table_privileges = distinct(flatten([
    for schema in local.schemas : [
      for table in schema.tables : [
        for privilege in table.privileges : {
          schema    = schema.name
          table     = table.name
          privilege = privilege.name
          roles     = privilege.roles
        }
      ]
    ]
  ]))
}
```

## Use with for_each

But we still can't use the flatten list with a resource module because the `for_each` construct only accepts a list of string or a map. So we need to transform our flatten list to a map before assigning the map to the `for_each` construct.

```terraform
resource "snowflake_table_grant" "my_table" {
  # for_each only accept map or list of string, so we need to convert the list to a map with unique keys.
  for_each = { for item in local.table_privileges : "${item.schema}.${item.table}.${item.privilege}" => item }

  database_name     = snowflake_database.cdp.name
  schema_name       = each.value.schema
  table_name        = each.value.table
  privilege         = each.value.privilege
  roles             = each.value.roles
}
```
