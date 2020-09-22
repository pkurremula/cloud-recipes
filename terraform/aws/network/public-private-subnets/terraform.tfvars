region = "us-west-2"
name   = "vpc-dev"
env    = "dev"
public_subnets = [
  {
    name          = "public-subnet-1"
    az            = "us-west-2a"
    cidr          = "10.0.1.0/24"
    map_public_ip = true
  },
  {
    name          = "public-subnet-2"
    az            = "us-west-2b"
    cidr          = "10.0.2.0/24"
    map_public_ip = true
  },
]

private_subnets = [
  {
    name = "private-subnet-1"
    az   = "us-west-2a"
    cidr = "10.0.11.0/24"
  },
  {
    name = "private-subnet-2"
    az   = "us-west-2b"
    cidr = "10.0.12.0/24"
  },
]
