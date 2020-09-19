terraform {
  required_version = ">= 0.13.0"
}

locals {
  config_file = "config.json"
}

// Run the provisioner whenever the config file content is changed.
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

// Create a file on creation and remove the file on destroy.
resource "null_resource" "one_time" {
  provisioner "local-exec" {
    command = "echo 'Creating a lock file.'; touch lock"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Removing lock file.'; rm lock"
  }
}

