region                = "us-west-2"
prefix                = "dev"
env                   = "dev"
bastion_instance_type = "t3.nano"
test_instance_type    = "t3.nano"
public_subnets = [
  {
    suffix        = "public-subnet-a"
    az            = "us-west-2a"
    cidr          = "10.0.1.0/24"
    map_public_ip = true
  },
  {
    suffix        = "public-subnet-b"
    az            = "us-west-2b"
    cidr          = "10.0.2.0/24"
    map_public_ip = true
  },
  {
    suffix        = "public-subnet-c"
    az            = "us-west-2c"
    cidr          = "10.0.3.0/24"
    map_public_ip = true
  },
]

private_subnets = [
  {
    suffix = "private-subnet-a"
    az     = "us-west-2a"
    cidr   = "10.0.11.0/24"
  },
  {
    suffix = "private-subnet-b"
    az     = "us-west-2b"
    cidr   = "10.0.12.0/24"
  },
  {
    suffix = "private-subnet-c"
    az     = "us-west-2c"
    cidr   = "10.0.13.0/24"
  },
]
