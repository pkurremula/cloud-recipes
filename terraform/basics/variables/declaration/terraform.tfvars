server = {
  hostname = "saturn"
  count    = 4
  tags = {
    name              = "saturn"
    terraform_managed = "yes"
    team              = "data-science"
  }
  availability_zones = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c",
  ]
  enabled = true
}
