variable "server" {
  description = "A server configuration."
  type = object({
    hostname           = string
    count              = number
    tags               = map(string)
    availability_zones = list(string)
    enabled            = bool
  })
}
