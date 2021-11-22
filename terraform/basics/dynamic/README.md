# Dynamic Block

Sometimes we may find yourself just instantiating the same resource block multiple times. A good example is adding domains to AWS Route 53 using the `aws_route53_zone` block. We are going to end up repeating creating a `aws_route53_zone` block multiple times. Like

```terraform
resource "aws_route53_zone" "production" {
  name    = var.prod_domain
  comment = "Production domain."

  tags = {
    Env = "production"
  }
}

resource "aws_route53_zone" "staging" {
  name    = var.staging_domain
  comment = "Staging domain."

  tags = {
    Env = "staging"
  }
}

resource "aws_route53_zone" "dev" {
  name    = var.dev_domain
  comment = "Dev domain."

  tags = {
    Env = "dev"
  }
}
```

We can also use the `dynamic` block and do it this way.

```terraform
locals {
  zones = {
    (var.prod_domain) = {
      comment = "Production domain."
      tags = {
        Env = "production"
      }
    },
    (var.staging_domain) = {
      comment = "Staging domain."
      tags = {
        Env = "staging"
      }
    },
    (var.dev_domain) = {
      comment = "Dev domain."
      tags = {
        Env = "dev"
      }
    },
  }
}

resource "aws_route53_zone" "zones" {
  for_each = local.zones

  name    = each.key
  comment = lookup(each.value, "comment", null)
  tags    = lookup(each.value, "tags", {})
}
```

## Reference

* [Terraform: dynamic block](https://www.terraform.io/docs/language/expressions/dynamic-blocks.html)
