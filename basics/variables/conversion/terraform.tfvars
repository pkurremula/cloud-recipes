// --- Primitive Types ---

// Only accept booleans. Can't convert 0, 1, "0", or "1".
booleans = ["true", true, "false", false]

// Only accept numbers. Can't convert true, false, "true", or "false".
numbers = [0.12, "0.133", 5, "50"]

// String type is the most flexible type, accepts most types.
strings = [true, false, 0.12, 500, "text"]

// --- Complex Types ---

// Object and map are used interchangeably.

network_object = {
  region               = "us-west-2"
  cidr                 = "10.0.0.0/16"
  count                = 5
  private_subnet_cidrs = "10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24"
  public_subnet_cidrs  = "10.0.101.0/24, 10.0.102.0/24, 10.0.103.0/24"
}

network_map = {
  region               = "us-west-2"
  cidr                 = "10.0.0.0/16"
  count                = 5
  private_subnet_cidrs = "10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24"
  public_subnet_cidrs  = "10.0.101.0/24, 10.0.102.0/24, 10.0.103.0/24"
}

// List and tuple are used interchangeably.

list_values = [true, 15, "twenty"]

tuple_values = [true, 15, "twenty"]
