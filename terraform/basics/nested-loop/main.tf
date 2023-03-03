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
          role = "my_role"
          privileges = ["SELECT", "INSERT"]
        }
      }
    }
    "my_schema2" = {
      name = "my_schema2"
      tables = {
        "my_table1" = {
          name = "my_table1"
          role = "my_role"
          privileges = []
        }
      }
    }
  }
}

locals {
  table_privileges = distinct(flatten([
    for schema in local.schemas : [
      for table in schema.tables : [
        for privilege in lookup(table, "privileges", []) : {
          schema    = schema.name
          table     = table.name
          role      = table.role
          privilege = privilege
        }
      ]
    ]
  ]))
}

output "table_privileges" {
  value = local.table_privileges
}

