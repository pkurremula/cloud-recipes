variable "booleans" {
  type = list(bool)
}

variable "strings" {
  type = list(string)
}

variable "numbers" {
  type = list(number)
}

variable "network_object" {
  description = "A network configuration as an object."
  type = object({
    region               = string
    cidr                 = string
    count                = number
    private_subnet_cidrs = string
    public_subnet_cidrs  = string
  })
}

variable "network_map" {
  description = "A network configuration as a map."
  type = map(string)
}

variable "list_values" {
  description = "A list of values."
  type = list(string)
}

variable "tuple_values" {
  description = "A tuple of values."
  type = tuple([bool, number, string])
}
