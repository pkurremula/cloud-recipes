terraform {
  required_version = ">= 0.13.0"
}

locals {
  content = templatefile("${path.module}/main.sh", {
    enable_log = true
    port       = 443
    websites   = ["https://stackoverflow.com", "https://docker.com"]
  })
}

output "rendered_template_file" {
  value = local.content
}

