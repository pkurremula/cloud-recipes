locals {
  schemas = {
    "my_schema1" = {
      # Even though we have the schema name as the key, we still duplicate the schema name as an item in the map.
      # This way we can simplify the flattening function as we don't have to deal with calling multiple keys,
      # values, or lookup functions.
      name = "my_schema1"
      tables = {
        "my_table1" = {
          name = "my_table1"
          privileges = {
            SELECT = {
              name = "SELECT"
              roles = ["my_role1", "my_role2"]
            }
            INSERT = {
              name = "INSERT"
              roles = ["my_role1"]
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

data "null_data_source" "foreach" {
  for_each = {
    for item in local.table_privileges : "${item.schema}.${item.table}.${item.privilege}" => item
  }

  inputs = {
    privilege = each.value.privilege
  }
}

output "privileges_list" {
  value = local.table_privileges
}

output "privileges" {
  value = values(data.null_data_source.foreach)[*].outputs.privilege
}
