terraform {
  required_version = ">= 0.13.0"
}

locals {
  config_file = "config.json"
}

resource "null_resource" "config" {
  // Each time the content in config file is changed, checksum changes. The trigger causes this
  // resource to be replaced and trigger the local command to run.
  triggers = {
    checksum = filemd5("${path.module}/${local.config_file}")
  }

  provisioner "local-exec" {
    // `self` represents the parent. So `self` equivalent to `null_resource.config`.
    command = "echo '${local.config_file} changed. New value: ${self.triggers.checksum}'"
  }
}
